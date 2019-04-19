<?php

/**
 * @name   grn_notification_data_row
 *  通知データ行出力
 *
 * @date   2004/11
 * @author IKEDA, Atsushi
 *
 * @param  array   notify          通知データ
 * @param  string  data_type       通知データ種別（'notify', 'whatsnew', 'history')
 * @param  int     subject_cols    標題の長さ
 * @param  int     abstract_cols   内容の長さ
 *
 * @option string  target          AタグのTARGET属性
 * @option boolean no_abstract     内容を表示しないフラグ
 * @option boolean no_name         名前を表示しないフラグ
 * @option boolean no_date         日時を表示しないフラグ
 * @option boolean checkbox        チェックボックスを表示するかどうか
 * @option boolean disabled        無効化するかどうか
 * @option string  fontsize        差出人 日時 備考のフォントサイズ
 *
 */

use grn\grn\access\service\AppAccess;

function smarty_function_grn_notification_data_row($params, &$smarty)
{

    $function_name = "grn_notification_data_row";

    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $login = $uum->getLoginUser();
    if ( ! is_object($login)) {
        cb_throw_error(E_COMMON_ACCOUNT_INVALIDATED);
    }

    require_once $smarty->_get_plugin_filepath('function', 'grn_link');
    require_once $smarty->_get_plugin_filepath('function', 'grn_image');
    require_once $smarty->_get_plugin_filepath('function', 'grn_user_name');
    require_once $smarty->_get_plugin_filepath('function', 'grn_sender_name');
    require_once $smarty->_get_plugin_filepath('function', 'grn_checkbox');
    require_once $smarty->_get_plugin_filepath('function', 'grn_date_format');
    require_once $smarty->_get_plugin_filepath('modifier', 'escape');

    if ( ! array_key_exists('notify', $params)) {
        return htmlspecialchars($function_name) . ": missing notify parameter";
    }

    if ($params['notify'] === '' || is_null($params['notify'])) {
        return htmlspecialchars($function_name) . ": missing notify parameter";
    }

    $notify = $params['notify'];
    assert('is_array( $notify )');
    unset($params['notify']);

    $str = '';

    $subject_page = null;
    $subject_fragment = null;
    $subject_postfix = null;
    $abstract_page = null;
    $abstract_fragment = null;
    $abstract_postfix = null;
    $url_params = null;
    $action_id = (array_key_exists('action_id', $notify))
        ? $notify['action_id'] : null;
    $module_id = (array_key_exists('module_id', $notify))
        ? $notify['module_id'] : null;
    $sub_module_id = (array_key_exists('sub_module_id', $notify))
        ? $notify['sub_module_id'] : '';
    $unique_id = (array_key_exists('unique_id', $notify))
        ? $notify['unique_id'] : null;
    $org_data = (array_key_exists('org_data', $notify))
        ? $notify['org_data'] : null;
    $status = (array_key_exists('status', $notify))
        ? $notify['status'] : null;
    $popup = (array_key_exists('popup', $notify)) ? $notify['popup']
        : false;
    $attached = (array_key_exists('attached', $notify))
        ? $notify['attached'] : false;

    // checkbox
    $checkbox = @ $params['checkbox'];
    unset($params['checkbox']);

    // disabled
    $disabled = @ $params['disabled'];
    unset($params['disabled']);

    // 標題の長さ
    $subject_cols = @ $params['subject_cols'];
    unset($params['subject_cols']);

    // スペース名の長さ
    $space_cols = @ $params['space_cols'];
    unset($params['space_cols']);

    // 内容の長さ
    $abstract_cols = @ $params['abstract_cols'];
    unset($params['abstract_cols']);

    // 名前の長さ
    $name_cols = @ $params['name_cols'];
    unset($params['name_cols']);

    // target
    $target = @ $params['target'];
    unset($params['target']);

    // fontsize
    $fontsize = @ $params['fontsize'];
    unset($params['fontsize']);

    // 表示しないカラム指定
    if (array_key_exists('no_space_name', $params)) {
        $no_space_name = $params['no_space_name'];
        unset($params['no_space_name']);
    }
    if (array_key_exists('no_abstract', $params)) {
        $no_abstract = $params['no_abstract'];
        unset($params['no_abstract']);
    }
    if (array_key_exists('no_name', $params)) {
        $no_name = $params['no_name'];
        unset($params['no_name']);
    }
    if (array_key_exists('no_date', $params)) {
        $no_date = $params['no_date'];
        unset($params['no_date']);
    }

    $notify['users_info'] = [];
    if (isset($params['users_info'])) {
        $notify['users_info'] = $params['users_info'];
    }

    if (array_key_exists('is_portlet', $params)) {
        $is_portlet = $params['is_portlet'];
        unset($params['is_portlet']);
    }

    /////////////////////////////////////////////
    // 通知元アプリモジュール取得
    $id_array = explode('.', $module_id);

    // Ogre内アプリかどうか
    if (is_array($id_array) && (strcasecmp($id_array[0], 'grn') === 0)) {
        if (count($id_array) > 1) {
            // アプリロケータ取得
            require_once 'grn/application.csp';
            $app_locator = GRN_ApplicationLocator::instance();
            require_once("notification/application.csp");
            $notification_app
                = $app_locator->getInstance(GRN_NOTIFICATION_APP_ID);
            assert('! is_null( $notification_app )');

            // 通知元アプリモジュール取得
            $app_id = $id_array[1];
            $app_full_id = substr($module_id, 4);

            $apps =& $notification_app->getApplicationList(false);
            if (is_array($apps) && isset($apps[$app_id])) {
                // ページ情報取得
                $page_info = $apps[$app_id]->getNotificationPageInfo($login,
                    $app_full_id, $unique_id, $org_data, $status, $action_id,
                    $sub_module_id);
                if (is_array($page_info)) {
                    if (isset($page_info['subject_page'])
                        && isset($page_info['subject_icon'])
                    ) {
                        $subject_page = $page_info['subject_page'];
                        $subject_fragment = @ $page_info['subject_fragment'];
                        $subject_postfix = @ $page_info['subject_postfix'];
                        $subject_icon = $page_info['subject_icon'];

                        if (array_key_exists('url_params', $page_info)
                            && is_array($page_info['url_params'])
                            && (count($page_info['url_params']) > 0)
                        ) {
                            $url_params = $page_info['url_params'];
                        }
                    }

                    if (array_key_exists('isBlankDisplayAbstract', $page_info)
                        && $page_info['isBlankDisplayAbstract']
                    ) {
                        // 内容をブランクに置換($notify['abstract']に設定された「登録」「変更」「削除」「確定」ステータス文言を隠すことが目的)
                        $notify['abstract'] = '';
                    }

                    if (isset($page_info['abstract_page'])) {
                        // 内容欄のURL
                        $abstract_page = $page_info['abstract_page'];
                        $abstract_fragment = @ $page_info['abstract_fragment'];
                        $abstract_postfix = @ $page_info['abstract_postfix'];
                    }
                    if (isset($page_info['abstract_icon'])) {
                        // 内容欄のアイコン
                        $abstract_icon = $page_info['abstract_icon'];
                    }
                    if (isset($page_info['sender_page'])) {
                        // 送信者のURL
                        $sender_page = $page_info['sender_page'];
                        $sender_fragment = @ $page_info['sender_fragment'];
                        $sender_postfix = @ $page_info['sender_postfix'];
                    }
                    if (isset($page_info['sender_icon'])) {
                        // 送信者のアイコン
                        $sender_icon = $page_info['sender_icon'];
                    }
                    $image_direct = @ $page_info['image_direct'];
                }
            }
        }
    } // 外部通知
    else {
    }

    if (is_null($subject_page) || (strlen($subject_page) == 0)
        || is_null($subject_icon)
        || (strlen($subject_icon) == 0)
    ) {
        // あってはならない
        $disabled = true;
    }

    // URLに必ず付加するID
    $data_type = @ $params['data_type'];
    unset($params['data_type']);
    if ( ! is_null($data_type) && ($data_type === 'history')) {
        $url_params['nhid'] = $notify['id'];
    } else {
        $url_params['nid'] = $notify['id'];
    }

    /////////////////////////////////////////////
    // 標題欄
    $str .= smarty_function_grn_notification_data_row_subject($notify,
        $data_type, $subject_page, $subject_fragment, $subject_postfix,
        $subject_icon, $url_params, $subject_cols, $status, $attached, $popup,
        $target, $checkbox, $disabled, $image_direct, $smarty);

    /////////////////////////////////////////////
    // スペース名欄
    require_once('space/GrnSpaceApplication.csp');
    $available_space
        = AppAccess::isAppAvailableInternalAccess(GrnSpaceApplication::GRN_SPACE_APPLICATION_ID);
    if ($available_space) {
        if (empty($no_space_name) || ! $no_space_name) {
            $str .= smarty_function_grn_notification_data_row_space($notify,
                $url_params, $smarty, $space_cols);
        } else {
            if (empty($is_portlet) || ! $is_portlet) {
                $str .= "<td></td>";
            }
        }
    }

    /////////////////////////////////////////////
    // 内容欄
    if (empty($no_abstract) || ! $no_abstract) {
        $abstract_url_params = $url_params;
        if ($abstract_page == 'cabinet/download') {
            if ($login && cb_is_need_download_ticket()) {
                require_once('grn/ticket.csp');
                $abstract_url_params['ticket']
                    = GRN_Ticket::create($login->getOID());
            }
        }
        $str .= smarty_function_grn_notification_data_row_abstract($notify,
            $abstract_page, $abstract_fragment, $abstract_postfix,
            $abstract_icon, $abstract_url_params, $abstract_cols, $disabled,
            $smarty);
    } else {
        if (empty($is_portlet) || ! $is_portlet) {
            $str .= "<td></td>";
        }
    }

    /////////////////////////////////////////////
    // 名前欄
    if (empty($no_name) || ! $no_name) {
        $app_id = explode('.', $module_id);
        $str .= smarty_function_grn_notification_data_row_name($notify,
            $name_cols, $fontsize, $smarty, $app_id[1]);
    } else {
        if (empty($is_portlet) || ! $is_portlet) {
            $str .= "<td></td>";
        }
    }

    /////////////////////////////////////////////
    // 日時欄
    if (empty($no_date) || ! $no_date) {
        $str .= smarty_function_grn_notification_data_row_datetime($notify,
            $fontsize, $smarty);
    } else {
        if (empty($is_portlet) || ! $is_portlet) {
            $str .= "<td></td>";
        }
    }

    return $str;
}

/**
 * @name   smarty_function_grn_notification_data_row_subject
 *  通知データ行の標題出力
 *
 * @date   2004/11
 * @author IKEDA, Atsushi
 *
 * @param  array   notify          通知データ
 * @param  string  data_type       通知データ種別（'notify', 'whatsnew', 'history')
 * @param  string  page            ページ名
 * @param  string  url_fragment    URL fragment
 * @param  string  url_postfix     URL postmix
 * @param  string  icon            アイコン名
 * @param  array   url_params      URLパラメータ
 * @param  int     cols            文字列長
 * @param  string  status          状態 ('read', 'unread', 'update')
 *
 * @option boolean attached        添付ありかどうか
 * @option boolean popup           ポップアップするかどうか
 * @option string  target          AタグのTARGET属性
 * @option boolean checkbox        チェックボックスを表示するかどうか
 * @option boolean image_direct
 * @option boolean disabled        無効化するかどうか
 *
 */
function smarty_function_grn_notification_data_row_subject(
    & $notify,
    $data_type,
    $page,
    $url_fragment,
    $url_postfix,
    $icon,
    & $url_params,
    $cols,
    $status,
    $attached,
    $popup,
    $target,
    $checkbox,
    $disabled,
    $image_direct = null,
    & $smarty
) {
    $str = '';
    if (isset($notify['subject'])) {
        $subject = $notify['subject'];
    } else {
        $subject = '';
    }

    if (isset($notify['subject_f'])) {
        $subject_f = htmlspecialchars($notify['subject_f']);
    } else {
        $subject_f = '';
    }

    if (isset($notify['subject_b'])) {
        $subject_b = htmlspecialchars($notify['subject_b']);
    } else {
        $subject_b = '';
    }

    if (is_null($page)) {
        $page = '';
        $disabled = true;
    }
    if (is_null($icon)) {
        $icon = 'spacer20';
    }

    $page_direct = false;
    if (isset($notify['subject_url']) && is_string($notify['subject_url'])
        && 0 < strlen($notify['subject_url'])
    ) {
        $disabled = false;
        if (isset($notify['auto_confirm'])
            && 0 < strlen($notify['auto_confirm'])
        ) {
            $page = 'notification/notify_redirect';
            $url_params['ct'] = 's';
        } else {
            $parsed_url = parse_url($notify['subject_url']);
            if (array_key_exists('scheme', $parsed_url)) {
                if ('http' == $parsed_url['scheme']
                    || 'https' == $parsed_url['scheme']
                ) {
                    $page = htmlspecialchars($notify['subject_url']);
                    $page_direct = true;
                }
            } else {
                $page = htmlspecialchars($notify['subject_url']);
            }
        }
    }

    $image = null;

    if (is_null($image_direct)) {
        if (isset($notify['subject_icon']) && is_string($notify['subject_icon'])
            && 0 < strlen($notify['subject_icon'])
        ) {
            $parsed_url = parse_url($notify['subject_icon']);
            if (array_key_exists('scheme', $parsed_url)) {
                $icon = null;
                if ('http' == $parsed_url['scheme']
                    || 'https' == $parsed_url['scheme']
                ) {
                    $image = htmlspecialchars($notify['subject_icon']);
                    $image_direct = true;
                }
            } else {
                $icon = htmlspecialchars($notify['subject_icon']);
            }
        }
    } else {
        $image = $icon;
    }

    // GTM-1680
    $subModuleId = cb_at($notify, "sub_module_id", "");
    if ($subModuleId == GRN_FACILITY_APPROVAL_SUB_MODULE_ID) {
        $image = cb_msg(GRN_NOTIFICATION_MODULE_ID,
            GRN_NOTIFICATION_SCHEDULE_ICON_CODE_FACILITY_APPROVAL);
        $image = "{$image}.png";
        /**
         * Remove some unnecessary parameters for this notification type.
         */
        $unset_parameters = ["uid", "bdate"];
        foreach ($unset_parameters as $value) {
            unset($url_params[$value]);
        }
    }
    // End GTM-1680

    if (isset($notify['confirm_required'])) {
        // チェックして既読が許可されていないか
        $confirm_required = $notify['confirm_required'];
    } else {
        $confirm_required = false;
    }

    if ($checkbox) {
        $str .= '<td nowrap width="1%">';
        if ($confirm_required
            || $data_type === GRN_NOTIFICATION_DATA_TYPE_HISTORY
        ) {
            $str .= '&nbsp;';
        } else {
            $str .= smarty_function_grn_checkbox([
                'name'  => 'notification[]',
                'id'    => 'notification',
                'value' => $notify['id']
            ], $smarty);
        }
        $str .= '</td>';
    }

    $str .= '<td nowrap>';
    if (strlen($subject_f) > 0) {
        $str .= '<small>' . $subject_f . '</small> ';
    }

    $unread = ($status === 'unread');

    // URLパラメータに追加
    $url_params['caption'] = $subject;
    $url_params['truncated_caption'] = $cols;
    $url_params['page'] = $page;
    $url_params['page_direct'] = $page_direct;
    $url_params['fragment'] = $url_fragment;
    $url_params['postfix'] = $url_postfix;
    $url_params['target'] = $target;
    $url_params['unread'] = $unread;
    $url_params['disabled'] = $disabled;
    $url_params['image'] = $image ? $image : "{$icon}.gif";
    $url_params['image_direct'] = $image_direct;

    // リンク表示
    $str .= smarty_function_grn_link($url_params, $smarty);

    if (strlen($subject_b) > 0) {
        $str .= ' <font size="-1">' . $subject_b . '</font>';
    }

    // ポップアップウィンドウ
    if ($popup) {
        $popup_image = smarty_function_grn_image(['image' => 'popup20.gif'],
            $smarty);
        if ($disabled) {
            $str .= '&nbsp;' . $popup_image;
        } else {
            if ($page_direct) {
                $str .= '&nbsp;<a href="' . $page . '" target="_blank">'
                        . $popup_image . '</a>';
            } else {
                $str .= '&nbsp;<a href="' . cb_pageurl($page, $url_params,
                        $url_fragment, $url_postfix) . '" target="_blank">'
                        . $popup_image . '</a>';
            }
        }
    }

    $str .= '</td>';

    return $str;
}

/**
 * @name smarty_function_grn_notification_data_row_space
 *  通知データ行のスペース名出力
 *
 * @param  array   notiry          notification data
 *
 * @return string  str             HTML
 */
function smarty_function_grn_notification_data_row_space(
    $notify,
    $url_params,
    $smarty,
    $space_cols
) {
    $trim_string = '...';
    $str = '<td nowrap>';
    if (isset($notify['space_page_url']) && isset($notify['space_icon_url'])
        && isset($notify['space_name'])
    ) {
        $str .= '&nbsp;<a href="' . cb_pageurl($notify['space_page_url'],
                ['spid' => $notify['space_id']]) . '">';
        $str .= '<img src="' . htmlspecialchars($notify['space_icon_url'])
                . '" border="0" class="notify_icon" >';
        if (isset($space_cols) && strlen($notify['space_name']) > $space_cols) {
            $title = mb_strimwidth($notify['space_name'], 0, $space_cols,
                $trim_string);
            $str .= htmlspecialchars($title);
        } else {
            $str .= htmlspecialchars($notify['space_name']);
        }
        $str .= '</a>';
    } else {
        if (isset($space_cols) && strlen($notify['space_name']) > $space_cols) {
            $title = mb_strimwidth($notify['space_name'], 0, $space_cols,
                $trim_string);
            $str .= htmlspecialchars($title);
        } else {
            $str .= htmlspecialchars($notify['space_name']);
        }
    }
    $str .= '</td>';

    return $str;
}

/**
 * @name   smarty_function_grn_notification_data_row_abstract
 *  通知データ行の内容出力
 *
 * @date   2004/11
 * @author IKEDA, Atsushi
 *
 * @param  array   notify          通知データ
 * @param  string  page            ページ名
 * @param  string  url_fragment    URL fragment
 * @param  string  url_postfix     URL postmix
 * @param  string  icon            アイコン名
 * @param  array   url_params      URLパラメータ
 * @param  int     cols            文字列長
 *
 * @option boolean disabled        無効化するかどうか
 *
 */
function smarty_function_grn_notification_data_row_abstract(
    & $notify,
    $page,
    $url_fragment,
    $url_postfix,
    $icon,
    & $url_params,
    $cols,
    $disabled,
    & $smarty
) {
    $str = '<td nowrap>';
    if (isset($notify['abstract'])) {
        $abstract = $notify['abstract'];
    } else {
        $abstract = '';
    }

    if (isset($notify['abstract_f'])) {
        $abstract_f = htmlspecialchars($notify['abstract_f']);
    } else {
        $abstract_f = '';
    }

    if (isset($notify['abstract_b'])) {
        $abstract_b = htmlspecialchars($notify['abstract_b']);
    } else {
        $abstract_b = '';
    }

    if ((strlen($abstract) == 0) && (strlen($abstract_f) == 0)
        && (strlen($abstract_b) == 0)
    ) {
        if (is_null($icon)) {
            // 空白を出力して抜ける
            $str .= '&nbsp;</td>';

            return $str;
        }
    }

    if (strlen($abstract_f) > 0) {
        $str .= '<font size="-1">' . $abstract_f . '</font> ';
    }

    if (is_null($page)) {
        $page = '';
        $disabled = true;
    }
    if (is_null($icon)) {
        $icon = '';
    }

    $page_direct = false;
    if (isset($notify['abstract_url']) && is_string($notify['abstract_url'])
        && 0 < strlen($notify['abstract_url'])
    ) {
        $disabled = false;
        if (isset($notify['auto_confirm'])
            && 0 < strlen($notify['auto_confirm'])
        ) {
            $page = 'notification/notify_redirect';
            $url_params['ct'] = 'a';
        } else {
            $parsed_url = parse_url($notify['abstract_url']);
            if (array_key_exists('scheme', $parsed_url)) {
                if ('http' == $parsed_url['scheme']
                    || 'https' == $parsed_url['scheme']
                ) {
                    $page = htmlspecialchars($notify['abstract_url']);
                    $page_direct = true;
                }
            } else {
                $page = htmlspecialchars($notify['abstract_url']);
            }
        }
    }

    $image = null;
    $image_direct = false;
    if (isset($notify['abstract_icon']) && is_string($notify['abstract_icon'])
        && 0 < strlen($notify['abstract_icon'])
    ) {
        $parsed_url = parse_url($notify['abstract_icon']);
        if (array_key_exists('scheme', $parsed_url)) {
            $icon = null;
            if ('http' == $parsed_url['scheme']
                || 'https' == $parsed_url['scheme']
            ) {
                $image = htmlspecialchars($notify['abstract_icon']);
                $image_direct = true;
            }
        } else {
            $icon = htmlspecialchars($notify['abstract_icon']);
        }
    }

    // URLパラメータに追加
    $url_params['caption'] = $abstract;
    $url_params['truncated_caption'] = $cols;
    $url_params['page'] = $page;
    $url_params['page_direct'] = $page_direct;
    $url_params['fragment'] = $url_fragment;
    $url_params['postfix'] = $url_postfix;
    $url_params['target'] = "";
    $url_params['unread'] = "";
    $url_params['disabled'] = $disabled;
    $url_params['image'] = $image ? $image
        : ($icon ? "{$icon}.gif" : '');
    $url_params['image_direct'] = $image_direct;

    // リンク表示
    $str .= smarty_function_grn_link($url_params, $smarty);
    if (strlen($abstract_b) > 0) {
        $str .= ' <font size="-1">' . $abstract_b . '</font>';
    }

    $str .= '</td>';

    return $str;
}

/**
 * @name   smarty_function_grn_notification_data_row_name
 *                       通知データ行の名前出力
 *
 * @date   2004/11
 * @author IKEDA, Atsushi
 *
 * @param  array $notify 通知データ
 * @param  int   $cols   文字列長
 *
 */
function smarty_function_grn_notification_data_row_name(
    & $notify,
    $cols,
    $fontsize,
    & $smarty,
    $app_id
) {
    $str = '<td nowrap ' . 'style="' . htmlspecialchars($fontsize) . '"' . '>';

    $sender_name = null;
    if (array_key_exists('sender_name', $notify)) {
        $sender_name = $notify['sender_name'];
    }

    $sender_id = null;
    if (array_key_exists('sender_id', $notify)) {
        $sender_id = $notify['sender_id'];
    }

    $sender_url = null;
    if (array_key_exists('sender_url', $notify)) {
        $sender_url = $notify['sender_url'];
    }
    $nolink = null;
    if (isset($notify['nolink'])) {
        $nolink = true;
    }
    $users_info = [];
    if (isset($notify['users_info'])) {
        $users_info = $notify['users_info'];
    }

    // sender_id未指定はメールまたは外部システムからの通知
    if ( ! is_numeric($sender_id) || $sender_id < 1) {
        if ( ! is_null($sender_url) && ! empty($sender_url)) {
            $str .= '<a href="' . $sender_url . '">';
        }

        $no_image = false;
        if ($app_id == 'bulletin') {
            require_once('bulletin/notification.csp');
            if ($sender_id
                == GRN_Bulletin_NotificationListener::MANUALLY_ENTER_SENDER_ID
            ) {
                $no_image = true;
            }
        }

        if ( ! is_null($cols)) {
            $str .= smarty_function_grn_sender_name([
                'name'      => $sender_name,
                'truncated' => $cols,
                'icon'      => 'user20',
                'no_image'  => $no_image
            ], $smarty);
        } else {
            $str .= smarty_function_grn_sender_name([
                'name'     => $sender_name,
                'icon'     => 'user20',
                'no_image' => $no_image
            ], $smarty);
        }

        if ( ! is_null($sender_url) && ! empty($sender_url)) {
            $str .= '</a>';
        }
    } // Ogre内アプリ
    else {
        if ( ! is_null($cols)) {
            $str .= smarty_function_grn_user_name([
                'uid'        => $sender_id,
                'truncated'  => $cols,
                'nolink'     => $nolink,
                'name'       => $sender_name,
                'users_info' => $users_info,
                'app_id'     => $app_id
            ], $smarty);
        } else {
            $str .= smarty_function_grn_user_name([
                'uid'        => $sender_id,
                'nolink'     => $nolink,
                'name'       => $sender_name,
                'users_info' => $users_info,
                'app_id'     => $app_id
            ], $smarty);
        }
    }

    $str .= '</td>';

    return $str;
}

/**
 * @name   smarty_function_grn_notification_data_row_datetime
 *  通知データ行の日時出力
 *
 * @date   2004/11
 * @author IKEDA, Atsushi
 *
 * @param  array   notify          通知データ
 *
 */
function smarty_function_grn_notification_data_row_datetime(
    & $notify,
    $fontsize,
    & $smarty
) {
    return '<td nowrap ' . 'style="' . htmlspecialchars($fontsize) . '"' . '>'
           . smarty_function_grn_date_format([
            'date'   => $notify['timestamp'],
            'format' => 'DateTimeCompact'
        ], $smarty) . '</td>';
}



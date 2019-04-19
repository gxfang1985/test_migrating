<?php
require_once 'fw/i18n.csp';

/**
 * @name   grn_notification_number_link
 *  通知の件数表示
 *
 * @date   2004/11
 * @author IKEDA, Atsushi
 *
 * @param  string  module_id       モジュールID
 * @param  int     count           データ数
 *
 * @option string  target          AタグのTARGET属性
 * @option boolean popup           ポップアップ表示するかどうか
 * @option boolean disabled        無効化するかどうか
 *
 */

function smarty_function_grn_notification_number_link($params, &$smarty)
{
    $function_name = "grn_notification_number_link";

    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $login =& $uum->getLoginUser();
    if ( ! is_object($login)) {
        cb_throw_error(E_COMMON_ACCOUNT_INVALIDATED);
    }

    require_once $smarty->_get_plugin_filepath('modifier', 'escape');

    if ( ! array_key_exists('module_id', $params)) {
        return htmlspecialchars($function_name)
               . ": missing module_id parameter";
    }

    if ($params['module_id'] === '' || is_null($params['module_id'])) {
        return htmlspecialchars($function_name)
               . ": missing module_id parameter";
    }
    if ( ! array_key_exists('count', $params)) {
        return htmlspecialchars($function_name) . ": missing count parameter";
    }

    if ($params['count'] === '' || is_null($params['count'])) {
        return htmlspecialchars($function_name) . ": missing count parameter";
    }

    $module_id = $params['module_id'];
    assert('! is_null( $module_id )');
    unset($params['module_id']);

    $count = $params['count'];
    assert('! is_null( $count )');
    unset($params['count']);

    $str = '';

    $app_name = '';
    $page = null;
    $fragment = null;
    $postfix = null;
    $icon = null;
    $url_params = null;

    // popup
    $popup = @ $params['popup'];
    unset($params['popup']);

    // disabled
    $disabled = @ $params['disabled'];
    unset($params['disabled']);

    // target
    $target = @ $params['target'];
    $target_area = $target ? (' target="' . htmlspecialchars($target) . '"')
        : '';
    unset($params['target']);

    /////////////////////////////////////////////
    // 通知元アプリモジュール取得
    $id_array = explode('.', $module_id);

    // Ogre アプリかどうか
    if (is_array($id_array)
        && (strcasecmp($id_array[0], 'grn') === 0
            || strcasecmp($id_array[0], 'x') === 0)
    ) {
        if (count($id_array) > 1) {
            // アプリロケータ取得
            require_once 'grn/application.csp';
            $app_locator = GRN_ApplicationLocator::instance();
            require_once("notification/application.csp");
            $notification_app
                =& $app_locator->getInstance(GRN_NOTIFICATION_APP_ID);
            assert('! is_null( $notification_app )');

            // 外部アプリケーション管理ロジックを取得する
            $app_manager =& $notification_app->getOutsideApplicationManager();

            // 通知元アプリモジュール取得
            $app_id = $id_array[1];
            $app_full_id = substr($module_id, 4);

            $apps_list[] = $notification_app->getApplicationList(false);
            $apps_list[] = $app_manager->getAllList();
            foreach (array_keys($apps_list) as $apps_id) {
                $apps =& $apps_list[$apps_id];
                if (is_array($apps) && array_key_exists($app_id, $apps)
                    && ! is_null($apps[$app_id])
                ) {
                    // アプリ名
                    $app = $apps[$app_id];
                    if ($module_id !== $app->getModuleId()) {
                        continue;
                    }

                    $app_name = $app->getName();

                    // 件数表示用ページ情報取得
                    if (method_exists($app, 'getNotificationIndexPageInfo')) {
                        // 各アプリが特殊な一覧へ飛びたい場合
                        $page_info = $app->getNotificationIndexPageInfo($login,
                            $app_id);
                        if (is_array($page_info)) {
                            if (array_key_exists('page', $page_info)
                                && ! is_null($page_info['page'])
                                && array_key_exists('icon', $page_info)
                                && ! is_null($page_info['icon'])
                            ) {
                                $page = $page_info['page'];
                                $fragment = @ $page_info['fragment'];
                                $postfix = @ $page_info['postfix'];
                                $icon = $page_info['icon'];

                                if (array_key_exists('url_params', $page_info)
                                    && is_array($page_info['url_params'])
                                    && (count($page_info['url_params']) > 0)
                                ) {
                                    $url_params = $page_info['url_params'];
                                }
                            }
                        }
                    }

                    if ( ! is_string($page) || (strlen($page) == 0)
                         || ! is_string($icon)
                         || (strlen($icon) == 0)
                    ) {
                        // 未確認の通知一覧画面へ飛ぶ
                        $page = $params['page'] ??
                                'notification/index';
                        $fragment = null;
                        $postfix = null;
                        $url_params
                            = [
                            'module_id' => smarty_modifier_escape($module_id,
                                'url')
                        ];
                        $url_params['is_to_me'] = $params['is_to_me'] ?? '';
                        $url_params['read'] = $params['is_read'] ?? '';
                        $icon = $app->getConfig('icon20');
                    }
                }
            }
        }
    }

    if ( ! is_string($page)
         || (strlen($page)
             == 0) /*|| ! is_string( $icon ) || ( strlen( $icon ) == 0 )*/
    ) {
        // あってはならない
        $disabled = true;
    }

    if ($count >= GRN_NOTIFICATION_WHATSNEW_DATA_LIMIT) {
        $count = cb_msg('grn.notification', 'data_limit_preffix');
        $count .= GRN_NOTIFICATION_WHATSNEW_LIMIT_OVER_DISPLAY;
        $count .= cb_msg('grn.notification', 'data_limit_suffix');
    }

    if ($disabled) {
        $str .= '<a class="' . htmlspecialchars($icon) . '" name="#"'
                . $target_area . '>';
        $str .= cb_msg('grn.notification', 'number_link',
            ['data_name' => $app_name, 'num' => $count]);
        $str .= '</a> ';
        $str .= cb_msg('grn.notification', 'data_exists_suffix');
    } else {
        $str .= '<a class="' . htmlspecialchars($icon) . '" href="'
                . cb_pageurl($page, $url_params, $fragment, $postfix) . '"'
                . $target_area . '>';
        $str .= cb_msg('grn.notification', 'number_link',
            ['data_name' => $app_name, 'num' => $count]);
        $str .= '</a> ';
        $str .= cb_msg('grn.notification', 'data_exists_suffix');
    }

    return $str;
}



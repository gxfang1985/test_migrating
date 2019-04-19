<?php

/**
 * メールの差出人を表示する部品
 *
 * @name        grn_mail_name
 * @description 名前およびE^Mailを表示する
 * @description typeによって'送受信記録画面または作成画面へのリンクとアイコンを表示する
 *
 * @param  string  type        'history' : 送受信記録, 'send' : メール送信
 * @param  string  iid         送受信記録ID
 * @param  string  aid         アカウントID
 * @param  string  cid         フォルダID
 * @param  string  mid         メールID
 * @param  string  name        nick name
 * @param  string  email       email address（urlencodeを通したものを渡す)
 * @param  string  truncated   最大長
 * @param  boolean nolink
 * @param  boolean noimage
 * @param  integer show_faddress 1: show only one first address, 0: show all
 */

function smarty_function_grn_mail_name($params, &$smarty)
{
    require_once $smarty->_get_plugin_filepath('function',
        'grn_mail_name_address');

    //-- the function name
    $function_name = 'grn_mail_name';

    $data_type = array_key_exists('data_type', $params) ? $params['data_type']
        : '';
    if ( ! is_string($data_type)) {
        $data_type = '';
    }

    $type = array_key_exists('type', $params) ? $params['type'] : '';
    if (array_key_exists('name_format', $params)) {
        $name_format = $params['name_format'];
    } else {
        $name_format = 'full';
    }

    $show_address = array_key_exists('show_address', $params)
        ? $params['show_address'] : '';

    $name = array_key_exists('name', $params) ? $params['name'] : '';
    if (is_null($name)) {
        $name = '';
    }

    /*
        $email = @ $params['email'];
        if( is_null( $email ) )
            $email = '';
    */
//    $iid = @ $params['iid'];
    $aid = array_key_exists('aid', $params) ? $params['aid'] : '';
    $cid = array_key_exists('cid', $params) ? $params['cid'] : '';
    $mid = array_key_exists('mid', $params) ? $params['mid'] : '';
    $nolink = array_key_exists('nolink', $params) ? $params['nolink']
        : '';
    $noimage = array_key_exists('noimage', $params) ? $params['noimage']
        : '';
    $no_htmlencode = array_key_exists('no_htmlencode', $params)
        ? $params['no_htmlencode'] : '';
    $page = array_key_exists('page', $params) ? $params['page'] : '';
    $show_faddress = array_key_exists('show_faddress', $params)
        ? $params['show_faddress'] : 0;

    if (isset($params['hid'])) {
        // 送受信記録のアドレス情報データIDからアドレス情報を取得
        // 遷移元のE-Mailと一致するアドレスには sf フラグを付けるため
        require_once('mail/address_history.csp');
        $address_history_logic = GRN_Mail_AddressHistoryLogic::getInstance();

        $histroy_info_id = $params['hid'];
        $histroy_info_data
            = $address_history_logic->getAddressInfoData($histroy_info_id,
            false);
        $history_email = $histroy_info_data['email'];
    } else {
        $history_email = null;
    }

    $three_pane = null;
    if (array_key_exists('3pane', $params)) {
        $three_pane = $params['3pane'];
        unset($params['3pane']);
    }

    if (array_key_exists('truncated', $params)) {
        $truncated = intval($params['truncated']);
    } else {
        $truncated = -1;
    }

    // -------------------------
    $return_string = '';
    $display_name = '';

    $image = '';

    if ($type === 'history') {
        $image = 'mailhistory20.gif';
    } elseif ($type === 'send') {
        $image = '';
    } else {
        $nolink = true;
    }

    if ( ! is_null($noimage) && (strlen($noimage) > 0) && $noimage) {
        $image = '';
    }

    if ((is_array($name) && count($name) > 0) || strlen($name) > 0) {
        if ($name_format == 'name') {
            $names = GRN_Mail_Utility::static_formatAddressString($name, true,
                false, true, false, 'array');
        } elseif ($name_format == 'email') {
            $names = GRN_Mail_Utility::static_formatAddressString($name, false,
                false, true, false, 'array');
        } else {
            $names = GRN_Mail_Utility::static_formatAddressString($name, true,
                false, true, false, 'array');
        }

        if (is_array($names) && (count($names) > 0)) {
            $full = '';
            $name = '';
            $length = 0;
            $counter = 0;
            foreach (array_keys($names) as $key) {
                $temp_array =& $names[$key];

                $email = $temp_array['email'];
                if ($name_format == 'name') {
                    $display_name = $temp_array['name'];
                    if (strlen($display_name) == 0) {
                        $display_name = $email;
                    }
                } elseif ($name_format == 'email') {
                    $display_name = $email;
                } else {
                    $name_exists = false;
                    $display_name = '';
                    $temp_name = $temp_array['name'];
                    $len = strlen($temp_name);
                    if ($len > 0) {
                        // ニックネームに""を付ける
                        $temp_name
                            = GRN_Mail_Utility::static_addNameQuotation($temp_name,
                            'add');
                        $display_name = $temp_name;
                        $name_exists = true;
                    }

                    $len = strlen($email);
                    if ($len > 0) {
                        if ($name_exists) {
                            $display_name .= ' ';

                            // ニックネームがある場合は<>を付ける
                            $email
                                = GRN_Mail_Utility::static_addEmailBracket($email,
                                'add');

                            if (is_string($history_email)) {
                                $history_email
                                    = GRN_Mail_Utility::static_addEmailBracket($history_email,
                                    'add');
                            }
                        }

                        $display_name .= $email;
                    }
                }

                if ($truncated != -1) {
                    $display_name = mb_strimwidth($display_name, 0, $truncated,
                        '...');
                }

                if ($counter > 0) {
                    $return_string .= ', ';
                    $length += 2;
                }

                $sf = (is_string($history_email)
                       && (strcasecmp($email, $history_email) == 0))
                    ? 1 : null;
                $return_string .= smarty_function_grn_mail_name_link($type,
                    $image, $nolink, $no_htmlencode, $display_name, $email,
                    $aid, $cid, $mid, $sf, $three_pane, $smarty);

                if ($show_address) {
                    // アドレス帳への参照/登録リンクを表示する
                    $return_string .= smarty_function_grn_mail_name_address(
                        [
                            'sk'         => $data_type . $counter,
                            'name'       => $temp_name,
                            'email'      => $email,
                            '3pane'      => $three_pane,
                            'page'       => $page,
                            'url_params' => ['mid' => $mid]
                        ],
                        $smarty);
                }

                $counter++;
                $length += strlen($display_name);
                if (($truncated != -1) && ($length >= $truncated)) {
                    break;
                }
                if ($show_faddress) {
                    break;
                }
            }
        }
    }


    return $return_string;
}


/////////////////////////////////////////////////////////////////////////////////
//
function smarty_function_grn_mail_name_link(
    $type,
    $image,
    $nolink,
    $no_htmlencode,
    $display_name,
    $email,
    $aid,
    $cid,
    $mid,
    $sf,
    $three_pane,
    &$smarty
) {
    require_once($smarty->_get_plugin_filepath('function', 'grn_image'));
    $image_params = ['image' => $image];

    if ($type === 'history' && $three_pane) {
        $image_html = '<span class="mailhistory_grn"></span>';
    } else {
        $image_html = $image ? smarty_function_grn_image($image_params, $smarty)
            : '';
    }

    //-- create return_string
    if ($nolink) {
        if ( ! $no_htmlencode) {
            return $image_html . htmlspecialchars($display_name);
        } else {
            return $image_html . $display_name;
        }
    } else {
        if ($type === 'history') {
            // 送受信記録画面へ
            // E-Mailを渡す
            $url = cb_pageurl('mail/exchange_history', [
                'aid'   => $aid,
                'cid'   => $cid,
                'mid'   => $mid,
                'email' => $email,
                'sf'    => $sf
            ]);
        } else {
            // 送信画面へ
            $url = cb_pageurl('mail/send',
                ['aid' => $aid, 'cid' => $cid, 'to' => $display_name]);
        }

        if ( ! $no_htmlencode) {
            return '<a href="' . $url . '">' . $image_html
                   . htmlspecialchars($display_name) . '</a>';
        } else {
            return '<a href="' . $url . '">' . $image_html . $display_name
                   . '</a>';
        }
    }
}



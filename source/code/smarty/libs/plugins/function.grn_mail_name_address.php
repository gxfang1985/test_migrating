<?php

use grn\grn\access\service\AppAccess;

/**
 * メールアドレスに関連するアドレス帳データへの参照/登録ボタンまたはリンクを表示する
 *
 * @name        grn_mail_name_address
 * @description アドレス帳の参照/登録画面へのボタンまたはリンクを表示する
 *
 * @param  string  type        'history' : 送受信記録, 'send' : メール送信
 * @param  string  iid         送受信記録ID
 * @param  string  aid         アカウントID
 * @param  string  cid         フォルダID
 * @param  string  mid         メールID
 * @param  string  name        nick name
 * @param  string  email       email address
 * @param  string  truncated   最大長
 * @param  boolean nolink
 * @param  boolean noimage
 */
//  注意: 未使用につき、国際化(リソース切り出し)未対応
function smarty_function_grn_mail_name_address($params, &$smarty)
{
    //require_once $smarty->_get_plugin_filepath( 'function', 'grn_link' );
    require_once $smarty->_get_plugin_filepath('function', 'grn_image');

    //-- the function name
    $function_name = 'grn_mail_name_address';

    $name = @ $params['name'];
    $email = @ $params['email'];
    $sk = @ $params['sk'];
    $page = @ $params['page'];
    $url_params = @ $params['url_params'];
    $three_pane = @ $params['3pane'];

    if (is_null($email) || is_null($sk)) {
        return '';
    }

    // -------------------------

    $disable_address = false;

    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $login_user = $uum->getLoginUser();
    if ($login_user) {
        // アドレス帳
        $app_locator = GRN_ApplicationLocator::instance();
        $address_app = $app_locator->getInstance('address');
        if ( ! is_object($address_app)
             || ! method_exists($address_app, 'getAddressPageInfo')
             || ! AppAccess::isAppAvailable('address')
        ) {
            $disable_address = true;
        }
    }
    if ($disable_address) {
        return '';
    }

    if ( ! is_null($name)) {
        $len = strlen($name);
        if ($len > 0) {
            $name = GRN_Mail_Utility::static_addNameQuotation($name, 'remove');
        }
    }

    if ( ! is_null($email)) {
        $len = strlen($email);
        if ($len > 0) {
            $email = GRN_Mail_Utility::static_addEmailBracket($email, 'remove');
        }
    }

    // 個人アドレス帳の参照
    $address_params = [
        'login_user'    => & $login_user,
        'email_address' => [$email],
        'sk'            => $sk
    ];

    $address_page_infos
        = $address_app->getAddressPageInfo(GRN_ADDRESS_DATA_PRIVATE, 'view',
        $address_params);

    if (is_array($address_page_infos) && (count($address_page_infos) > 0)) {
//echo '<pre>';var_dump($address_page_infos);die;
        if (isset($address_page_infos[$email])
            && is_array($address_page_infos[$email])
            && 0 < count($address_page_infos[$email])
        ) {
            require_once('mail/utility.csp');
            $utility = GRN_Mail_Utility::getInstance();
            $mail_app =& $utility->getMailApp();
            if ( ! is_object($mail_app)) {
                return '';
            }

            $return_string = '';
            $caption = cb_msg($mail_app->getModuleId(), 'address_view');
            $class = 'person16.gif';
            foreach (array_keys($address_page_infos[$email]) as $address_key) {
                $address_page_info = $address_page_infos[$email][$address_key];

                /*
                                $params = array(
                                    'page' => $address_page_info['page'],
                //                  'class' => $class
                                );

                                // リンク表示
                                return smarty_function_grn_link( $params, $smarty );
                */
                $params = [];
                if (is_array($address_page_info['params'])) {
                    foreach (array_keys($address_page_info['params']) as $key) {
                        $params[$key] = $address_page_info['params'][$key];
                    }
                }

                // ボタン表示
                //$page_url = smarty_function_grn_pageurl( $params, $smarty );
                $page_url = cb_pageurl($address_page_info['page'], $params);
                if ($three_pane) {
                    $return_string .= "&nbsp;<a href=\"javascript:void(0);\" onClick='popupWin(\""
                                      . $page_url
                                      . "\",\"address\",800,426,1,1,1,1,1,1)' title=\""
                                      . cb_msg('fw.ui', 'GRNMSG_UI_1')
                                      . "\"><span class=\"icon_address_grn\"></span></a>";
                } else {
                    $image = smarty_function_grn_image([
                        'image' => $class,
                        'alt'   => $caption
                    ], $smarty);
                    $return_string .= "&nbsp;<button onClick='popupWin(\""
                                      . $page_url
                                      . "\",\"address\",800,426,1,1,1,1,1,1)'><span style=\"background:#eeeeee;\">"
                                      . $image . "</span>" . cb_msg('fw.ui',
                            'GRNMSG_UI_1') . "</button>";
                }

                // 複数表示しない場合は抜ける
                break;
            }

            return $return_string;
        }
    }

    // 登録されていないときは

    // 個人アドレス登録ページ情報を取得する
    $address_params = [
        'subject'       => $name,
        'email_address' => $email,
        'sk'            => $sk,
        'page'          => $page,
        'url_params'    => $url_params,
    ];

    $address_page_info
        = $address_app->getAddressPageInfo(GRN_ADDRESS_DATA_PRIVATE, 'add',
        $address_params);
    if (is_array($address_page_info) && (count($address_page_info) > 0)) {
        require_once('mail/utility.csp');
        $utility = GRN_Mail_Utility::getInstance();
        $mail_app = $utility->getMailApp();
        if ( ! is_object($mail_app)) {
            return '';
        }

        $caption = cb_msg($mail_app->getModuleId(), 'address_regist');

        $class = 'person16.gif';
        /*
                $params = array(
                    'page' => $address_page_info['page'],
                    'caption' => $caption,
        //          'class' => $class
                );

                // リンク表示
                return smarty_function_grn_link( $params, $smarty );
        */
        $params = [];
        if (is_array($address_page_info['params'])) {
            foreach (array_keys($address_page_info['params']) as $key) {
                $params[$key] = $address_page_info['params'][$key];
            }
        }

        // ボタン表示
        //$page_url = smarty_function_grn_pageurl( $params, $smarty );
        $page_url = cb_pageurl($address_page_info['page'], $params);
        if ($three_pane) {
            return "&nbsp;<a href=\"javascript:void(0);\"  onClick='popupWin(\""
                   . $page_url . "\",\"address\",800,426,1,1,1,1,1,1)' title=\""
                   . cb_msg('fw.ui', 'GRNMSG_UI_1')
                   . "\"><span class=\"icon_address_grn\"></span></a>";
        } else {
            $image = smarty_function_grn_image([
                'image' => $class,
                'alt'   => $caption
            ], $smarty);

            return "&nbsp;<button class='buttonStandard-grn' onClick='popupWin(\""
                   . $page_url
                   . "\",\"address\",800,426,1,1,1,1,1,1)'><span style=\"background:#eeeeee;\">"
                   . $image . "</span>" . cb_msg('fw.ui', 'GRNMSG_UI_1')
                   . "</button>";
        }
    }

    return '';
}



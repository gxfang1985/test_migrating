<?php
require_once('grn/ui.csp');

/**
 * @name   grn_cellular_mailto
 *  ケータイ用mailtoリンクの出力
 *
 * @date    2005/04/15
 * @author  T.tosaka
 *
 * @param  string  mail              メールアドレス
 *
 * @option  string  caption           リンクキャプション
 * @option  string  width             幅（制限する場合）
 *
 * @package grn.cellular
 */

function smarty_function_grn_cellular_mailto($params, &$smarty)
{
    $function_name = "grn_cellular_mailto";

    $mailaddress = @ $params['mail'];

    $caption = $mailaddress;
    if (array_key_exists('caption', $params)) {
        $caption = $params['caption'];
    }

    $width_caption = $caption;
    if (array_key_exists('width', $params)) {
        require_once('cellular/string_util.csp');
        $width_caption = utf8_strimwidth($caption, $params['width'], '..');
    }

    static $mailto_flag = false;
    // どちらのリンクにするかは静的に保持
    if ($mailto_flag === false) {
        require_once('grn/uum.csp');
        global $G_container_base;
        $uum = $G_container_base->getInstance('uum');
        $login =& $uum->getLoginUser();

        $flag = false;
        // ログインしていて
        if ($login) {
            require_once('grn/application.csp');
            $locator = GRN_ApplicationLocator::instance();
            if ($app = $locator->getInstance('mail')) {
                if ($app->isAvailableFor($login)) {
                    // mail アプリ有効
                    require_once('mail/utility.csp');
                    $utility = GRN_Mail_Utility::getInstance();
                    $personal_config =& $utility->getPersonalConfig($login);
                    // デフォルトアカウントデータ取得
                    $account_id = $personal_config->getDefaultAccountId();
                    // アカウントデータ取得
                    $account_data
                        = $personal_config->getAccountData($account_id, true,
                        false);
                    if (is_array($account_data)) {
                        $cellular =& $locator->getInstance('cellular');
                        $config =& $cellular->getUserConfig($login);
                        // 個人設定がＯＮの時だけ
                        $flag = $config->getUseWebMail();
                    }
                }
            }
        }
        if ($flag) {
            // mailアプリ使用
            $mailto_flag = 1;
        } else {
            // 携帯のメーラー使用
            $mailto_flag = 2;
        }

    }

    $str = '';
    if ($mailto_flag == 1) {
        require_once('cellular/prepend.csp');

        $page = 'mail/cellular/create';
        $pageurl_params = ['m_add' => $caption];
        $pageurl = grn_cellular_pageurl($page, $pageurl_params);
        $pageurl = grn_cellular_remote_path($pageurl);

        $str = '<a href="' . $pageurl . '">' . htmlspecialchars($width_caption)
               . '</a>';
    } else {
        $str = '<a href="mailto:' . htmlspecialchars($mailaddress) . '">'
               . htmlspecialchars($width_caption) . '</a>';
    }

    return $str;
}


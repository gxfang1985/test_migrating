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
 *
 * @package grn.cellular
 */

function smarty_function_grn_workflow_cellular_mailto($params, &$smarty)
{
    // workflow/cellular function
    require_once('workflow/cellular.csp');
    if (__grn_workflow_is_cellular_application()) {
        require_once($smarty->_get_plugin_filepath('function',
            'grn_cellular_mailto'));

        return smarty_function_grn_cellular_mailto($params, $smarty);
    }

    $function_name = "grn_workflow_cellular_mailto";

    $mailaddress = @ $params['mail'];

    $caption = $mailaddress;
    if (array_key_exists('caption', $params)) {
        $caption = $params['caption'];
    }

    $width_caption = $caption;
    if (array_key_exists('width', $params)) {
        require_once('workflow/cellular.csp');
        $width_caption = grn_workflow_cellular_utf8_strimwidth($caption,
            $params['width'], '..');
    }

    // アプリ連携無し なので 携帯のメーラー使用
    $str = '<a href="mailto:' . $mailaddress . '">'
           . htmlspecialchars($width_caption) . '</a>';

    return $str;
}


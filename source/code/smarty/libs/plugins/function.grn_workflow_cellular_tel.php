<?php
require_once('grn/ui.csp');

/**
 * @name   grn_cellular_tel
 *  ケータイ用telリンクの出力
 *
 * @date    2005/04/15
 * @author  T.tosaka
 *
 * @option  string  tel              電話番号文字列
 *
 * @package grn.cellular
 */

function smarty_function_grn_workflow_cellular_tel($params, &$smarty)
{
    // workflow/cellular function
    require_once('workflow/cellular.csp');
    if (__grn_workflow_is_cellular_application()) {
        require_once($smarty->_get_plugin_filepath('function',
            'grn_cellular_tel'));

        return smarty_function_grn_cellular_tel($params, $smarty);
    }

    $function_name = "grn_workflow_cellular_tel";

    $tel_string = @ $params['tel'];
    if (0 == strlen($tel_string)) {
        return htmlspecialchars($tel_string);
    }

    // 全角を半角に変換
    $tel_href = mb_convert_kana($tel_string, "a");

    // 0~9 * # 以外を除去
    $tel_href = preg_replace("/[^0-9#*]/", "", $tel_href);

    if (0 == strlen($tel_href)) {
        return htmlspecialchars($tel_string);
    }

    return '<a href="tel:' . htmlspecialchars($tel_href) . '">'
           . htmlspecialchars($tel_string) . '</a>';

}


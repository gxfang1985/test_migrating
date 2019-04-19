<?php
require_once('grn/ui.csp');

/**
 * @name   grn_cellular_submit
 *  ケータイ用Submitボタンの表示
 *
 * @date    2005/02/04
 * @author  Y.Tanaka
 *
 * @option  string  caption    ボタンキャプション
 * @option  string  name       name属性
 * @option  integer accesskey  アクセスキー、0?9、有効な数値の場合は絵文字が自動で入る
 *
 * @package grn.cellular
 */

function smarty_function_grn_cellular_submit($params, &$smarty)
{
    $function_name = "grn_cellular_submit";

    $name = @ $params['name'];

    require_once('fw/i18n.csp');
    if (array_key_exists('caption', $params)) {
        $caption = $params['caption'];
    } elseif (array_key_exists('caption_module', $params)
              && array_key_exists('caption_key', $params)
    ) {
        $caption_module = $params['caption_module'];
        $caption_key = $params['caption_key'];
        $caption = cb_msg($caption_module, $caption_key);
    } else {
        $caption = cb_msg('grn.cellular', 'submit');
    }

    $accesskey = -1;
    if (array_key_exists('accesskey', $params)) {
        $accesskey = $params['accesskey'];
    }


    $out = "<input type='submit'";;

    if ($name) {
        $out .= " name='" . htmlspecialchars($name) . "'";
    }

    if ($accesskey >= 0 && $accesskey < 10) {
        require_once($smarty->_get_plugin_filepath('function',
            'grn_cellular_pictogram'));
        $accesskey_icon = smarty_function_grn_cellular_pictogram([
            'key' => 'num' . $accesskey
        ], $smarty);
        $out .= " accesskey='" . htmlspecialchars($accesskey)
                . "' directkey='" . htmlspecialchars($accesskey)
                . "' value='" . $accesskey_icon
                . htmlspecialchars($caption) . "'>";
    } else {
        $out .= " value='" . htmlspecialchars($caption) . "'>";
    }

    return $out;
}


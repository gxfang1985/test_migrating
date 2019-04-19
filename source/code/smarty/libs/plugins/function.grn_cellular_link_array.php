<?php
require_once('grn/ui.csp');

/**
 * @name   grn_cellular_link
 *  ケータイ用リンクの出力
 *
 * @date    2005/01/26
 * @author  Y.Tanaka
 *
 * @option  string  caption           リンクキャプション
 * @option  integer truncated_caption キャプションをtruncateする文字数
 * @option  string  caption_module    キャプションモジュール
 * @option  string  caption_key       キャプションキー
 *
 * @param  string  page              画面名
 *
 * @option  string  fragment          flagment
 * @option  string  postfix           postfix
 * @option  mixed   icon              絵文字キー、文字列または文字列が値に入った配列
 * @option  integer accesskey         アクセスキー、0?9、有効な数値の場合は絵文字が自動で入る
 * @option  array   params            その他のパラメータ
 *
 * @package grn.cellular
 */

function smarty_function_grn_cellular_link_array($params, &$smarty)
{
    $function_name = "grn_cellular_link_array";

    $url_params = (array)@$params['params'];
    unset($params['params']);
    $params = $params + $url_params;

    if (array_key_exists('p', $params)) {
        $params['page'] = $params['p'];
        unset($params['p']);
    }

    require_once('function.grn_cellular_link.php');

    return smarty_function_grn_cellular_link($params, $smarty);
}


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

function smarty_function_grn_workflow_cellular_link($params, &$smarty)
{
    $function_name = "grn_workflow_cellular_link";

    $icon = @ $params['icon'];
    if (array_key_exists('icon', $params)) {
        unset($params['icon']);
    }

    $accesskey = @ $params['accesskey'];
    if (array_key_exists('accesskey', $params)) {
        unset($params['accesskey']);
    }

    $params = grn_ui_link_params($params, $function_name, $smarty);

    $pageurl_params = [];
    $pageurl_params['page'] = $params['page'];
    $pageurl_params['fragment'] = $params['fragment'];
    $pageurl_params['postfix'] = $params['postfix'];
    $pageurl_params['params'] = (array)@$params['url_params'];

    require_once($smarty->_get_plugin_filepath('function',
        'grn_workflow_cellular_pageurl'));
    $page = smarty_function_grn_workflow_cellular_pageurl($pageurl_params,
        $smarty);

    $str = '<a href="' . $page . '"';

    if (is_numeric($accesskey) && $accesskey >= -1 && $accesskey < 10) {
        static $_registered_accesskey = [];

        if ($accesskey == -1) {
            for ($i = 1; $i < 10; ++$i) {
                if ( ! array_key_exists($i, $_registered_accesskey)) {
                    $accesskey = $i;
                    $_registered_accesskey[$i] = 1;
                    break;
                }
            }
        } else {
            if (array_key_exists($accesskey, $_registered_accesskey)) {
                $accesskey = -1;
            } else {
                $_registered_accesskey[$accesskey] = 1;
            }
        }

        if ($accesskey != -1) {
            $str .= " accesskey='" . htmlspecialchars($accesskey)
                    . "' directkey='" . htmlspecialchars($accesskey) . "'>";

            require_once($smarty->_get_plugin_filepath('function',
                'grn_workflow_cellular_pictogram'));
            $str .= smarty_function_grn_workflow_cellular_pictogram([
                'key' => 'num' . $accesskey
            ], $smarty);
        } else {
            $str .= '>';
//            $str .= cb_msg('grn.cellular.common','accesskey_nothing');
        }
    } else {
        $str .= '>';
    }

    if ($icon) {
        require_once($smarty->_get_plugin_filepath('function',
            'grn_workflow_cellular_pictogram'));

        if (is_array($icon)) {
            foreach ($icon as $i) {
                $str .= smarty_function_grn_workflow_cellular_pictogram(['key' => $i],
                    $smarty);
            }
        } else {
            $str .= smarty_function_grn_workflow_cellular_pictogram(['key' => $icon],
                $smarty);
        }
    }

    $str .= $params['caption'] . '</a>';

    return $str;
}


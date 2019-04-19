<?php

/**
 * @name   grn_cellular_string_split
 *                               長文ページ切り替えフィルター （自動リンク生成）
 *
 * @date   2005/04/10
 *
 * @param  string $string        変換する文字列
 * @param  string $page_paraname 表示するページ番号（G_INPUTパラメータ名）
 *
 */
function smarty_function_grn_report_cellular_string_split($params, &$smarty)
{
    $function_name = 'grn_report_cellular_string_split';

    global $G_INPUT;

    $string = @ $params['string'];
    if (0 == strlen($string)) {
        return $string;
    }

    $page_paraname = @ $params['page_paraname'];
    $page_number = @ $G_INPUT[$page_paraname];
    if ( ! $page_number) {
        $page_number = 0;
    }

    require_once('grn/regexp_pattern.csp');
    // マッチ情報作成
    $matches = [];
    mb_ereg_search_init($string, GRN_EMAIL_REGEXP_PATTERN);
    while (($ret = mb_ereg_search_pos()) !== false) {
        $matches[$ret[0]] = $ret[1];
    }
    $matches[strlen($string)] = 0;

    // 文字列分割
    $data_arr = [];
    $data_idx = 0;
    $ptr = 0;
    foreach ($matches as $start => $len) {
        $data_arr[$data_idx++] = substr($string, $ptr, $start - $ptr);
        $_tag = '';
        if ($len) {
            $_mailaddress = substr($string, $start, $len);
            require_once($smarty->_get_plugin_filepath('function',
                'grn_report_cellular_mailto'));
            $mailto_params = ['mail' => $_mailaddress];
            $_tag
                = smarty_function_grn_report_cellular_mailto($mailto_params,
                $smarty);
        }
        $data_arr[$data_idx++] = $_tag;
        $ptr = $start + $len;
    }

    // ページ情報に分割（mb_strlenでカウント）
    $out = [];
    $page = 0;
    $data_idx = 0;
    $now = 0;

    foreach ($data_arr as $_idx => $_str) {
        $_len = mb_strlen($_str);
        if ($_idx % 2) {
            // address
            if (1024 < $now + $_len) {
                if ($now) {
                    $page++;
                    $out[$page] = $_str;
                    $now = $_len;
                } else {
                    $out[$page] = $_str;
                    $page++;
                    $now = 0;
                }
            } else {
                $out[$page] .= $_str;
                $now = $now + $_len;
            }
        } else {
            // string
            while (1024 < $now + $_len) {
                $_tmp = 1024 - $now;
                $_tmp = ($_tmp < 0 ? 0 : $_tmp);
                $out[$page] .= htmlspecialchars(mb_substr($_str, 0, $_tmp));
                $page++;
                $now = 0;
                $_str = mb_substr($_str, $_tmp);
                $_len = mb_strlen($_str);
            }
            if (1024 >= $now + $_len) {
                $out[$page] .= htmlspecialchars($_str);
                $now = $now + $_len;
            }
        }
    }

    // 該当ページと前後へのリンク
    require_once('fw/i18n.csp');
    require_once($smarty->_get_plugin_filepath('function',
        'grn_report_cellular_link'));

    $output = '<a name = "body"></a>';

    if ($page_number > 0) {
        $link_param = array_merge($G_INPUT, [
            'page'         => cb_get_pagename(),
            'caption'      => cb_msg('grn.report.cellular', 'previous_page'),
            'fragment'     => "body",
            $page_paraname => $page_number - 1
        ]);
        $output .= smarty_function_grn_report_cellular_link($link_param,
            $smarty);
        $output .= "<br>..";
    }

    $output .= nl2br($out[$page_number]);

    if ($page_number + 1 < count($out)) {
        $link_param = array_merge($G_INPUT, [
            'page'         => cb_get_pagename(),
            'caption'      => cb_msg('grn.report.cellular', 'next_page'),
            'fragment'     => "body",
            $page_paraname => $page_number + 1
        ]);
        $output .= "..<br>";
        $output .= smarty_function_grn_report_cellular_link($link_param,
            $smarty);
    }

    return $output;
}



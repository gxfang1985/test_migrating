<?php

/*
 * 週表示のヘッダー部分を作成する関数
 * フォーマットを一切見ないでキャッシュするので注意！
 */
function smarty_function_grn_schedule_date_header($params, &$smarty)
{
    static $date_list = null;
    if (is_null($date_list)) {
        $date_list = [];
    }

    $date = $params['date'];

    // 既に作っている場合は、再利用
    if (array_key_exists($date, $date_list)) {
        return $date_list[$date];
    }

    static $include_file = false;
    if ($include_file === false) {
        require_once $smarty->_get_plugin_filepath('function',
            'grn_date_format');
        require_once $smarty->_get_plugin_filepath('function', 'grn_link');
        $include_file = true;
    }

    $caption = smarty_function_grn_date_format($params, $smarty);

    unset($params['date']);
    unset($params['format']);

    $params['caption'] = $caption;

    if (array_key_exists('page', $params)) {
        $params['bdate'] = $date;
        $retval = smarty_function_grn_link($params, $smarty);
    } else {
        $retval = $caption;
    }

    // 記憶
    $date_list[$date] = $retval;

    return $retval;
}



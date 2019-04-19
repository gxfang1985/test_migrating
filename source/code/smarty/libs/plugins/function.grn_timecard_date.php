<?php

/**
 *  タイムカードの日付表示
 *  先頭行あるいは月の変わり目以外では月が表示されない
 *
 * @date   2005/03
 * @author Y.Tanaka
 * @option mixed   date   date ( CB_Date or CB_DateEx )
 *
 */
function smarty_function_grn_timecard_date($params, &$smarty)
{
    $function_name = "grn_timecard_date";

    $date = @ $params['date'];

    if (is_null($date) || ! is_a($date, 'cb_date')) {
        if (is_string($date)) {
            $date = new CB_Date();
            if ( ! $date->parse($params['date'])) {
                return htmlspecialchars($function_name) . ' : date not found ';
            }
        } else {
            return htmlspecialchars($function_name) . ' : date not found : '
                   . htmlspecialchars(get_class($date));
        }
    }

    static $cached_month = null;

    $show_month = false;

    if (is_null($cached_month) || $date->month != $cached_month) {
        $cached_month = $date->month;
        $show_month = true;
    }

    if ($show_month) {
        require_once($smarty->_get_plugin_filepath('function',
            'grn_date_format_switch'));

        return smarty_function_grn_date_format_switch([
            'date'   => $date,
            'format' => 'DateShort_MDW'
        ], $smarty);
    }

    if ( ! is_a($date, 'cb_dateex')) {
        require_once('fw/date.csp');
        $date = new CB_DateEx($date);
    }

    require_once($smarty->_get_plugin_filepath('function',
        'grn_date_format_switch'));

    return smarty_function_grn_date_format_switch([
        'date'   => $date,
        'format' => 'Date_DW',
    ], $smarty);


}


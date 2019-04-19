<?php
require_once 'fw/date.csp';

/**
 * @name grn_show_period
 * @description
 *
 * @date   10/11/2004
 * @author M.Oomori
 *
 * @param CB_Date start start date
 * @param CB_Date end end date
 * @param format cb_date_format() format id, if not specified, use 'DateLong_YMDW'
 *
 * @return string [start]&nbsp;?&nbsp;[end]
 **/
function smarty_function_grn_show_period($params, &$smarty)
{
    //-- get parameters
    $start_date = null;
    if (array_key_exists('start', $params)) {
        $start_date = $params['start'];
    }

    $end_date = null;
    if (array_key_exists('end', $params)) {
        $end_date = $params['end'];
    }
    if (array_key_exists('format', $params)) {
        $format_id = $params['format'];
    } else {
        $format_id = 'DateLong_YMDW';
    }

    $return_string = null;

    $msg = cb_msg('grn.bulletin', 'grn_show_period_interval');
    if ($start_date) {
        if (array_key_exists('start_format', $params)) {
            $return_string = cb_date_format($params['start_format'],
                    $start_date) . '&nbsp;' . $msg . '&nbsp;';
        } else {
            $return_string = cb_date_format($format_id, $start_date) . '&nbsp;'
                             . $msg . '&nbsp;';
        }
    }

    if ($end_date) {
        if (is_null($return_string)) {
            $return_string = '&nbsp;' . $msg . '&nbsp;';
        }
        if (array_key_exists('end_format', $params)) {
            $return_string .= cb_date_format($params['end_format'], $end_date);
        } else {
            $return_string .= cb_date_format($format_id, $end_date);
        }
    }

    if (is_null($return_string)) {
        require_once('fw/i18n.csp');
        $return_string = cb_msg('grn.common', 'no_period');
    }

    return $return_string;

}



<?php
require_once 'fw/i18n.csp';
require_once 'fw/date.csp';
require_once 'grn/calendar.csp';

function smarty_function_grn_mobile_datepicker_month_year_select(
    $params,
    &$smarty
) {
    $function_name = "grn_mobile_datepicker_year_select";

    // default date/timestamp value
    $date = array_key_exists('date', $params) ? $params['date'] : null;
    if (is_null($date)) {
        $timestamp = array_key_exists('timestamp', $params)
            ? $params['timestamp'] : null;
        if (is_numeric($timestamp)) {
            $timestampex = new CB_TimeStampEx();
            $timestampex->unix_ts = intval($timestamp);
            $date = $timestampex->getDate();
        }
    } elseif ( ! is_object($date)
               || ! (is_a($date, 'CB_Date')
                     || is_a($date, 'CB_DateTime'))
    ) {
        $date = null;
    }

    $timestampex = new CB_TimeStampEx();
    $current_date = $timestampex->getDate();

    if (is_null($date)) {
        $date = $current_date;
    }

    $date_year = $current_date->year;

    if (_grn_select_date_validate_year($date)) {
        $date_year = $date->year;
    }

    // start/end year
    $start_year = 1970;
    $end_year = 2037;

    $return_code = "\n";
    $year_select_str
        = '<li class="mobile_width_b_grn"><div data-role="fieldcontain" class="mobile_titlebar_right_grn mobile_select_grn"><select class="year_select">';
    $option_year_str = '';
    $year_unit = cb_msg('fw.ui', 'date_year_unit');
    for ($year = $start_year; $year <= $end_year; $year++) {
        $selected = ( ! is_null($date) && $year == $date->year)
            ? ' selected' : '';
        $option_year_str .= sprintf('<option value="%s"%s>%s%s</option>%s',
            htmlspecialchars($year), htmlspecialchars($selected),
            htmlspecialchars($year), $year_unit,
            htmlspecialchars($return_code));
    }

    if (_grn_select_date_validate_year($date) && $date->year > $end_year) {
        $option_year_str .= sprintf('<option value="%s" selected>%s%s</option>%s',
            htmlspecialchars($date->year), htmlspecialchars($date->year),
            $year_unit, htmlspecialchars($return_code));
    }

    $year_select_str .= $option_year_str . '</select></div></li>';

    $month_select_str
        = '<li class="mobile_width_c_grn"><div data-role="fieldcontain" class="mobile_titlebar_right_grn mobile_select_grn"><select class="month_select">';
    $option_month_str = '';
    $month_unit = cb_msg('fw.ui', 'date_month_unit');

    for ($month = 1; $month <= 12; $month++) {
        $selected = ( ! is_null($date) && $month == $date->month)
            ? ' selected' : '';
        $option_month_str .= sprintf('<option value="%s"%s>%s%s</option>%s',
            htmlspecialchars($month), htmlspecialchars($selected),
            cb_msg("fw.date", "MonthShort" . $month), $month_unit,
            htmlspecialchars($return_code));
    }

    $month_select_str .= $option_month_str . '</select></div></li>';

    return $year_select_str . $month_select_str;
}

function _grn_select_date_validate_year($date)
{
    return ! is_null($date) && $date->year >= 1970 && $date->year <= 2037;
}

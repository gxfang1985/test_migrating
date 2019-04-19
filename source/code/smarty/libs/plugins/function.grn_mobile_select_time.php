<?php
require_once 'fw/i18n.csp';
require_once 'fw/basic_date.csp';

function smarty_function_grn_mobile_select_time($params, &$smarty)
{
    $function_name = 'grn_mobile_select_time';

    // prefix
    if ( ! array_key_exists('prefix', $params)) {
        return htmlspecialchars($function_name) . ': missing prefix parameter';
    }
    $prefix = $params['prefix'];

    // default time value
    $time = cb_at($params, 'time', null);
    if ( ! is_object($time)
         || ! (is_a($time, 'CB_Time')
               || is_a($time, 'CB_DateTime'))
    ) {
        $time = null;
    }

    // use 24 hours or not ?
    if (array_key_exists('use_24_hours', $params)) {
        $use_24_hours = $params['use_24_hours'];
    } else {
        $i18n = CB_I18N::getInstance();
        $time_notation = $i18n->getCurrentTimeNotation();
        if ($time_notation == '24') {
            $use_24_hours = true;
        } elseif ($time_notation == '12') {
            $use_24_hours = false;
        } elseif (cb_msg('fw.date', 'TimeNotation') == '12') {
            $use_24_hours = false;
        } else {
            $use_24_hours = true;
        }
    }

    // start hour
    $start_hour = _cb_ui_select_time_get_param_numeric($params, 'start_hour', 0,
        0, 23, $smarty);
    // end hour
    $end_hour = _cb_ui_select_time_get_param_numeric($params, 'end_hour', 23, 0,
        24, $smarty);

    if ($end_hour < $start_hour) {
        //return $function_name . ': end_hour parameter is out of range (start_hour - 24)';
    }

    $hour_unit = cb_msg('fw.ui', 'time_hour_unit');
    $delimiter = cb_msg('fw.ui', 'time_delimiter');

    // display_minute
    $display_minute = (@ $params['display_minute']) ? false : true;

    if ($display_minute) {
        $minute_interval = _cb_ui_select_time_get_param_numeric($params,
            'minute_interval', 1, 1, 60, $smarty);
        $minute_unit = cb_msg('fw.ui', 'time_minute_unit');
    }

    // necessary
    $necessary = cb_at($params, 'necessary', null);

    // html code
    $hour_str = _cb_ui_select_time_write_select_hour($prefix . 'hour',
        $necessary, $start_hour, $end_hour, 1,
        (is_null($time) || is_null($time->hour) ? null : intval($time->hour)),
        $hour_unit, false, 8, ! $use_24_hours);

    $return_str = $hour_str;

    if ($display_minute) {
        $minute_str = _cb_ui_select_time_write_one_select($prefix . 'minute',
            $necessary, 0, 59, $minute_interval,
            (is_null($time) || is_null($time->minute) ? null
                : intval($time->minute)), $minute_unit, true, 0, false);

        $return_str .= $delimiter . $minute_str;
    }

    return $return_str;
}

function _cb_ui_select_time_get_param_numeric(
    & $params,
    $param_name,
    $default,
    $min,
    $max,
    &$smarty
) {
    $num = @ $params[$param_name];
    $num = is_null($num) ? $default : $num;
    if ( ! is_numeric($num)) {
        $smarty->trigger_error('cb_ui_select_time: ' . $param_name
                               . ' parameter is not numeric');
    }
    $num = intval($num);
    if ($num < $min || $max < $num) {
        $smarty->trigger_error('cb_ui_select_time: ' . $param_name
                               . ' parameter is out of range (' . $min . ' - '
                               . $max . ')');
    }

    return $num;
}

function _cb_ui_select_time_write_select_hour(
    $name,
    $necessary,
    $start,
    $end,
    $interval,
    $selected,
    $unit,
    $zero_padding,
    $post_undefined_hour = 0,
    $meridian = false
) {
    $return_code = "\n";

    $select_str
        = sprintf('<div data-role="fieldcontain" class="mobile_select_date_grn mobile_select_time_grn"><select id="%s" name="%s" >%s',
        htmlspecialchars($name), htmlspecialchars($name),
        htmlspecialchars($return_code));

    $option_str = '';
    if ( ! $necessary) {
        $option_str .= sprintf('<option value="">--%s</option>%s', $unit,
            htmlspecialchars($return_code));
    }
    $limit = ($end < $start) ? ($end + 24) : $end;
    for ($num = $start; $num <= $limit; $num += $interval) {
        if ($num >= 24) {
            $h = $num - 24;
        } else {
            $h = $num;
        }

        if ( ! $necessary && $h == $post_undefined_hour
             && $start < $post_undefined_hour
        ) {
            $selected_str = (is_null($selected)) ? ' selected' : '';
            $option_str .= sprintf('<option value=""%s>--%s</option>%s',
                htmlspecialchars($selected_str), $unit,
                htmlspecialchars($return_code));
        }
        if ($meridian) {
            $meridian_num = ($h > 12) ? ($h - 12) : (($h == 0) ? 12 : $h);
            $num_str = ($zero_padding && $meridian_num < 10) ? '0'
                                                               . $meridian_num
                : $meridian_num;
        } else {
            $num_str = ($zero_padding && $h < 10) ? '0' . $h : $h;
        }

        $selected_str = ($h === $selected) ? ' selected' : '';
        $option_str .= sprintf('<option value="%s"%s>%s%s</option>%s',
            htmlspecialchars($h), htmlspecialchars($selected_str),
            htmlspecialchars($num_str), $unit, htmlspecialchars($return_code));
    }

    $return_str = $select_str . $option_str . '</select></div>';

    return $return_str;
}

function _cb_ui_select_time_write_one_select(
    $name,
    $necessary,
    $start,
    $end,
    $interval,
    $selected,
    $unit,
    $zero_padding,
    $post_undefined_hour = 0,
    $meridian = false
) {
    $return_code = "\n";

    $select_str
        = sprintf('<div data-role="fieldcontain" class="mobile_select_date_grn mobile_select_time_grn"><select id="%s" name="%s">%s',
        htmlspecialchars($name), htmlspecialchars($name),
        htmlspecialchars($return_code));

    $option_str = '';
    if ( ! $necessary) {
        $option_str .= sprintf('<option value="">--%s</option>%s', $unit,
            htmlspecialchars($return_code));
    }
    for ($num = $start; $num <= $end; $num += $interval) {
        if ( ! $necessary && $num == $post_undefined_hour
             && $start < $post_undefined_hour
        ) {
            $selected_str = (is_null($selected)) ? ' selected' : '';
            $option_str .= sprintf('<option value=""%s>--%s</option>%s',
                htmlspecialchars($selected_str), $unit,
                htmlspecialchars($return_code));
        }
        if ($meridian) {
            $meridian_num = ($num > 12) ? ($num - 12)
                : (($num == 0) ? 12 : $num);
            $num_str = ($zero_padding && $meridian_num < 10) ? '0'
                                                               . $meridian_num
                : $meridian_num;
        } else {
            $num_str = ($zero_padding && $num < 10) ? '0' . $num : $num;
        }

        $selected_str = ($num === $selected) ? ' selected' : '';
        $option_str .= sprintf('<option value="%s"%s>%s%s</option>%s',
            htmlspecialchars($num), htmlspecialchars($selected_str),
            htmlspecialchars($num_str), $unit, htmlspecialchars($return_code));
    }

    $return_str = $select_str . $option_str . '</select></div>';

    return $return_str;
}


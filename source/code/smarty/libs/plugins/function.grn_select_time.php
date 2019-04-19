<?php
require_once 'fw/i18n.csp';
require_once 'fw/basic_date.csp';

/**
 * @name   grn_select_time
 *  時刻選択
 *
 * @date   2003/9/24
 * @author HATA,Shinya
 *
 * @param  string  prefix          SELECTタグのNAME属性に付加する接頭辞
 *
 * @option CB_Time time            時刻の初期値
 * @option boolean use_24_hours    24時間制かどうか
 * @option int     start_hour      開始時間
 * @option int     end_hour        終了時間
 * @option boolean display_minute  分を表示するかどうか
 * @option int     minute_interval 分間隔
 * @option boolean necessary       必須かどうか
 * @option boolean display_second  秒を表示するかどうか
 * @option int     second_interval 秒間隔
 * @option boolean disabled        禁止状態
 *
 *  necessary=TRUE を指定すると、<option value="">--</option> の部分が省かれ、
 *  必ず有効な値が選択される。<br>
 *  {cb_ui_select_time} を通じて入力されたフォーム値は fw/ui.csp で定義されている
 *   cb_ui_get_time() を通じて CB_Time 値に変換される。<br>
 *  例）$start_time = cb_ui_get_time('start_');<br>
 *  use_24_hours=TRUE とした場合、24時間表記で、FALSE とした場合、
 *  12時間表記で表示される。
 *  指定しなければセッション情報の12/24時間表記の設定に依存する。
 *  さらにそれが設定されていなければ、言語のデフォルトの設定に依存する。
 *
 *  記述例
 *  <pre>{grn_select_time prefix='start_' minute_interval='10'}</pre>
 *  出力例
 *  <pre>
 *  &lt;select name="start_hour"&gt;
 *  &lt;option value=""&gt;--時&lt;option&gt;
 *  &lt;option value="0"&gt;0時&lt;option&gt;
 *  &lt;option value="1"&gt;1時&lt;option&gt;
 *   :
 *  &lt;option value="23"&gt;23時&lt;option&gt;
 *  &lt;/select&gt;&lt;select name="start_minute"&gt;
 *  &lt;option value=""&gt;--分&lt;option&gt;
 *  &lt;option value="0"&gt;00分&lt;option&gt;
 *  &lt;option value="10"&gt;10分&lt;option&gt;
 *  &lt;option value="20"&gt;20分&lt;option&gt;
 *  &lt;option value="30"&gt;30分&lt;option&gt;
 *  &lt;option value="40"&gt;40分&lt;option&gt;
 *  &lt;option value="50"&gt;50分&lt;option&gt;
 *  &lt;/select&gt;
 *  </pre>
 *
 * @date   2005/1/20
 * @author K.Tokuta
 *
 */
function smarty_function_grn_select_time($params, &$smarty)
{
    $function_name = 'grn_select_time';

    // prefix
    if ( ! array_key_exists('prefix', $params)) {
        return htmlspecialchars($function_name) . ': missing prefix parameter';
    }
    $prefix = $params['prefix'];

    // default time value
    $time = @ $params['time'];
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

    // display_second
    $display_second = @ $params['display_second'];

    if ($display_second) {
        $second_interval = _cb_ui_select_time_get_param_numeric($params,
            'second_interval', 1, 1, 60, $smarty);
        $second_unit = cb_msg('fw.ui', 'time_second_unit');
    }

    // necessary
    $necessary = @ $params['necessary'];

    // disabled
    $disabled = (@ $params['disabled']) ? true : false;

    $onchange = (@ $params['onchange']) ? $params['onchange'] : "";

    $onclick = (@ $params['onclick']) ? $params['onclick'] : "";

    // html code
    $hour_str = _cb_ui_select_time_write_select_hour($prefix . 'hour',
        $necessary, $start_hour, $end_hour, 1,
        (is_null($time) || is_null($time->hour) ? null : intval($time->hour)),
        $hour_unit, false, $disabled, 8, ! $use_24_hours, $onchange, $onclick);

    $return_str = $hour_str;

    if ($display_minute) {
        $minute_str = _cb_ui_select_time_write_one_select($prefix . 'minute',
            $necessary, 0, 59, $minute_interval,
            (is_null($time) || is_null($time->minute) ? null
                : intval($time->minute)), $minute_unit, true, $disabled, 0,
            false, $onchange, $onclick);

        $return_str .= $delimiter . $minute_str;
    }

    if ($display_second) {
        $second_str .= _cb_ui_select_time_write_one_select($prefix . 'second',
            $necessary, 0, 59, $second_interval,
            (is_null($time) ? null : intval($time->second)), $second_unit, true,
            $disabled, $onchange, $onclick);

        $return_str .= $delimiter . $second_str;
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
    $disabled = false,
    $post_undefined_hour = 0,
    $meridian = false,
    $onchange = '',
    $onclick = ''
) {
    $return_code = "\n";
    $disabled = ($disabled) ? ' disabled' : '';

    $on_change = $onchange ? ("onchange=\"" . htmlspecialchars($onchange)
                              . "\"") : "";
    $on_click = $onclick ? (" onclick=\"" . htmlspecialchars($onclick) . "\"")
        : "";
    $select_str = sprintf('<select id="%s" name="%s" %s %s %s>%s',
        htmlspecialchars($name), htmlspecialchars($name), $on_change,
        htmlspecialchars($disabled), $on_click, htmlspecialchars($return_code));

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

    $return_str = $select_str . $option_str . '</select>';

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
    $disabled = false,
    $post_undefined_hour = 0,
    $meridian = false,
    $onchange = '',
    $onclick = ''
) {
    $return_code = "\n";
    $disabled = ($disabled) ? ' disabled' : '';
    $on_change = $onchange ? ("onchange=\"" . htmlspecialchars($onchange)
                              . "\"") : "";
    $on_click = $onclick ? (" onclick=\"" . htmlspecialchars($onclick)
                            . "\"") : "";
    $select_str = sprintf('<select id="%s" name="%s"%s %s %s>%s',
        htmlspecialchars($name), htmlspecialchars($name),
        htmlspecialchars($disabled), $on_change, $on_click,
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

    $return_str = $select_str . $option_str . '</select>';

    return $return_str;
}


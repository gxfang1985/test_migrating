<?php

/**
 * 日表示での時間のヘッダー部分の作成をする関数
 */
function smarty_function_grn_schedule_time_header($params, &$smarty)
{
    $str = null;
    $before_timezone = null;

    $standard_timezone = CB_I18N::getInstance()->getCurrentTimezone();
    $timezone = isset($params['timezone']) ? $params['timezone']
        : $standard_timezone;

    if (is_null($str) || $before_timezone !== $timezone) {
        $str = '';
        $before_timezone = $timezone;

        $ts = time();
        if (isset($params['bdate'])) {
            $date = new CB_Date();
            $date->parse($params['bdate']);
            $dt = new CB_DateTime();
            $dt->year = $date->year;
            $dt->month = $date->month;
            $dt->day = $date->day;
            $ts = cb_datetime_to_timestamp($dt, $timezone);
        }
        $offset_info = CB_I18N::getTimezonesOffsetInfo($timezone,
            $standard_timezone, $ts);

        $set_hour = isset($params['set_hour']) ? $params['set_hour'] : 8;
        $end_hour = isset($params['end_hour']) ? $params['end_hour'] : 19;
        $loop_count = $end_hour - $set_hour;
        $set_hour += $offset_info['hour'];
        if ($set_hour < 0) {
            $set_hour += 24;
        }
        if ($set_hour >= 24) {
            $set_hour -= 24;
        }
        $end_hour += $offset_info['hour'];
        if ($end_hour < 0) {
            $end_hour += 24;
        }
        if ($end_hour >= 24) {
            $end_hour -= 24;
        }

        $set_minute = $offset_info['minute'];

        $unit = intval(array_key_exists('unit', $params) ? $params['unit']
            : 30);
        $interval = (int)(60 / $unit);

        //get interval of time begin and time end 
        $interval_begin = (int)((60 - $set_minute) / $unit);
        $interval_end = (int)(($set_minute) / $unit);
        if ($interval_begin == 0) {
            $interval_begin = 1;
        }

        if ($interval_end == 0 && $set_minute > 0) {
            $interval_end = 1;
        }

        $class_morning = array_key_exists('class_morning', $params)
            ? $params['class_morning'] : false;
        $class_evening = array_key_exists('class_evening', $params)
            ? $params['class_evening'] : false;
        $class_night = array_key_exists('class_night', $params)
            ? $params['class_night'] : false;

        $time = $set_hour;
        for ($i = 0; $i <= $loop_count; $i++) {
            if ($set_hour
                == $end_hour
            ) // $set_hour and $end_hour = 0 -> display 24hour
            {
                if ($i == 24) {
                    break;
                }
            } else {
                if ($time == $end_hour && $interval_end == 0) {
                    break;
                }
            }

            $str .= '<td align="center" ';
            $class = '';

            if ($time < 12) {
                $class = $class_morning;
            } elseif ($time < 18) {
                $class = $class_evening;
            } else {
                $class = $class_night;
            }

            if ($class) {
                $str .= 'class="' . htmlspecialchars($class) . '" ';
            }
            if ($time == $set_hour) {
                $str .= ' colspan="' . htmlspecialchars($interval_begin) . '">'
                        . htmlspecialchars($time) . '</td>';
            } elseif ($time == $end_hour) {
                $str .= ' colspan="' . htmlspecialchars($interval_end) . '">'
                        . htmlspecialchars($time) . '</td>';
            } else {
                $str .= ' colspan="' . htmlspecialchars($interval) . '">'
                        . htmlspecialchars($time) . '</td>';
            }
            $time++;
            $time = ($time >= 24) ? $time - 24 : $time;
        }
    }

    if ($str == '') {
        return;
    }

    return $str;
}



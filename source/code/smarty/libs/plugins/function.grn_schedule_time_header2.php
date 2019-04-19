<?php

/**
 * 日表示での時間のヘッダー部分の作成をする関数
 */
function smarty_function_grn_schedule_time_header2($params, $smarty)
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
        $end_hour = isset($params['end_hour']) ? $params['end_hour']
            : 19;
        $start_time_hour = (isset($params['start_time_hour']))
            ? $params['start_time_hour'] : false;
        $end_time_hour = (isset($params['end_time_hour']))
            ? $params['end_time_hour'] : false;
        $unit = intval(array_key_exists('unit', $params)
            ? $params['unit'] : 30);
        $start_flag = 0;
        $end_flag = 0;

        if ($start_time_hour) {
            if ($start_time_hour < $set_hour) {
                $set_hour = $start_time_hour;
            }
            $start_time_minute = (isset($params['start_time_minute']))
                ? $params['start_time_minute'] : 0;
            $start_flag = ($start_time_hour - $set_hour) * (60 / $unit);
            $start_flag += $start_time_minute / $unit;
        }
        if ($end_time_hour) {
            if ($end_time_hour > $end_hour) {
                $end_hour = $end_time_hour;
            }
            $end_time_minute = (isset($params['end_time_minute']))
                ? $params['end_time_minute'] : 0;
            $end_flag = ($end_time_hour - $set_hour) * (60 / $unit);
            $end_flag += $end_time_minute / $unit;
        }
        $loop_count = $end_hour - $set_hour;
        $set_hour += $offset_info['hour'];
        $end_hour += $offset_info['hour'];
        if ($set_hour < 0) {
            $set_hour += 24;
        }
        if ($set_hour >= 24) {
            $set_hour -= 24;
        }
        if ($end_hour < 0) {
            $end_hour += 24;
        }
        if ($end_hour >= 24) {
            $end_hour -= 24;
        }

        $interval = ( int )(60 / $unit);

        $class_morning = array_key_exists('class_morning', $params)
            ? $params['class_morning'] : false;
        $class_evening = array_key_exists('class_evening', $params)
            ? $params['class_evening'] : false;
        $class_night = array_key_exists('class_night', $params)
            ? $params['class_night'] : false;
        $class_time = array_key_exists('class_time', $params)
            ? $params['class_time'] : false;

        $width = array_key_exists('width', $params) ? $params['width'] : false;

        $count = 0;
        $time = $set_hour;
        for ($i = 0; $i <= $loop_count; $i++) {
            for ($j = 0; $j < $interval; $j++) {
                if (($time == $set_hour)
                    && $j < ($offset_info['minute'] / $unit)
                ) {
                    continue;
                }
                if ($set_hour == $end_hour) {
                    if ($i == 24 && $j == ($offset_info['minute'] / $unit)) {
                        break;
                    }
                } else {
                    if (($time == $end_hour)
                        && $j == ($offset_info['minute'] / $unit)
                    ) {
                        break;
                    }
                }

                $class = '';
                $str .= '<td';

                if ($width) {
                    $str .= ' width="' . htmlspecialchars($width) . '"';
                }

                if ($time < 12) {
                    $class = $class_morning;
                } elseif ($time < 18) {
                    $class = $class_evening;
                } else {
                    $class = $class_night;
                }

                $count++;
                if ($count > $start_flag && $count <= $end_flag) {
                    $class = $class_time;
                }

                if ($class) {
                    $str .= ' class="' . htmlspecialchars($class) . '"';
                }

                $str .= '></td>';
            }
            $time++;
            if ($time == 24) {
                $time -= 24;
            }
        }
    }
    print $str;
}


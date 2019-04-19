<?php
require_once 'fw/date.csp';

/**
 * @access private
 */
function &_grn_schedule_convert_to_datetime_group_day_conflict($str)
{
    $dt = null;
    $_datetime = new CB_DateTime;
    $_date = new CB_Date;
    $_time = new CB_Time;

    if ($_datetime->parse($str)) {
        $dt = new CB_DateTimeEx($_datetime);
    } elseif ($_date->parse($str)) {
        $dt = new CB_DateEx($_date);
    } elseif ($_time->parse($date)) {
        $dt = new CB_TimeEx($_time);
    }

    return $dt;
}

/**
 * @name   grn_schedule_group_day_conflict
 *
 */

function smarty_function_grn_schedule_group_day_conflict($params, &$smarty)
{
    $target = '';
    if (isset($params['target'])) {
        if ($params['target'] == 'blank') {
            $target = 'target="_' . $params['target'] . '"';
        }
    }

    global $G_config_common;
    $app_path = $G_config_common->get('Global', 'app_path');

    $standard_timezone = CB_I18N::getInstance()->getCurrentTimezone();
    $timezone = isset($params['timezone']) ? $params['timezone']
        : $standard_timezone;
    $ts = time();
    $offset_info = CB_I18N::getTimezonesOffsetInfo($timezone,
        $standard_timezone, $ts);
    if (isset($params['bdate'])) {
        $date = new CB_Date();
        $date->parse($params['bdate']);
        $dt = new CB_DateTime();
        $dt->year = $date->year;
        $dt->month = $date->month;
        $dt->day = $date->day;
        $ts = cb_datetime_to_timestamp($dt, $timezone);
    }

    $set_hour = isset($params['set_hour']) ? $params['set_hour'] : 8;
    $end_hour = isset($params['end_hour']) ? $params['end_hour'] : 19;

    $is_debug = ($G_config_common->get('Global', 'debug')
                 & ERROR_TRACE_LOG_FLAG_213);
    $config_grn = new CB_ConfigManager(cb_basedir() . '/garoon.ini', 'Global');
    if ( ! $config_grn || $is_debug) {
        $build_date = time();
    } else {
        $build_date = $config_grn->get('System', 'build_date');
    }
    $build_date .= '.text';

    $unit = 0;
    if (array_key_exists('unit', $params)) {
        $unit = intval($params['unit']);
    }

    if ($unit == 0) {
        $unit = 30;
    }

    $disable_link = array_key_exists('disable_link', $params)
        ? $params['disable_link'] : false;

    $private = 0;
    if (array_key_exists('private', $params)) {
        $private = $params['private'];
    }

    $tsex = new CB_TimeStampEx();
    // $sethour the begin time
    $sethour = $tsex->getDateTime();
    // $endhour the end time
    $endhour = $tsex->getDateTime();
    $date_set = $tsex->getDateTime();
    $date = new CB_Date();
    $date->parse($params['bdate']);

    $sethour->setDate($date);
    $endhour->setDate($date);
    $sethour->minute = $set_minute;
    $sethour->second = 0;
    $endhour->minute = $set_minute;
    $endhour->second = 0;

    $sethour->hour = intval($set_hour);
    $endhour->hour = intval($end_hour);

    $span = $endhour->getInterval($sethour);
    // テーブルの数
    $max_size = $span->toMinutes() / $unit;

    $setdatetime
        = _grn_schedule_convert_to_datetime_group_day_conflict($params['start_date']);
    $setdatetimestr = null;
    if (array_key_exists('start_date', $params)) {
        $setdatetimestr = $params['start_date'];
    }
    $enddatetime = null;
    if (array_key_exists('end_date', $params)) {
        $enddatetime = $params['end_date'];
    }


    // title
    $title = $params['title'];
    //GTM-103
    $menu = array_key_exists('menu', $params) ? $params['menu'] : "";
    $menu_color = array_key_exists('menu_color', $params)
        ? $params['menu_color'] : "";
    $detail = array_key_exists('detail', $params) ? $params['detail']
        : "";
    $facility_name = array_key_exists('facility_name', $params)
        ? $params['facility_name'] : "";
    $facility_after = array_key_exists('facility_after', $params)
        ? $params['facility_after'] : true;
    //End GTM-103
    unset($params['start_date']);
    unset($params['end_date']);
    unset($params['set_hour']);
    unset($params['end_hour']);
    unset($params['private']);
    unset($params['unit']);
    unset($params['title']);
    unset($params['disable_link']);

    unset($params['facility_name']);
    unset($params['facility_after']);
    unset($params['detail']);
    unset($params['menu']);
    unset($params['menu_color']);
    // event which added by simple add event
    $highlight = '';
    $aeid = cb_at($params, 'aeid', 0);
    if ($aeid == cb_at($params, 'event')) {
        $highlight = ' newevent-grn';
    }
    unset($params['aeid']);

    $msg = cb_msg('grn.schedule', 'conflict');
    $hTML_ConflictIcon = '<span class="attention">' . '<img src="'
                         . htmlspecialchars($app_path)
                         . '/grn/image/cybozu/attention16.gif?'
                         . $build_date . '" border="0" title="' . $msg
                         . '" alt="' . $msg . '" align="absmiddle">'
                         . '</span>';
    $hTML_AttendanceCheckIcon = "";
    if (cb_at($params,
            \grn\schedule\bean\AttendanceStatus::ATTENDANCE_CHECK_SHOW) == true
    ) {
        $msgAttendanceCheck = cb_msg('grn.schedule', 'GRN_SCH-1036');
        $hTML_AttendanceCheckIcon
            = "<img class='unanswered_icon_base_grn' alt='"
              . $msgAttendanceCheck . "' title='"
              . $msgAttendanceCheck
              . "' src=" . htmlspecialchars($app_path)
              . "/grn/image/cybozu/image-app-schedule/event_unanswered16.png?"
              . $build_date
              . " border='0'>";

    }
    if ( ! $private && ! $disable_link) {

        $page = $params['page'];
        unset($params['page']);
        $_event_title = $title;

        if ($menu_color != "" && $menu_color != "0") {
            $_event_title = $facility_name . '<span class="event_color'
                            . $menu_color . '_grn" >' . $menu . '</span>'
                            . $detail;
            if ($facility_after) {
                $_event_title = '<span class="event_color' . $menu_color
                                . '_grn" >' . $menu . '</span>' . $detail
                                . $facility_name;
            }
        }
        $str_title = '<a href="' . cb_pageurl($page, $params) . '" ' . $target
                     . '>'
                     . $hTML_ConflictIcon . $hTML_AttendanceCheckIcon
                     . $_event_title . '</a>';
    } else {
        $str_title = $title;
    }

    //GRN2-2286
    $absent = array_key_exists('absent', $params) ? $params['absent'] : 0;
    if ($absent === 1) {
        $str_title
            = '<div class="schedule_absent"><div class="normalEventElement" data-event_id="'
              . $params["event"] . '" data-event_type="' . $params["event_type"]
              . '" data-event_no_endtime="' . $params["no_endtime"]
              . '" data-event_data="' . $params["event_detail"]
              . '" data-event_start_date="' . $setdatetimestr
              . '" data-event_end_date="' . $enddatetime
              . '" data-event_bdate="' . $date->format()
              . '" data-event_set_hour="' . $set_hour . '" data-event_unit="'
              . $unit . '" data-event_offset_hour="' . $offset_info["hour"]
              . '" data-event_offset_minute="' . $offset_info["minute"] . '">'
              . $str_title . '</div></div>';
    } else {
        // GRN2-2287
        $str_title = '<div class="normalEventElement" data-event_id="'
                     . $params["event"] . '" data-event_type="'
                     . $params["event_type"] . '" data-event_no_endtime="'
                     . $params["no_endtime"] . '" data-event_data="'
                     . $params["event_detail"] . '" data-event_start_date="'
                     . $setdatetimestr . '" data-event_end_date="'
                     . $enddatetime . '" data-event_bdate="' . $date->format()
                     . '" data-event_set_hour="' . $set_hour
                     . '" data-event_unit="' . $unit
                     . '" data-event_offset_hour="' . $offset_info["hour"]
                     . '" data-event_offset_minute="' . $offset_info["minute"]
                     . '">' . $str_title . '</div>';
    }
    //GRN2-2286
    // 開始時刻が日付の場合は、終日しかないのですべてを埋める文字列を返す
    if (is_a($setdatetime, 'CB_Date')) {
        return '<td class="normalEvent' . $highlight . '" colspan="'
               . htmlspecialchars($max_size) . '">' . $str_title . '</td>';
    }

    // 時間ありのイベント
    if ($enddatetime) {
        $enddatetime
            = _grn_schedule_convert_to_datetime_group_day_conflict($enddatetime);
    } else {
        $enddatetime = $setdatetime;
    }

    // UNITによる丸め処理
    $split_minute = (int)($setdatetime->minute / $unit);
    $setdatetime->minute = $split_minute * $unit;

    // 割り切れない場合は後ろに
    if ((int)($enddatetime->minute % $unit) > 0) {
        $split_minute = (int)($enddatetime->minute / $unit);

        $enddatetime->minute = 0;
        $enddatetime->moveMinutes(($split_minute + 1) * $unit);
    }

    if ($setdatetime->compare($enddatetime) === 0) {
        $enddatetime->moveMinutes($unit);
    }

    // 時間内に表示できない場合は、空白行を表示
    if (($sethour->compare($enddatetime) >= 0)
        || ($endhour->compare($setdatetime) <= 0)
    ) {
        return '<td colspan="' . htmlspecialchars($max_size) . '">&nbsp;</td>';
    }

    $first = 0;
    $middle = 0;
    $end = 0;

    // 開始時間が表示時間より後の場合
    if ($sethour->compare($setdatetime) < 0) {
        $span = $sethour->getInterval($setdatetime);
        $first = (int)(abs($span->toMinutes()) / $unit);
    }

    // 終了時間が表示時間より前の場合
    if ($endhour->compare($enddatetime) > 0) {
        $span = $endhour->getInterval($enddatetime);
        $end = (int)(abs($span->toMinutes()) / $unit);
    }

    // イベントの時間
    $middle = $max_size - $first - $end;
    $str = '';

    if ($first > 0) {
        $str .= '<td colspan="' . htmlspecialchars($first)
                . '" class="group_day_calendar_item_conflicted group_day_calendar_color_conflicted_line"'
                . '">&nbsp;</td>';
    }

    $str .= '<td class="ddtd normalEvent group_day_calendar_item_conflicted group_day_calendar_color_booked'
            . $highlight . '" colspan="' . htmlspecialchars($middle) . '">'
            . $str_title . '</td>';

    if ($end > 0) {
        $str .= '<td colspan="' . htmlspecialchars($end)
                . '" class="group_day_calendar_item_conflicted group_day_calendar_color_conflicted_line"'
                . '">&nbsp;</td>';
    }

    return $str;
}

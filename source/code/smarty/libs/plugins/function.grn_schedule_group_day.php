<?php
require_once 'fw/date.csp';

/**
 * @name   grn_schedule_group_day
 */

function smarty_function_grn_schedule_group_day($params, &$smarty)
{
    $target = '';
    if (isset($params['target'])) {
        if ($params['target'] == 'blank') {
            $target = 'target="_' . $params['target'] . '"';
        }
    }

    if (isset($params['bdate'])) // normally exist value
    {
        $date = new CB_Date();
        $date->parse($params['bdate']);
        $dateex = new CB_DateEx($date);
        $dt = new CB_DateTime();
        $dt->year = $date->year;
        $dt->month = $date->month;
        $dt->day = $date->day;
        $ts = cb_datetime_to_timestamp($dt, $timezone);
    } else {
        $ts = new CB_TimeStamp();
        $ts->unix_ts = time();
        $tsex = new CB_TimeStampEx($ts);
        $date = $tsex->getDate();
        $dateex = new CB_DateEx($date);
    }

    //get user's working time
    $user_work_hours_list = [];
    if (isset($params['uid'])) {
        $user_work_hours_list
            = CB_UserWorkHours::selectByUserId($params['uid']);
    }

    global $G_config_common;
    $is_debug = ($G_config_common->get('Global', 'debug')
                 & ERROR_TRACE_LOG_FLAG_213);
    $config_grn = new CB_ConfigManager(cb_basedir() . '/garoon.ini', 'Global');
    if ( ! $config_grn || $is_debug) {
        $build_date = time();
    } else {
        $build_date = $config_grn->get('System', 'build_date');
    }
    $build_date .= '.text';

    $standard_timezone = CB_I18N::getInstance()->getCurrentTimezone();
    $timezone = isset($params['timezone']) ? $params['timezone']
        : $standard_timezone;

    $ts = time();
    $offset_info = CB_I18N::getTimezonesOffsetInfo($timezone,
        $standard_timezone, $ts);

    $set_hour = isset($params['set_hour']) ? $params['set_hour'] : 8;

    $end_hour = isset($params['end_hour']) ? $params['end_hour'] : 19;
    unset($params['set_hour'], $params['end_hour']);

    $page = $params['page'];
    unset($params['page']);

    $unit = 0;
    if (array_key_exists('unit', $params)) {
        $unit = intval($params['unit']);
        unset($params['unit']);
    }

    if ($unit == 0) {
        $unit = 30;
    }

    $view_cnflict = true;
    if (array_key_exists('view_conflict', $params)) {
        $view_cnflict = $params['view_conflict'];
        unset($params['view_conflict']);
    }

    $disable_link = array_key_exists('disable_link', $params)
        ? $params['disable_link'] : false;

    // アクセス権用のパラメータ（デフォルトは登録が可能）
    $access = array_key_exists('access', $params) ? $params['access'] : false;
    if ($access) {
        $access_add = array_key_exists('add', $access) ? $access['add'] : true;
        unset($params['access']);
    } else {
        $access_add = true;
    }
    $quick_add = array_key_exists('quick_add', $params) ? false : true;

    // 登録アイコン用のパラメータ
    $space_params = [];
    if (array_key_exists('uid', $params)) {
        $space_params['uid'] = $params['uid'];
    }
    if (array_key_exists('gid', $params)) {
        $space_params['gid'] = $params['gid'];
    }
    if (array_key_exists('bdate', $params)) {
        $space_params['bdate'] = $params['bdate'];
    }
    if (array_key_exists('referer_key', $params)) {
        $space_params['referer_key'] = $params['referer_key'];
    }

    global $G_config_common;
    $app_path = $G_config_common->get('Global', 'app_path');

    $colspan_all = ($end_hour - $set_hour) * (60 / $unit);
    $colspan_all = round($colspan_all);
    // 表示用配列
    $tmp_ary = [];

    $tmp_str = empty($user_work_hours_list) ? 'busy_time' : 'off_busy';
    for ($i = 0; $i <= $colspan_all; $i++) {
        $tmp_ary[$i] = $tmp_str;
    }

    $tmp_ary[$colspan_all] = 'end';

    // 稼働時間設定
    $user_bs = CB_UserBaseSetting::select($params['uid']);
    if ($user_bs) {
        foreach ($user_work_hours_list as $whour) {
            $whour_start = $whour->getStart();
            if ($whour_start) {
                $start_whour_to_array = explode(':', $whour_start);
                $hours = $start_whour_to_array[0];
                $minutes = $start_whour_to_array[1];
                $seconds = $start_whour_to_array[2];
                $whour_start_to_seconds = $hours * CB_TimeUnit::SECONDS_OF_HOUR
                                          + $minutes
                                            * CB_TimeUnit::MINUTES_OF_HOUR
                                          + $seconds;
                $whour_start = $whour_start_to_seconds
                               / CB_TimeUnit::SECONDS_OF_HOUR;
            }
            $user_work_set = ($whour_start - $offset_info['hour']);
            if ($user_work_set < 0) {
                $user_work_set += 24;
            }
            if ($user_work_set > 24) {
                $user_work_set -= 24;
            }
            $whour_end = $whour->getEnd();
            if ($whour_end) {
                $end_whour_to_array = explode(':', $whour_end);
                $hours = $end_whour_to_array[0];
                $minutes = $end_whour_to_array[1];
                $seconds = $end_whour_to_array[2];
                $whour_end_to_seconds = $hours * CB_TimeUnit::SECONDS_OF_HOUR
                                        + $minutes
                                          * CB_TimeUnit::MINUTES_OF_HOUR
                                        + $seconds;
                $whour_end = $whour_end_to_seconds
                             / CB_TimeUnit::SECONDS_OF_HOUR;
            }
            $user_work_end = ($whour_end - $offset_info['hour']);
            if ($user_work_end < 0) {
                $user_work_end += 24;
            }
            if ($user_work_end > 24) {
                $user_work_end -= 24;
            }
            if ($user_work_set > $user_work_end) {
                $user_bs = CB_UserBaseSetting::select($params['uid']);
                if ( ! $user_bs->isWorkday($dateex)) {
                    $user_work_end += 24;
                }
            }
            $span_key = ($user_work_set - $set_hour) * (60 / $unit);
            $span_key -= $offset_info['minute'] / $unit;
            $span_key = round($span_key);
            if ($span_key < 0) {
                $wstart = 0;
            } elseif ($span_key > $colspan_all) {
                $tmp_ary[$colspan_all] = 'busy_time';
                $wstart = $colspan_all;
            } else {
                $tmp_ary[$span_key] = 'busy_time';
                $wstart = $span_key;
            }

            $span_key = ($user_work_end - $set_hour) * (60 / $unit);
            $span_key -= $offset_info['minute'] / $unit;
            $span_key = round($span_key);
            if ($span_key < 0) {
                $wend = 0;
            } elseif ($span_key > $colspan_all) {
                $wend = $colspan_all;
            } else {
                $wend = $span_key;
            }

            if ($wstart < $wend) {
                for ($i = $wstart; $i < $wend; $i++) {
                    $tmp_ary[$i] = 'busy_time';
                }
            } elseif ($wstart > $wend) {
                for ($i = 0; $i < $wend; $i++) {
                    $tmp_ary[$i] = 'busy_time';
                }
                for ($i = $wstart; $i < $colspan_all; $i++) {
                    $tmp_ary[$i] = 'busy_time';
                }
            } else {
                if ($user_work_set > $user_work_end) {
                    for ($i = 0; $i < $colspan_all; $i++) {
                        $tmp_ary[$i] = 'busy_time';
                    }
                }
            }

            //If set "office hours" with start time equal end time
            //the office hours will be display all-day.
            if ($user_work_set == $user_work_end) {
                $user_bs = CB_UserBaseSetting::select($params['uid']);
                if ($user_bs->isWorkday($dateex)) {
                    for ($i = 0; $i < $colspan_all; $i++) {
                        $tmp_ary[$i] = 'busy_time';
                    }
                }
            }
        }

        // check working day
        $user_bs = CB_UserBaseSetting::select($params['uid']);
        $user_set_hour = $set_hour + $offset_info['hour'];
        $user_end_hour = $end_hour + $offset_info['hour'];
        if ($user_set_hour >= 24) // tomorrow
        {
            $dateex->moveDays(1);
            if ( ! $user_bs->isWorkday($dateex)) {
                for ($i = 0; $i <= $colspan_all; $i++) {
                    $tmp_ary[$i] = 'off_busy';
                }
            }
        } elseif ($user_end_hour < 0) // yesterday
        {
            $dateex->moveDays(-1);
            if ( ! $user_bs->isWorkday($dateex)) {
                for ($i = 0; $i <= $colspan_all; $i++) {
                    $tmp_ary[$i] = 'off_busy';
                }
            }
        } else {
            if ($user_set_hour < 0
                && $user_end_hour >= 0
            ) // yesterday and today
            {
                $border = (0 - $user_set_hour) * (60 / $unit);
                if ( ! $user_bs->isWorkday($dateex)) {
                    for ($i = $border; $i <= $colspan_all; $i++) {
                        $tmp_ary[$i] = 'off_busy';
                    }
                }
                $dateex->moveDays(-1);
                if ( ! $user_bs->isWorkday($dateex)) {
                    for ($i = 0; $i < $border; $i++) {
                        $tmp_ary[$i] = 'off_busy';
                    }
                }
            } elseif ($user_set_hour < 24
                      && $user_end_hour >= 24
            ) // today and tomorrow
            {
                $border = (24 - $user_set_hour) * (60 / $unit);
                if ( ! $user_bs->isWorkday($dateex)) {
                    if ($user_work_set > $user_work_end) {
                        for ($i = 0; $i < $wend; $i++) {
                            $tmp_ary[$i] = 'busy_time';
                        }
                        for ($i = $wend; $i < $border; $i++) {
                            $tmp_ary[$i] = 'off_busy';
                        }
                    } else {
                        for ($i = 0; $i < $border; $i++) {
                            $tmp_ary[$i] = 'off_busy';
                        }
                    }
                }
                $dateex->moveDays(1);
                if ( ! $user_bs->isWorkday($dateex)) {
                    for ($i = $border; $i <= $colspan_all; $i++) {
                        $tmp_ary[$i] = 'off_busy';
                    }
                }
            } else // today
            {
                if ( ! $user_bs->isWorkday($dateex)) {
                    for ($i = 0; $i <= $colspan_all; $i++) {
                        $tmp_ary[$i] = 'off_busy';
                    }
                }
            }
        }
    } else {
        // facility and organization are busy all time
        for ($i = 0; $i <= $colspan_all; $i++) {
            $tmp_ary[$i] = 'busy_time';
        }
    }

    $aeid = 0;
    if (array_key_exists('aeid', $params)) {
        $aeid = cb_at($params, 'aeid', 0);
        unset($params['aeid']);
    }

    $str = '';
    foreach ($params['data'] as $key => $value) {
        if ( ! is_array($value)) {
            continue;
        }
        if ( ! $value['allday']) {
            // 公開か非公開か
            $private = 0;
            if (array_key_exists('private', $value)) {
                $private = $value['private'];
            }

            // イベントの種類
            $type = 0;
            if (array_key_exists('type', $value)) {
                $type = $value['type'];
            }

            //関連するレポートが存在するかどうか
            $report = 0;
            if (array_key_exists('report', $value)) {
                $report = $value['report'];
            }

            // title
            $title = $value['data'];
            unset($params['data']);
            $params['event'] = $value['id'];

            // 表示するイベントのタイトルの作成
            $str_title = '';
            $hTML_ConflictIcon = "";
            $hTML_AttendanceCheckIcon = "";
            if ( ! $private) {
                if ($value['conflict']) {
                    $msg = cb_msg('grn.schedule', 'conflict');
                    $hTML_ConflictIcon .= '<span class="attention">'
                                          . '<img src="'
                                          . htmlspecialchars($app_path)
                                          . '/grn/image/cybozu/attention16.gif?'
                                          . $build_date . '" border="0" title="'
                                          . $msg . '" alt="' . $msg
                                          . '" align="absmiddle">' . '</span>';
                }
                if (cb_at($value,
                        \grn\schedule\bean\AttendanceStatus::ATTENDANCE_CHECK_SHOW)
                    == true
                ) {
                    $msgAttendanceCheck = cb_msg('grn.schedule',
                        'GRN_SCH-1036');
                    $hTML_AttendanceCheckIcon
                        .= "<img class='unanswered_icon_base_grn' alt='"
                           . $msgAttendanceCheck . "' title='"
                           . $msgAttendanceCheck
                           . "' src="
                           . htmlspecialchars($app_path)
                           . "/grn/image/cybozu/image-app-schedule/event_unanswered16.png?"
                           . $build_date
                           . " border='0' >";
                }
                $_evet_title = $title;
                if ($value['event_menu_color'] != ""
                    && $value['event_menu_color'] != "0"
                ) {
                    if ( ! array_key_exists('faci_items', $value)) {
                        $value['faci_items'] = '';
                    }
                    $_evet_title
                        = $value['event_facility_name']
                          . '<span class="event_color'
                          . $value['event_menu_color']
                          . '_grn" >' . $value['event_menu'] . '</span>'
                          . $value['event_detail'] . $value['creator_name']
                          . $value['faci_items'];
                    if ($value['facility_name_after']) {
                        $_evet_title
                            = '<span class="event_color'
                              . $value['event_menu_color'] . '_grn" >'
                              . $value['event_menu']
                              . '</span>' . $value['event_detail']
                              . $value['event_facility_name']
                              . $value['creator_name'] . $value['faci_items'];
                    }
                }
                if ($disable_link || ($view_cnflict && $value['conflict'])) {
                    $str_title .= $hTML_ConflictIcon . $hTML_AttendanceCheckIcon
                                  . $_evet_title;//$title;
                } else {
                    if ($type == "share_temporary" || $type == "temporary") {
                        $str_title .= '<span class="' . $type . '"><a href="'
                                      . cb_pageurl($page, $params) . '" '
                                      . $target . '>' . $hTML_ConflictIcon
                                      . $hTML_AttendanceCheckIcon
                                      . $_evet_title;
                    } else {
                        $str_title .= '<a href="' . cb_pageurl($page, $params)
                                      . '" ' . $target . '>'
                                      . $hTML_ConflictIcon
                                      . $hTML_AttendanceCheckIcon
                                      . $_evet_title;
                    }
                }
                if (array_key_exists('is_private', $value)
                    && $value['is_private']
                ) {
                    $str_title .= '<img src="' . htmlspecialchars($app_path)
                                  . '/grn/image/cybozu/image-common/privateMark_sub16.png?'
                                  . $build_date
                                  . '" border="0" align="absmiddle">';
                }

                switch ($type) {
                    case 'repeat':
                    case 'share_repeat':
                        $str_title .= '<img src="' . htmlspecialchars($app_path)
                                      . '/grn/image/cybozu/repeat16.gif?'
                                      . $build_date
                                      . '" border="0" align="absmiddle">';
                        break;
                    default:
                        break;
                }

                if ($report) {
                    $str_title .= '<img src="' . htmlspecialchars($app_path)
                                  . '/grn/image/cybozu/report16.gif?'
                                  . $build_date
                                  . '" border="0" align="absmiddle">';
                }

                $temporary_class = 'normalEvent ';
                if ($aeid == $value['id']) {
                    $temporary_class .= ' newevent-grn';
                }


                if ( ! $disable_link) {
                    if ($type == "share_temporary" || $type == "temporary") {
                        $str_title .= '</a></span>';
                    } else {
                        $str_title .= '</a>';
                    }
                }

            } else {
                $str_title = $value['data'];
            }
            //GRN2-2286
            if (array_key_exists('absent', $value) && $value['absent'] === 1) {
                $str_title
                    = '<div class="schedule_absent"><div class="normalEventElement" data-event_id="'
                      . $value["id"] . '" data-event_data="' . $value["data"]
                      . '" data-event_start_date="' . $value["start_date"]
                      . '" data-event_end_date="' . $value["end_date"]
                      . '" data-event_bdate="' . $date->format()
                      . '" data-event_set_hour="' . $set_hour
                      . '" data-event_unit="' . $unit
                      . '" data-event_offset_hour="' . $offset_info["hour"]
                      . '" data-event_offset_minute="' . $offset_info["minute"]
                      . '" data-event_no_endtime="' . $value["no_endtime"]
                      . '"> <span>' . $_event_title . '</span></div></div>';
            } //GRN2-2286
            else {
                $str_title = '<div class="normalEventElement" data-event_id="'
                             . $value["id"] . '" data-event_data="'
                             . $value["data"] . '" data-event_start_date="'
                             . $value["start_date"] . '" data-event_end_date="'
                             . $value["end_date"] . '" data-event_bdate="'
                             . $date->format() . '" data-event_set_hour="'
                             . $set_hour . '" data-event_unit="' . $unit
                             . '" data-event_offset_hour="'
                             . $offset_info["hour"]
                             . '" data-event_offset_minute="'
                             . $offset_info["minute"]
                             . '" data-event_no_endtime="'
                             . $value["no_endtime"] . '">' . $str_title
                             . '</div>';
            }

            $tsex = new CB_TimeStampEx();
            $event_start_time = $tsex->getDateTime();
            $event_start_time->parse($value['start_date']);
            $event_end_time = $tsex->getDateTime();
            $event_end_time->parse($value['end_date']);

            $now_date = $tsex->getDateTime();
            $now_date->setDate($date);

            if ($event_start_time->getDate() != $event_end_time->getDate()) {
                if ($now_date->compare($event_end_time) < 0
                    && $now_date->getDate() != $event_end_time->getDate()
                ) {
                    $event_end_time->year = $now_date->year;
                    $event_end_time->month = $now_date->month;
                    $event_end_time->day = $now_date->day;
                    $event_end_time->hour = 24;
                    $event_end_time->minute = 0;
                    $event_end_time->second = 0;
                }

                if ($now_date->compare($event_start_time) > 0
                    && $now_date->getDate() != $event_start_time->getDate()
                ) {
                    $event_start_time->year = $now_date->year;
                    $event_start_time->month = $now_date->month;
                    $event_start_time->day = $now_date->day;
                    $event_start_time->hour = 0;
                    $event_start_time->minute = 0;
                    $event_start_time->second = 0;
                }
            }

            $estart = ($event_start_time->hour - $set_hour) * (60 / $unit);
            $estart += floor($event_start_time->minute / $unit);
            $eend = ($event_end_time->hour - $set_hour) * (60 / $unit);
            $eend += ceil($event_end_time->minute / $unit);
            // 開始時刻と終了時刻が同じ時は、1枠確保する
            if ($estart == $eend) {
                $eend++;
            }
            for ($i = $estart; $i < $eend; $i++) {
                if ($tmp_ary[$i] == 'busy_time' || $tmp_ary[$i] == 'off_busy') {
                    $tmp_ary[$i] = [
                        'key'   => $key,
                        'class' => $temporary_class,
                        'title' => $str_title
                    ];
                }
            }
        }
    }

    for ($i = 0; $i <= $colspan_all; $i++) {
        $value = $tmp_ary[$i];
        for ($j = $i + 1; $j <= $colspan_all; $j++) {
            if ($tmp_ary[$j] != $tmp_ary[$i] || $j == $colspan_all) {
                $span = $j - $i;
                if ($value == 'busy_time') {
                    $str .= '<td colspan="' . htmlspecialchars($span)
                            . '" class="group_day_calendar_item group_day_calendar_color_available"';
                    if ($disable_link || ! $access_add) {
                        $str .= '>&nbsp;</td>';
                    } else {
                        if ($quick_add) {
                            $utype = array_key_exists('facility_id', $params)
                                     && strlen($params['facility_id']) > 0
                                ? ' utype="facility"' : '';
                            $str .= ' onmouseover="if(typeof(GRN_ScheduleSimpleAdd)!==\'undefined\'){GRN_ScheduleSimpleAdd.mouseOverHandler(event, this);}" onmouseout="if (typeof(GRN_ScheduleSimpleAdd)!==\'undefined\'){GRN_ScheduleSimpleAdd.mouseOutHandler(event, this);}" rel="'
                                    . cb_pageurl('schedule/simple_add',
                                    $space_params) . '" plid="'
                                    . @$params['plid'] . '"' . $utype
                                    . '><div class="addEvent"><a href="'
                                    . cb_pageurl('schedule/add',
                                    $space_params)
                                    . '"><div class="iconWrite-grn"></div></a></div></td>';
                        } else {
                            $str .= '><div class="addEvent"><a href="'
                                    . cb_pageurl('schedule/add', $space_params)
                                    . '"><div class="iconWrite-grn"></div></a></div></td>';
                        }
                    }
                } elseif ($value == 'off_busy') {
                    $str .= '<td colspan="' . htmlspecialchars($span)
                            . '" class="group_day_calendar_item group_day_calendar_color_offtime"><br>&nbsp;</td>';
                } else {
                    /* GTM-101*/
                    $str .= '<td colspan="' . htmlspecialchars($span)
                            . '" class="ddtd ddtd_middle group_day_calendar_item group_day_calendar_color_booked '
                            . $value['class'] . '">' . $value['title']
                            . '</td>';
                    /* End GTM-101*/
                }
                if ($j == $colspan_all) {
                    break(2);
                }
                $i = $j - 1;
                break;
            }
        }
    }

    return $str;
}

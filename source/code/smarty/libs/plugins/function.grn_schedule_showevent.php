<?php
require_once 'fw/date.csp';

function _grn_schedule_compare_date(& $date1, & $date2)
{
    $ydiff = $date1->year - $date2->year;
    if ($ydiff !== 0) {
        return $ydiff;
    }

    $mdiff = $date1->month - $date2->month;
    if ($mdiff !== 0) {
        return $mdiff;
    }

    $ddiff = $date1->day - $date2->day;
    if ($ddiff !== 0) {
        return $ddiff;
    }

    return 0;
}

/**
 * @name   grn_schedule_showevent
 *  サブタイトル
 *
 */

function smarty_function_grn_schedule_showevent($params, &$smarty)
{
    $page = $params['page'];
    $left = $params['left'];
    $week = $params['week'];

    // 登録アイコン用のパラメータ

    $space_params = [];

    if (array_key_exists('uid', $params)) {
        $space_params['uid'] = $params['uid'];
    }
    if (array_key_exists('gid', $params)) {
        $space_params['gid'] = $params['gid'];
    }
    if (array_key_exists('referer_key', $params)) {
        $space_params['referer_key'] = $params['referer_key'];
    }

    global $G_config_common;
    $app_path = $G_config_common->get('Global', 'app_path');

    $is_debug = ($G_config_common->get('Global', 'debug')
                 & ERROR_TRACE_LOG_FLAG_213);
    $config_grn = new CB_ConfigManager(cb_basedir() . '/garoon.ini', 'Global');
    if ( ! $config_grn || $is_debug) {
        $build_date = time();
    } else {
        $build_date = $config_grn->get('System', 'build_date');
    }
    $build_date .= '.text';

    $tmp_data = $params['data'];
    $class = 'critical1';

    static $init = null;
    static $sethour = null;
    static $endhour = null;
    static $setdatetime = null;
    static $enddatetime = null;

    if (is_null($init)) {
        $date = new CB_Date();
        $tsex = new CB_TimeStampEx();
        $sethour = &$tsex->getDateTime();
        $sethour->hour = intval($params['set_hour']);
        $sethour->minute = 0;
        $sethour->second = 0;
        $endhour = &$tsex->getDateTime();
        $endhour->hour = intval($params['end_hour']);
        $endhour->minute = 0;
        $endhour->second = 0;
        $setdatetime = new CB_DateTime();
        $enddatetime = new CB_DateTime();
    }

    foreach ($tmp_data as $event_data) {
        if ( ! is_array($event_data)
             || ! array_key_exists('event', $event_data)
        ) {
            continue;
        }

        $date->parse($event_data['date']);
        $sethour->year = $date->year;
        $sethour->month = $date->month;
        $sethour->day = $date->day;
        $endhour->year = $date->year;
        $endhour->month = $date->month;
        $endhour->day = $date->day;
        if (intval($params['set_hour']) === 24) {
            $endhour->moveDays(1);
        }

        $prv_schedule = [];
        foreach ($event_data['event'] as $value) {
            if ( ! is_array($value)) {
                continue;
            }

            if ( ! $value['allday']) {
                $private = 0;

                if (array_key_exists('private', $value)) {
                    $private = $value['private'];
                }

                $type = 0;
                if (array_key_exists('type', $value)) {
                    $type = $value['type'];
                }

                //関連づいた報告書が存在するかどうか
                $report = 0;
                if (array_key_exists('report', $value)) {
                    $report = $value['report'];
                }

                if (array_key_exists('date', $event_data)) {
                    $space_params['bdate'] = $event_data['date'];
                }

                $setdatetime->parse($value['start_date']);
                // 時間ありのイベント
                if (array_key_exists('end_date', $value)) {
                    $enddatetime->parse($value['end_date']);
                } else {
                    $enddatetime->year = $setdatetime->year;
                    $enddatetime->month = $setdatetime->month;
                    $enddatetime->day = $setdatetime->day;
                    $enddatetime->hour = $setdatetime->hour;
                    $enddatetime->minute = $setdatetime->minute;
                }

                // title
                $title = $value['data'];
                $space_params['event'] = $value['id'];

                $str_title = '';
                if ( ! $private) {
                    unset($params['page']);
                    if ($value['conflict']) {
                        $msg = cb_msg('grn.schedule', 'conflict');
                        $str_title .= '<span class="attention">' . '<img src="'
                                      . htmlspecialchars($app_path)
                                      . '/grn/image/cybozu/attention16.gif?'
                                      . $build_date . '" border="0" title="'
                                      . $msg . '" alt="' . $msg
                                      . '" align="absmiddle">' . '</span>';
                    }
                    if ($disable_link) {
                        $str_title .= $title;
                    } else {
                        $str_title .= '<a href="' . cb_pageurl($page,
                                $space_params) . '">' . $title;
                    }

                    if (array_key_exists('is_private', $value)
                        && $value['is_private']
                    ) {
                        $str_title .= '<img src="' . htmlspecialchars($app_path)
                                      . '/grn/image/cybozu/image-common/privateMark_sub16.png?'
                                      . $build_date
                                      . '" border="0" align="absmiddle">';
                    }

                    if ($type == "repeat" || $type == "share_repeat") {
                        $str_title .= '<img src="' . htmlspecialchars($app_path)
                                      . '/grn/image/cybozu/repeat16.gif?'
                                      . $build_date
                                      . '" border="0" align="absmiddle">';
                    }

                    if ($report) {
                        $str_title .= '<img src="' . htmlspecialchars($app_path)
                                      . '/grn/image/cybozu/report16.gif?'
                                      . $build_date
                                      . '" border="0" align="absmiddle">';
                    }


                    if ($type == 'share_temporary' || $type == 'temporary') {
                        $class .= ' temporary';
                    }

                    if ( ! $disable_link) {
                        $str_title .= '</a>';
                    }

                } else {
                    $str_title = $title;
                }

                // イベントの時間
                $str = '';


                // 高さ
                $start_hour = 0;
                if ($sethour->compare($setdatetime) < 0) {
                    $start_hour = $setdatetime->hour;
                } else {
                    $start_hour = $sethour->hour;
                }

                $e = $start_hour - $sethour->hour;

                $top = ($e * 30);
                if ($top < 0) {
                    $top = '0';
                } elseif ($setdatetime->minute) {
                    $top = $top + ($setdatetime->minute / 2);
                }

                // 縦幅
                if ($endhour->compare($enddatetime) >= 0) {
                    $r = $enddatetime->hour - $start_hour;
                } else {
                    $r = $endhour->hour - $start_hour;
                }

                $height = ($r + 1) * 30;
                if ($setdatetime->minute > 1) {
                    $q = ($setdatetime->minute / 2);
                }

                $u = 30 - ($enddatetime->minute / 2);

                $tmp_height = $height - $q - $u;
                if ($tmp_height < 15) {
                    $tmp_height = 15;
                }

                // left.position
                if ($value['conflict']) {
                    if ($eye) {
                        if ($week) {
                            $see = 12;
                        } else {
                            $see = 100;
                        }
                        $currentdatetime = new CB_DateTimeEx($setdatetime);
                        if ( ! empty($prv_schedule)) {
                            $eye = 0;
                            foreach ($prv_schedule as $key => $value_1) {
                                if ($currentdatetime->compare($value_1['end_date'])
                                    < 0
                                ) {
                                    $eye = $value_1['eye'] + 1;
                                }
                            }
                        }
                        //GRN2-2286
                        $prv_schedule[] = [
                            'end_date' => $enddatetime,
                            'eye'      => $eye,
                            'absent'   => $value['absent']
                        ];
                        //GRN2-2286
                        $tmp_left = $left + ($eye * $see);
                        $eye = $eye + 1;
                    } else {
                        $tmp_left = $left;
                        $eye = 1;
                        $prv_schedule[] = [
                            'end_date' => $enddatetime,
                            'eye'      => 0,
                            'absent'   => $value['absent']
                        ];
                    }
                } else {
                    $tmp_left = $left;
                    $eye = 0;
                    $prv_schedule = [];
                }

                if ($week) {
                    $width = 105;
                } else {
                    $width = 200;
                }

                // 表示と同じ日にスタート
                if (_grn_schedule_compare_date($date, $setdatetime) === 0) {
                    $showtime = cb_date_format("TimeFormat", $setdatetime);
                } else {
                    $showtime = cb_date_format("ShortDateFormat", $setdatetime);
                }
                $max_width = $width - 1;

                $aeid = cb_at($params, 'aeid', 0);
                if ($aeid == $value['id']) {
                    $class .= " newevent-grn";
                }
                $str .= '<div class="' . $class . '" style="width:'
                        . htmlspecialchars($width) . 'px; top:'
                        . htmlspecialchars($top) . 'px; left:'
                        . htmlspecialchars($tmp_left) . 'px; height:'
                        . htmlspecialchars($tmp_height) . 'px; max-width:'
                        . htmlspecialchars($max_width) . 'px; max-height:'
                        . htmlspecialchars($tmp_height)
                        . 'px;" onMouseOver="ove(this)"><font size="-1">'
                        . $showtime . ' ' . $str_title . '</font></div>';
                //GRN2-2286
                if (array_key_exists('absent', $value)
                    || array_key_exists('eye', $value)
                ) {
                    if ($value['absent'] === 1) {
                        $str = '';
                        $class .= " schedule_absent_personal";
                        $str .= '<div class="schedule_absent ' . $class
                                . '" style="width:' . htmlspecialchars($width)
                                . 'px; top:' . htmlspecialchars($top)
                                . 'px; left:' . htmlspecialchars($tmp_left)
                                . 'px; height:'
                                . htmlspecialchars($tmp_height)
                                . 'px; max-width:'
                                . htmlspecialchars($max_width)
                                . 'px; max-height:'
                                . htmlspecialchars($tmp_height)
                                . 'px;" onMouseOver="ove(this)"><font size="-1">'
                                . $showtime . ' ' . $str_title
                                . '</font></div>';
                    }
                }
                //GRN2-2286
                print $str;

                if (strstr($class, 'critical1') === false) {
                    $class = 'critical1';
                } else {
                    $class = 'critical2';
                }
            }
            $q = 0;
            $u = 0;
        }

        $eye = 0;

        if ($week) {
            $left = $left + 105;
        }
    }
}


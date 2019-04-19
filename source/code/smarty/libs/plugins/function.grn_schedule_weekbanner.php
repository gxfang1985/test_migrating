<?php

/**
 * ブランク部分の表示
 *
 * @access private
 */
function _grn_schedule_show_blank($setdate, $enddate, $class)
{
    $timespan = $setdate->getInterval($enddate);
    $colspan = abs($timespan->toDays());

    return '<td class="' . htmlspecialchars($class) . '" colspan="'
           . htmlspecialchars($colspan) . '"><br></td>';
}

/**
 * バナーの表示
 *
 * @access private
 */
function _grn_schedule_show_banner(
    $page,
    $uid,
    $gid,
    $bdate,
    $term,
    $event_id,
    $title,
    $banner_image,
    $deny_link,
    $class,
    $week_type,
    $referer_key,
    $onclick,
    $smarty,
    $report = false,
    $report_image = null,
    $absent = null,
    $star_date = null,
    $event_menu = null,
    $event_menu_color = null,
    $event_detail = null
) {
    $term = explode('_', $term);
    $colspan = intval($term[1]) - intval($term[0]) + 1;

    $str = '<td class="' . htmlspecialchars($class) . ' normalEvent"';
    if ($colspan > 1) {
        $str .= ' colspan="' . htmlspecialchars($colspan) . '"';
    }
    $str .= '>' . "\r\n";
    if ($absent === 1) {
        $str .= '<div class="normalEventElement schedule_absent">';
    } else {
        $str .= '<div class="normalEventElement">';
    }

    // update bdate for banner schedule with timezone
    $bdate = substr($bdate, 0, 10);

    if ($week_type == 'personal') {
        $str .= '<div style="width:' . 90 * $colspan . 'px;overflow:hidden">';
    }

    if ( ! $deny_link && is_null($referer_key)) {
        $str .= '<a href="' . cb_pageurl($page, [
                'uid'   => $uid,
                'gid'   => $gid,
                'bdate' => $bdate,
                'event' => $event_id
            ]) . '" ' . $onclick . ' >';
    } elseif ( ! $deny_link && ! is_null($referer_key)) {
        $str .= '<a href="' . cb_pageurl($page, [
                'uid'         => $uid,
                'gid'         => $gid,
                'bdate'       => $bdate,
                'event'       => $event_id,
                'referer_key' => $referer_key
            ]) . '" ' . $onclick . ' >';
    }

    require_once($smarty->_get_plugin_filepath('function', 'grn_image'));
    $str .= smarty_function_grn_image(['image' => $banner_image], $smarty);
    //GTM-103
    if ($event_menu != null && $event_menu_color != null
        && $event_menu_color != "0"
    ) {
        $str .= '<span class="event_color' . $event_menu_color . '_grn" >'
                . $event_menu . '</span>' . $event_detail;
    } else {
        $str .= $title;
    }
    //End GTM-103
    if ($report) {
        $str .= smarty_function_grn_image(['image' => $report_image], $smarty);
    }

    if ( ! $deny_link) {
        $str .= '</a>';
    }

    if ($week_type == 'personal') {
        $str .= '</div>';
    }

    $str .= '</div></td>';

    return $str;
}


/*
 * バナーの表示を行う
 */
function smarty_function_grn_schedule_weekbanner($params, $smarty)
{
    $str = '';
    // バナーイベント
    $banners_input = array_key_exists('banner_events', $params)
        ? $params['banner_events'] : null;
    if ( ! is_array($banners_input) || count($banners_input) === 0) {
        return $str;
    }

    $week_type = array_key_exists('week_type', $params) ? $params['week_type']
        : null;
    $trid = array_key_exists('trid', $params) ? $params['trid'] : null;
    $plid = array_key_exists('plid', $params) ? $params['plid'] : null;

    $display_flag = array_key_exists('display_flag', $params)
        ? $params['display_flag'] : null;

    // 表示の開始位置と終了位置
    $setdate = array_key_exists('setdate', $params) ? $params['setdate'] : null;
    if ( ! is_a($setdate, 'CB_Date') && ! is_a($setdate, 'CB_DateTime')) {
        return $str;
    }
    $enddate = array_key_exists('enddate', $params) ? $params['enddate'] : null;
    if ( ! is_a($enddate, 'CB_Date') && ! is_a($enddate, 'CB_DateTime')) {
        return $str;
    }

    // リンクをOffにするか
    $deny_link = array_key_exists('deny_link', $params) ? $params['deny_link']
        : false;

    $banner_class = array_key_exists('banner_class', $params)
        ? $params['banner_class'] : 's_banner';
    $blank_class = array_key_exists('blank_class', $params)
        ? $params['blank_class'] : 'br_banner';

    $uid = array_key_exists('uid', $params) ? $params['uid'] : null;
    $gid = array_key_exists('gid', $params) ? $params['gid'] : null;
    $referer_key = array_key_exists('referer_key', $params)
        ? $params['referer_key'] : null;

    $banner_image = array_key_exists('banner_image', $params)
        ? $params['banner_image'] : 'banner16.gif';
    $view_page = array_key_exists('page', $params) ? $params['page']
        : 'schedule/view';
    $report_image = array_key_exists('report_image', $params)
        ? $params['report_image'] : 'report16.gif';
    $onclick = array_key_exists('onclick', $params) ? 'onclick="'
                                                      . htmlspecialchars($params['onclick'])
                                                      . '"' : '';
    // separate banner for timezone
    $banners_separate = [];
    $banners_separate['normal'] = [];
    $banners_separate['normal_before_tz'] = [];
    $banners_separate['normal_after_tz'] = [];
    foreach (array_keys($banners_input) as $key1) {
        foreach (array_keys($banners_input[$key1]) as $key2) {
            $banner = $banners_input[$key1][$key2];
            $only_view_tz = isset($banner['only_view_tz'])
                ? $banner['only_view_tz'] : null;
            if ( ! $only_view_tz) {
                $banners_separate['normal'][$key1][] = $banner;
            } elseif ($only_view_tz == 1) {
                $banners_separate['normal_before_tz'][$key1][] = $banner;
            }
            if ($only_view_tz == 2) {
                $banners_separate['normal_after_tz'][$key1][] = $banner;
            }
        }
    }

    $WDate = new CB_DateEx($setdate);
    foreach ($banners_separate as $banners) {
        foreach (array_keys($banners) as $key1) {
            $event_tz_class = '';
            $show_users_timezone = isset($params['show_users_timezone'])
                ? $params['show_users_timezone'] : null;
            foreach (array_keys($banners[$key1]) as $key2) {
                $banner = $banners[$key1][$key2];
                $only_view_tz = isset($banner['only_view_tz'])
                    ? $banner['only_view_tz'] : null;
                if ($only_view_tz === 1) // for source sh
                {
                    if ( ! $show_users_timezone) {
                        $event_tz_class = ' class="sh_title_normal" ';
                    } else {
                        $event_tz_class
                            = ' class="sh_title_normal hide_event" ';
                    }
                } elseif ($only_view_tz === 2) // for sh timezone
                {
                    if ($show_users_timezone) {
                        $event_tz_class = ' class="sh_title_tz" ';
                    } else {
                        $event_tz_class = ' class="sh_title_tz hide_event" ';
                    }
                }
                break;
            }

            if (is_null($trid)) {
                $str .= '<tr ' . $event_tz_class . ' >';
            } else {
                if ($display_flag == 'false') {
                    $str .= '<tr id="um_' . htmlspecialchars($plid) . '_'
                            . htmlspecialchars($trid) . '_'
                            . htmlspecialchars($key1)
                            . '" style="display:none;" ' . $event_tz_class
                            . ' >';
                } else {
                    $str .= '<tr id="um_' . htmlspecialchars($plid) . '_'
                            . htmlspecialchars($trid) . '_'
                            . htmlspecialchars($key1) . '" ' . $event_tz_class
                            . ' >';
                }
            }

            switch ($week_type) {
                case 'personal':
                    $str .= '<td style="border-left:1px solid #cccccc;border-top:1px solid #cccccc;padding:4px;" bgcolor="#ffffff"><br></td>';
                    break;
                case 'group';
                    $str .= '<td style="border-right:1px solid #C9C9C9"><br></td>';
                    break;
            }
            $str .= "\r\n";

            foreach (array_keys($banners[$key1]) as $key2) {
                $banner = $banners[$key1][$key2];
                if ( ! is_array($banner)) {
                    continue;
                }

                $report = false;
                if (array_key_exists('report', $banner)) {
                    $report = $banner['report'];
                }

                //GRN2-2718
                $star_date = array_key_exists('star_date', $banner)
                    ? $banner['star_date'] : null;
                //GRN2-2718

                //GRN2-2286
                $absent = array_key_exists('absent', $banner)
                    ? $banner['absent'] : 0;
                //GRN2-2286
                // そのまま表示
                if ($WDate->compare($banner['setdate']) >= 0) {
                    $str .= _grn_schedule_show_banner($view_page, $uid, $gid,
                        $banner['date'], $banner['term'], $banner['id'],
                        $banner['data'], $banner_image, $deny_link,
                        $banner_class, $week_type, $referer_key, $onclick,
                        $smarty, $report, $report_image, $absent, $star_date,
                        $banner['event_menu'], $banner['event_menu_color'],
                        $banner['event_detail']);
                } // ブランクをとってから表示
                else {
                    $str .= _grn_schedule_show_blank($WDate, $banner['setdate'],
                        $blank_class);
                    $str .= "\r\n";
                    $str .= _grn_schedule_show_banner($view_page, $uid, $gid,
                        $banner['date'], $banner['term'], $banner['id'],
                        $banner['data'], $banner_image, $deny_link,
                        $banner_class, $week_type, $referer_key, $onclick,
                        $smarty, $report, $report_image, $absent, $star_date,
                        $banner['event_menu'], $banner['event_menu_color'],
                        $banner['event_detail']);
                }

                $WDate->year = $banner['enddate']->year;
                $WDate->month = $banner['enddate']->month;
                $WDate->day = $banner['enddate']->day;
                $WDate->moveDays(1);
                $str .= "\r\n";
            }

            // あまった部分をブランクで埋める
            if ($WDate->compare($enddate) <= 0) {
                $WDate->moveDays(-1);
                $str .= _grn_schedule_show_blank($WDate, $enddate,
                    $blank_class);
                $str .= "\r\n";
            }

            $str .= '</tr>';
            $str .= "\r\n";

            $WDate->year = $setdate->year;
            $WDate->month = $setdate->month;
            $WDate->day = $setdate->day;
        }
    }

    return $str;
}



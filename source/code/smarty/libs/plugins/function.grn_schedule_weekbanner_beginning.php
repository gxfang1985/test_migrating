<?php

/**
 * ブランク部分の表示
 *
 * @access private
 */
function _grn_schedule_show_blank_beginning($setdate, $enddate, $class)
{
    $timespan = &$setdate->getInterval($enddate);
    $colspan = abs($timespan->toDays());

    return '<td class="' . htmlspecialchars($class) . '" colspan="'
           . htmlspecialchars($colspan) . '"><br></td>';
}

/**
 * AJAXスケジューラ用バナーの表示
 *
 * @access private
 */
function _grn_schedule_show_banner_beginning(
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
    &$smarty,
    $use_star = false,
    $star_infos = null,
    $star_date = null,
    $report = false,
    $report_image = null,
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
    $str .= '>';
    $str .= '<div class="normalEventElement">';

    // update bdate for banner schedule with timezone
    $bdate = substr($bdate, 0, 10);
    // star app
    if ($use_star) {
        if ( ! $star_date) {
            $star_date = $bdate;
        }
        $params = [
            'module'     => GRN_SCHEDULE_MODULE_ID,
            'star_infos' => $star_infos,
            'unique_id'  => $event_id,
            'event'      => $event_id,
            'uid'        => $uid,
            'bdate'      => $star_date
        ];
        require_once($smarty->_get_plugin_filepath('function',
            'grn_star_icon'));
        $str .= smarty_function_grn_star_icon($params, $smarty);
    }
    // end star app

    if ($week_type == 'personal') {
        $str .= '<div style="width:' . 90 * htmlspecialchars($colspan)
                . 'px;overflow:hidden">';
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
    // 共有マーク

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
function smarty_function_grn_schedule_weekbanner_beginning(
    $params,
    &$smarty,
    &$gw_banner
) {
    // バナーイベント
    $beginning_banner_events = array_key_exists('banner_events', $params)
        ? $params['banner_events'] : null;
    if ( ! is_array($beginning_banner_events)
         || count($beginning_banner_events) === 0
    ) {
        return $gw_banner;
    }

    $display_no = array_key_exists('display_no', $params)
        ? $params['display_no'] : null;
    $user_counter = array_key_exists('user_counter', $params)
        ? $params['user_counter'] : null;
    $tdid = array_key_exists('tdid', $params) ? $params['tdid'] : 0;
    $plid = array_key_exists('plid', $params) ? $params['plid'] : null;

    for ($i = 0; $i < count($beginning_banner_events); ++$i) {
        // 指定行以外は返さない。
        if ( ! is_null($display_no) && $i != $display_no) {
            continue;
        }

        // バナーイベント
        $banners_input = $beginning_banner_events[$i];

        $week_type = array_key_exists('week_type', $params)
            ? $params['week_type'] : null;

        // 表示の開始位置と終了位置
        $setdate = array_key_exists('setdate', $params)
            ? clone $params['setdate'] : null;
        if ( ! is_a($setdate, 'CB_Date') && ! is_a($setdate, 'CB_DateTime')) {
            return $gw_banner;
        }
        $setdate->moveDays($i);

        $enddate = clone $setdate;
        $enddate->moveDays(7);

        // リンクをOffにするか
        $deny_link = array_key_exists('deny_link', $params)
            ? $params['deny_link'] : false;

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

        $use_star = @$params['use_star'];
        $star_infos = @$params['star_infos'];

        if ( ! empty($banners_input)) {
            $str = '';
        }

        // separate banner for timezone
        $banners_separate = [];
        $banners_separate['normal'] = [];
        $banners_separate['normal_before_tz'] = [];
        $banners_separate['normal_after_tz'] = [];
        foreach (array_keys($banners_input) as $key1) {
            foreach (array_keys($banners_input[$key1]) as $key2) {
                $banner = &$banners_input[$key1][$key2];
                $only_view_tz = @$banner['only_view_tz'];
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
                $show_users_timezone = @$params['show_users_timezone'];
                foreach (array_keys($banners[$key1]) as $key2) {
                    $banner = &$banners[$key1][$key2];
                    $only_view_tz = @$banner['only_view_tz'];
                    if ($only_view_tz === 1) // for source sh
                    {
                        if ( ! $show_users_timezone) {
                            $event_tz_class = ' sh_title_normal ';
                        } else {
                            $event_tz_class = ' sh_title_normal hide_event ';
                        }
                    } elseif ($only_view_tz === 2) // for sh timezone
                    {
                        if ($show_users_timezone) {
                            $event_tz_class = ' sh_title_tz ';
                        } else {
                            $event_tz_class = ' sh_title_tz hide_event ';
                        }
                    }
                    break;
                }

                if ( ! is_null($display_no)) {
                    $str .= '<tr id="gw_' . htmlspecialchars($plid) . '_user_'
                            . htmlspecialchars($display_no) . '_'
                            . htmlspecialchars($user_counter) . '_'
                            . htmlspecialchars($key1)
                            . '"  class="schedule_banner_tr ' . $event_tz_class
                            . '">';
                } else {
                    $str .= '<tr id="gw_' . htmlspecialchars($plid) . '_user_'
                            . (htmlspecialchars($i) + htmlspecialchars($tdid))
                            . '_' . htmlspecialchars($user_counter) . '_'
                            . htmlspecialchars($key1)
                            . '" class="schedule_banner_tr ' . $event_tz_class
                            . '">';
                }

                switch ($week_type) {
                    case 'personal':
                        $str .= '<td style="border-left:1px solid #cccccc;border-top:1px solid #cccccc;padding:4px;" bgcolor="#ffffff"><br></td>';
                        break;
                    case 'group';
                        $str .= '<td style="border-right:1px solid #c9c9c9"><br></td>';
                        break;
                }

                foreach (array_keys($banners[$key1]) as $key2) {
                    $banner = &$banners[$key1][$key2];
                    if ( ! is_array($banner)) {
                        continue;
                    }

                    //GRN2-2718
                    $star_date = array_key_exists('star_date', $banner)
                        ? $banner['star_date'] : null;
                    //GRN2-2718

                    $report = false;
                    if (array_key_exists('report', $banner)) {
                        $report = $banner['report'];
                    }
                    // そのまま表示
                    if ($WDate->compare($banner['setdate']) >= 0) {
                        $str .= _grn_schedule_show_banner_beginning($view_page,
                            $uid, $gid, $banner['date'], $banner['term'],
                            $banner['id'], $banner['data'], $banner_image,
                            $deny_link, $banner_class, $week_type, $referer_key,
                            $onclick, $smarty, $use_star, $star_infos,
                            $star_date, $report, $report_image,
                            $banner['event_menu'], $banner['event_menu_color'],
                            $banner['event_detail']);
                    } // ブランクをとってから表示
                    else {
                        $str .= _grn_schedule_show_blank_beginning($WDate,
                            $banner['setdate'], $blank_class);
                        $str .= _grn_schedule_show_banner_beginning($view_page,
                            $uid, $gid, $banner['date'], $banner['term'],
                            $banner['id'], $banner['data'], $banner_image,
                            $deny_link, $banner_class, $week_type, $referer_key,
                            $onclick, $smarty, $use_star, $star_infos,
                            $star_date, $report, $report_image,
                            $banner['event_menu'], $banner['event_menu_color'],
                            $banner['event_detail']);
                    }

                    $WDate->year = $banner['enddate']->year;
                    $WDate->month = $banner['enddate']->month;
                    $WDate->day = $banner['enddate']->day;
                    $WDate->moveDays(1);
                }

                // あまった部分をブランクで埋める
                if ($WDate->compare($enddate) < 0) {
                    $str .= _grn_schedule_show_blank_beginning($WDate, $enddate,
                        $blank_class);
                }

                $str .= '</tr>';

                $WDate->year = $setdate->year;
                $WDate->month = $setdate->month;
                $WDate->day = $setdate->day;
            }
        }

        if ( ! empty($banners_input)) {
            $gw_banner[$plid][$user_counter][$i + $tdid] = $str;
        }
    }
}




<?php

use \grn\schedule\bean\AttendanceStatus;

require_once('schedule/view_util.csp');

/**
 * Show user name.  If "uid" parameter indicates a valid user,
 * this will echo the current user name of that user.
 *
 * If "uid" is not specified or invalid, it will echo "name"
 * parameter as the (deleted) user name.
 *
 * @name   grn_user_name
 * @description show user name from user id with decoration
 *
 * @param  string  id          member id
 * @param  string  name        member name
 */


function smarty_function_grn_schedule_members_name($params, &$smarty)
{
    static $include_grn_image = false;
    if ($include_grn_image === false) {
        require_once($smarty->_get_plugin_filepath('function', 'grn_image'));
        $include_grn_image = true;
    }

    $users_id = [];
    $groups_id = [];
    $facilities_id = [];

    $member_type = '';
    if (array_key_exists('member_type', $params)) {
        $member_type = $params['member_type'];
    }

    if (array_key_exists('members', $params)) {
        foreach (array_keys($params['members']) as $member_id) {
            $prefix = mb_substr($member_id, 0, 1);
            if ($member_type === 'facility') {
                $facilities_id[$member_id] = $member_id;
            } else {
                switch ($prefix) {
                    case 'g':
                        $group_id = mb_substr($member_id, 1);
                        $groups_id[$group_id] = $group_id;
                        break;
                    case 'f':
                        $facility_id = mb_substr($member_id, 1);
                        $facilities_id[$facility_id] = $facility_id;
                        break;
                    default:
                        $user_id = $member_id;
                        $users_id[$user_id] = $user_id;
                        break;
                }
            }
        }
    }

    if (array_key_exists('nolink', $params)) {
        $nolink = $params['nolink'];
    } else {
        $nolink = null;
    }

    if (array_key_exists('noimage', $params)) {
        $noimage = $params['noimage'];
    } else {
        $noimage = null;
    }

    if (array_key_exists('nobr', $params)) {
        $nobr = $params['nobr'];
    } else {
        $nobr = false;
    }

    $attention = false;
    if (array_key_exists('attention', $params)) {
        $attention = $params['attention'];
    }

    if (array_key_exists('referer_key', $params)) {
        $referer_key = $params['referer_key'];
    } else {
        $referer_key = null;
    }

    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $login = $uum->getLoginUser();

    $str = '';
    if (count($groups_id) > 0) {
        $groups_info = $uum->getGroupInfoList($groups_id);
        $str .= _grn_schedule_show_groups_name($groups_id, $groups_info,
            $nolink, $noimage, $nobr, $attention, $smarty);
    }

    $attendanceStatusInfoList = [];
    if (array_key_exists("attendanceStatusInfo", $params)) {
        $attendanceStatusInfoList = $params["attendanceStatusInfo"];
        if (isset($attendanceStatusInfoList["groupCount"])
            && $attendanceStatusInfoList["groupCount"] > 0
        ) {
            $str = '<span class="group-grn">' . $str . '</span>';
        }
    }

    if (count($users_id) > 0) {
        require_once("grn/controller.csp");
        $users_info = GRN_ControllerUtil::getUserInfoToShowUserName($users_id,
            $login);
        if (count($attendanceStatusInfoList) > 0) {
            foreach (array_keys($users_info) as $userId) {
                $userInfo = &$users_info[$userId];
                if (isset($attendanceStatusInfoList[AttendanceStatus::STATUS_ATTENDANT][$userId])) {
                    $userInfo["status"]
                        = AttendanceStatus::STATUS_ATTENDANT; // attendant
                } elseif (isset($attendanceStatusInfoList[AttendanceStatus::STATUS_ABSENT][$userId])) {
                    $userInfo["status"]
                        = AttendanceStatus::STATUS_ABSENT; // absent
                } else {
                    $userInfo["status"]
                        = AttendanceStatus::STATUS_UNCONFIRMED; // unconfirmed
                }
            }
        }
        $str .= _grn_schedule_show_users_name($users_id, $users_info,
            $login->getOID(), $nolink, $noimage, $nobr, $attention,
            $referer_key, $smarty);
    }

    if (count($facilities_id) > 0) {
        $approvalStatus = cb_at($params, 'approval_status', false);
        require_once('schedule/facility_system_logic.csp');
        $facility_logic = GRN_Facility_SystemLogic::getInstance();
        $farcilities_info = $facility_logic->getFacilitiesInfo($facilities_id,
            CB_DATABASE_NO_LOCK);
        $str .= _grn_schedule_show_facilities_name($facilities_id,
            $farcilities_info, $nolink, $noimage, $nobr, $attention, $smarty,
            $approvalStatus);
    }

    return $str;
}

/**
 * @access private
 */
function _grn_schedule_show_users_name(
    $users_id,
    $users_info,
    $login_id,
    $nolink,
    $noimage,
    $nobr,
    $attention,
    $referer_key,
    &$smarty
) {
    $str = '';
    $br = $nobr ? '' : '<br>';
    global $G_config_common;
    $app_path = $G_config_common->get('Global', 'app_path');

    $user_image = smarty_function_grn_image(['image' => 'user20.gif'], $smarty);

    foreach ($users_id as $user_id) {
        if ( ! array_key_exists($user_id, $users_info)) {
            continue;
        }

        $user_name = GRN_ControllerUtil::getUserNameText($login_id, $user_id,
            $users_info);

        if ($noimage) {
            $image = '';
        } else {
            $class_string = 'user20';
            if ($user_id == $login_id) {
                $image
                    = smarty_function_grn_image(['image' => 'loginuser20.gif'],
                    $smarty);
            } elseif ( ! is_null($users_info[$user_id]['col_valid'])) {
                $image
                    = smarty_function_grn_image(['image' => 'invaliduser20.gif'],
                    $smarty);
            } elseif (is_null($users_info[$user_id]['col_using_app'])) //T GTM-529
            {
                $image
                    = smarty_function_grn_image(['image' => 'invalid_app_user20.png'],
                    $smarty);
            } //T GTM-529
            else {
                $image = $user_image;
            }
        }

        $attention_mark = '';
        if (is_array($attention) && array_key_exists($user_id, $attention)
            && $attention[$user_id]
        ) {
            $msg = cb_msg('grn.schedule', 'conflict');
            $attention_mark .= '<span class="attention">' . '<img src="'
                               . htmlspecialchars($app_path)
                               . '/grn/image/cybozu/attention16.gif?'
                               . $build_date . '" border="0" title="' . $msg
                               . '" alt="' . $msg . '" align="absmiddle" >'
                               . '</span>';
        }

        if ($nolink) {
            //return '<span class="'.$class_string.'">' . htmlspecialchars($user_name) . '</span>';
            $str .= '<span>' . $image . htmlspecialchars($user_name)
                    . $attention_mark . '</span>' . "\r\n";
        } else {
            $user_info_string
                = GRN_Schedule_View_Util::getUserProfileURL($users_info[$user_id],
                $referer_key);
            if (defined('ON_FOREST')) {
                $target = ' target="_blank"';
            } else {
                $target = '';
            }
            if (isset($users_info[$user_id]["status"])) {
                $str .= '<span class="user-grn '
                        . $users_info[$user_id]["status"] . '">';
            } else {
                $str .= '<span class="user-grn">';
            }
            $str .= '<a href="' . $user_info_string . '"' . $target . '>'
                    . $image . htmlspecialchars($user_name) . $attention_mark
                    . '</a></span>' . $br . "\r\n";

            //return '<a class="'.$class_string.'" target="user_view" href="' . $user_info_string . '">' . htmlspecialchars($user_name) . '</a>';
        }

    }

    return $str;
}

/**
 * @access private
 */
function _grn_schedule_show_groups_name(
    $groups_id,
    $groups_info,
    $nolink,
    $noimage,
    $nobr,
    $attention,
    &$smarty
) {
    $str = '';
    $image = '';
    $br = $nobr ? '' : '<br>';
    if ( ! $noimage) {
        require_once($smarty->_get_plugin_filepath('function', 'grn_image'));
        $description = cb_msg('grn.grn', 'GRN_GRN-ORGANIZATION_PLAN');
        $image = smarty_function_grn_image([
            'image'      => 'cal_group20.png',
            'alt'        => $description,
            'aria_label' => $description
        ],
            $smarty);
    }

    foreach ($groups_id as $group_id) {
        if ( ! array_key_exists($group_id, $groups_info)) {
            continue;
        }

        $str .= '<span class="groupschedule-grn">';
        $str .= $image . htmlspecialchars($groups_info[$group_id]['col_name'])
                . '</span>' . $br . "\r\n";
    }

    return $str;
}

/**
 * @access private
 */
function _grn_schedule_show_facilities_name(
    $faciliites_id,
    $farcilites_info,
    $nolink,
    $noimage,
    $nobr,
    $attention,
    &$smarty,
    $approvalStatus = false
) {
    $str = '';
    $br = $nobr ? '' : '<br>';
    if ($noimage) {
        $image = '';
    } else {
        $image = $noimage ? ''
            : smarty_function_grn_image(['image' => 'facility20.gif'], $smarty);
    }

    foreach ($faciliites_id as $facility_id) {
        if ( ! array_key_exists($facility_id, $farcilites_info)) {
            continue;
        }

        $statusText = '';
        if (is_array($approvalStatus)
            && array_key_exists($facility_id, $approvalStatus)
        ) {
            $statusText = '<span class="textSub-grn text_color_sub_grn">'
                          . $approvalStatus[$facility_id]['textEnclosed']
                          . '</span>';
        }

        if ($nolink) {
            $str .= '<span class="facility-grn">' . $image
                    . htmlspecialchars($farcilites_info[$facility_id]['col_name'])
                    . $statusText . '</span>' . $br . "\r\n";
        } else {
            $facility_info_string = cb_pageurl('schedule/facility_info',
                ['faid' => $facility_id]);
            $str .= '<span class="facility-grn"><a href="javascript:popupWin(\''
                    . $facility_info_string
                    . '\',\'help\',500,480,0,0,0,1,0,1)">'
                    . $image
                    . htmlspecialchars($farcilites_info[$facility_id]['col_name'])
                    . '</a>' . $statusText . '</span>' . $br
                    . "\r\n";
        }
    }

    return $str;

}



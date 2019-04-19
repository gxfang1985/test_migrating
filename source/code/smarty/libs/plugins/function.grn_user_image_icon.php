<?php
/**
 * @param $params
 * @param $smarty \Smarty
 *
 * @return string
 */

use grn\grn\access\service\AppAccess;

function smarty_function_grn_user_image_icon($params, $smarty)
{
    //-- the function name
    $function_name = 'grn_user_icon';
    require_once('grn/controller.csp');

    /** @var array|null $userInfo */
    $userInfo = (array_key_exists('userInfo', $params))
        ? $params['userInfo'] : null;
    $photoUrl = (array_key_exists('photoUrl', $params))
        ? $params['photoUrl'] : null;
    $alt = (array_key_exists('alt', $params))
        ? htmlspecialchars($params['alt']) : '';
    $userId = (array_key_exists('userId', $params)) ? $params['userId']
        : false;
    $loginId = (array_key_exists('loginId', $params)) ? $params['loginId']
        : false;
    $size = (array_key_exists('size', $params)) ? $params['size']
        : GRN_ControllerUtil::ICON_SIZE_SMALL;
    $noLink = (array_key_exists('noLink', $params)) ? $params['noLink']
        : false;
    $addImageTitle = cb_at($params, 'addImageTitle', false);
    $is_popup = cb_at($params, 'is_popup', true);
    $referer_key = cb_at($params, 'referer_key');

    $invalid = (is_array($userInfo) && ! is_null($userInfo['col_valid']));
    //T GTM-529
    $using_app = true;
    if (array_key_exists('app_id', $params)) //Only for Portal, Notification.
    {
        $app_id = $params['app_id'];
        $app_ids_availability
            = AppAccess::getAvailabilityAppIdsInternalByUserId($userId);
        if (array_key_exists($app_id, $app_ids_availability)
            && ! $app_ids_availability[$app_id]
        ) {
            $using_app = false; //there is no using privilege
        }
    } elseif (is_array($userInfo)
              && array_key_exists('col_using_app', $userInfo)
              && is_null($userInfo['col_using_app'])
    ) {
        $using_app = false;
    }

    // for user_list of Addressbook
    $user_list = (array_key_exists('userList', $params)) ? $params['userList']
        : false;
    //T GTM-529
    $page_path = explode('/', strtolower(cb_get_pagename()));
    $system = ($page_path[0] == 'system'
               || (array_key_exists(1, $page_path)
                   && $page_path[1] == 'system')
               || (array_key_exists(1, $page_path)
                   && $page_path[1] == 'operation'));

    if ( ! is_null($photoUrl) && ! $invalid
         && ($using_app
             || $user_list)
    ) { //T GTM-529, user list(address) regardless of using privilege.
        $class_name = ($size == GRN_ControllerUtil::ICON_SIZE_LARGE) ? 'user_photo_large_grn' : 'user_photo_grn';
        $image = "<div class='" . $class_name . "' style='background-image: url(" . $photoUrl . ");' aria-label=\""
                 . $alt . "\"></div>";
    } else {
        if ($size == GRN_ControllerUtil::ICON_SIZE_LARGE) { //SIZE_50
            if ($userId == $loginId) {
                $image = "<div class='profileImageLoginuserLarge-grn'></div>";
            } elseif ($invalid) {
                $image = "<div class='profileImageInvaliduserLarge-grn'></div>";
            } elseif ( ! $using_app && is_array($userInfo)
                       && ! $user_list
            ) { //T GTM-529, there is no using privilege on app; check is_array($userInfo) for case of deleted user.
                $image
                    = "<div class='profileImageInvalidAppUserLarge-grn'></div>";//T GTM-529
            } else {
                $image = "<div class='profileImageUserLarge-grn'></div>";
            }
        } else {
            $title = "";
            if ($userId == $loginId) {
                if ($addImageTitle) {
                    $descName = cb_msg('grn.grn', 'GRN_GRN-LOGIN_USER');
                    $title = "aria-label='" . $descName . "' title='"
                             . $descName . "'";
                }
                $image = "<div class='profileImageLoginuser-grn' $title></div>";
            } elseif ($invalid) {
                if ($addImageTitle) {
                    $descName = cb_msg('grn.grn', 'GRN_GRN-INACTIVE_USER');
                    $title = "aria-label='" . $descName . "' title='"
                             . $descName . "'";
                }
                $image
                    = "<div class='profileImageInvaliduser-grn' $title></div>";
            } elseif ( ! $using_app && is_array($userInfo)
                       && ! $user_list
            ) { //T GTM-529, there is no using privilege on app; check is_array($userInfo) for case of deleted user.
                if ($addImageTitle) {
                    $descName = cb_msg('grn.grn',
                        'GRN_GRN-NOT_APPLICATION_USER');
                    $title = "aria-label='" . $descName . "' title='"
                             . $descName . "'";
                }
                $image
                    = "<div class='profileImageInvalidAppUser-grn' $title></div>";//T GTM-529
            } else {
                $image = "<div class='profileImageUser-grn'></div>";
            }
        }
    }
    $imageDiv
        = "<div class='profileImage-grn'><div class='profileImageFrame-grn'>{$image}</div></div>";
    if ($noLink || is_null($userInfo)) {
        return "{$imageDiv}";
    }

    if ($is_popup) {
        require_once("grn/controller.csp");
        $userProfileURL = GRN_ControllerUtil::getPopupUserProfileURL($userInfo,
            $system);
    } else {
        require_once('schedule/view_util.csp');
        //Use GRN_Schedule_View_Util alter GRN_ControllerUtil to make correct bread crumb.
        $userProfileURL = GRN_Schedule_View_Util::getUserProfileURL($userInfo,
            $referer_key);
    }

    $target = (cb_is_forest()) ? ' target="_blank"' : '';

    return "<a href=" . $userProfileURL . $target . ">" . $imageDiv . "</a>";
}

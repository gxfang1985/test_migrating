<?php
require_once("grn/controller.csp");

use grn\grn\access\service\AppAccess;

/**
 * @name   grn_user_name_for_mobile_notification
 * @description show user name from user id with decoration
 *
 * @param $params
 * @param $smarty
 *
 * @option      string  uid         user id
 * @option      string  name        user name
 * @option      array   users_info   cached data to show users' information
 *
 * @return string
 */

function smarty_function_grn_user_name_for_mobile_notification(
    $params,
    &$smarty
) {
    //-- the function name
    $function_name = 'grn_user_name';

    $uid = cb_at($params, 'uid');
    $user_name = cb_at($params, 'name');
    $app_id = cb_at($params, 'app_id');
    $truncated = cb_at($params, 'truncated');

    if ($app_id == 'bulletin') {
        require_once('bulletin/notification.csp');
        if ($uid
            == GRN_Bulletin_NotificationListener::MANUALLY_ENTER_SENDER_ID
        ) {
            if (strlen($truncated) > 0) {
                $user_name = mb_strimwidth($user_name, 0, $truncated, '...');
            }

            return '<span class="mobile_notification_user_grn">'
                   . htmlspecialchars($user_name) . '<span>';
        }
    }

    $is_me = false;
    $using_app = true;

    $invalid = cb_at($params, 'valid') ? true : false;

    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $login = $uum->getLoginUser();
    if ($uid) {
        if (array_key_exists('users_info', $params)
            && is_array($params['users_info'])
        ) {
            $users_info = $params['users_info'];
        } else {
            $users_info = [];
        }

        if (array_key_exists($uid, $users_info)) {
            $user_info = $users_info[$uid];
        } else {
            $user_info = GRN_ControllerUtil::getUserInfoToShowUserName([$uid],
                $login);
            $user_info = $user_info[$uid];
        }

        if (is_array($user_info)) {
            $user_name = GRN_ControllerUtil::getUserNameText($login->getOID(),
                $uid, [$uid => $user_info]);
        } else {
            $user_name = GRN_ControllerUtil::getDeletedUserNameText($user_name);
        }

        if ($login && is_array($user_info)) {
            $is_me = $login && ($login->getOID() === $user_info['_id']);
        } else {
            $is_me = false;
        }

        if (is_array($user_info) && ! is_null($user_info['col_valid'])) {
            $invalid = true;
        }

        if ( ! is_null($app_id)) //Only use Notification.
        {
            if ( ! is_null($user_info)
                 && array_key_exists('col_using_apps', $user_info)
            ) {
                $allow = $user_info['col_using_apps'][$app_id];
                if ( ! $allow) {
                    $using_app = false;
                }
            } else {
                $app_ids_availability
                    = AppAccess::getAvailabilityAppIdsInternalByUserId($uid);
                if (array_key_exists($app_id, $app_ids_availability)
                    && ! $app_ids_availability[$app_id]
                ) {
                    $using_app = false;
                }
            }
        } elseif (is_array($user_info)
                  && array_key_exists('col_using_app', $user_info)
                  && is_null($user_info['col_using_app'])
        ) {
            $using_app = false;
        }
    } else {
        $user_name = GRN_ControllerUtil::getDeletedUserNameText($user_name);

        if ($invalid) {
            if ($login) {
                $is_me = $login && ($login->getOID() === $uid);
            } else {
                $is_me = false;
            }
        }
    }

    $class_string = 'mobile_icon_user_grn';
    if ($is_me) {
        $class_string = 'mobile_icon_userLogin_grn';
    } elseif ($invalid) {
        $class_string = 'mobile_icon_userInvalid_grn';
    } elseif ( ! $using_app && ! is_null($user_info)) {
        $class_string = 'mobile_icon_userInvalidApp_grn';
    }

    if (strlen($truncated) > 0) {
        $user_name = mb_strimwidth($user_name, 0, $truncated, '...');
    }

    return '<span class="mobile_notification_icon_title_s_grn ' . $class_string
           . '"></span><span class="mobile_notification_user_grn">'
           . htmlspecialchars($user_name) . '<span>';
}


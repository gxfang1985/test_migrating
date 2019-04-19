<?php

use grn\grn\access\service\AppAccess;

/**
 * @param $params
 *
 * @return string
 */
function smarty_function_grn_mobile_user_image_icon($params)
{
    require_once('grn/controller.csp');

    /** @var array|null $userInfo */
    $user_info = (array_key_exists('userInfo', $params)) ? $params['userInfo']
        : null;
    $photo_url = (array_key_exists('photoUrl', $params)) ? $params['photoUrl']
        : null;
    $user_id = (array_key_exists('userId', $params)) ? $params['userId']
        : false;
    $login_id = (array_key_exists('loginId', $params)) ? $params['loginId']
        : false;

    $invalid = (is_array($user_info) && ! is_null($user_info['col_valid']));
    $using_app = true;

    if (array_key_exists('app_id', $params)) {
        $app_id = $params['app_id'];
        $app_ids_availability
            = AppAccess::getAvailabilityAppIdsInternalByUserId($user_id);
        if (array_key_exists($app_id, $app_ids_availability)
            && ! $app_ids_availability[$app_id]
        ) {
            $using_app = false;
        }
    } elseif (is_array($user_info)
              && array_key_exists('col_using_app', $user_info)
              && is_null($user_info['col_using_app'])
    ) {
        $using_app = false;
    }

    $user_list = (array_key_exists('userList', $params)) ? $params['userList']
        : false;
    $app_path = cb_get_app_path() . "/grn/image/cybozu/";
    if ( ! is_null($photo_url) && ! $invalid && ($using_app || $user_list)) {
        $image_url = $photo_url;
    } else {
        if ($user_id == $login_id) {
            $image_url = $app_path . "image-mobile/userLoginPlofile.png";
        } elseif ($invalid) {
            $image_url = $app_path . "image-mobile/userInvalidPlofile.png";
        } elseif ( ! $using_app && is_array($user_info) && ! $user_list) {
            $image_url = $app_path . "image-mobile/userInvalidAppPlofile.png";
        } else {
            $image_url = $app_path . "image-mobile/userPlofile.png";
        }
    }

    return "<img src='" . $image_url
           . "' height='40' width='40' class='mobile-image-member-grn'/>";
}

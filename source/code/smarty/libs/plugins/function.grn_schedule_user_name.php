<?php
require_once('schedule/view_util.csp');

/**
 * Show user name.  If "uid" parameter indicates a valid user,
 * this will echo the current user name of that user.
 *
 * If "uid" is not specified or invalid, it will echo "name"
 * parameter as the (deleted) user name.
 *
 * @name   grn_schedule_user_user_name
 * @description show user name from user id with decoration
 *
 * @param  string  uid         user id
 * @param  string  name        user name
 * @param  string  image       image name
 * @param  boolean nolink
 * @param  boolean noimage
 */

function smarty_function_grn_schedule_user_name($params, &$smarty)
{
    //-- the function name
    $function_name = 'grn_schedule_user_name';

    if (array_key_exists('uid', $params)) {
        $uid = $params['uid'];
    } else {
        $uid = null;
    }

    if (array_key_exists('nolink', $params)) {
        $nolink_param = $params['nolink'];
    } else {
        $nolink_param = null;
    }

    if (array_key_exists('noimage', $params)) {
        $noimage = $params['noimage'];
    } else {
        $noimage = null;
    }

    if (array_key_exists('image', $params)) {
        $image_name = $params['image'];
    } else {
        $image_name = null;
    }
    if (array_key_exists('current_name', $params) && $params['current_name']) {
        $user_name = $params['current_name'];
    } else {
        $user_name = null;
    }

    if (array_key_exists('users_info', $params)
        && ! is_null($params['users_info'])
    ) {
        $users_info = $params['users_info'];
    } else {
        $users_info = [];
    }
    if (array_key_exists('referer_key', $params)) {
        $referer_key = $params['referer_key'];
    } else {
        $referer_key = null;
    }
    if (array_key_exists('onclick', $params)) {
        $onclick = 'onclick="' . htmlspecialchars($params['onclick']) . '"';
    } else {
        $onclick = '';
    }

    $is_popup = cb_at($params, 'is_popup', false);
    $nolink = true;
    $is_me = false;
    $using_app = true;

    if ($uid) {
        global $G_container_base;
        $uum = $G_container_base->getInstance('uum');
        $login = $uum->getLoginUser();

        if ( ! $nolink_param) {
            $nolink = false;
        }
        if ($login && ($uid == $login->getOID())) {
            $is_me = true;
        }

        require_once("grn/controller.csp");
        if ( ! array_key_exists($uid, $users_info)) {
            $users_info = GRN_ControllerUtil::getUserInfoToShowUserName([$uid],
                $login);
        }

        $user_name = GRN_ControllerUtil::getUserNameText($login->getOID(), $uid,
            $users_info);
        if (array_key_exists($uid, $users_info)
            && array_key_exists("col_valid", $users_info[$uid])
            && is_null($users_info[$uid]["col_valid"])
        ) // The user is valid when his value of col_valid column is null.
        {
            $valid = true;
        } else {
            $valid = false;
        }
        if (array_key_exists($uid, $users_info)
            && array_key_exists('col_using_app', $users_info[$uid])
            && is_null($users_info[$uid]['col_using_app'])
        )//T GTM-529
        {
            $using_app = false;
        }
    }
    if (is_null($user_name) || $user_name == "") {
        if (array_key_exists('name', $params) && $params['name']) {
            $user_name = $params['name'];
        } else {
            $user_name = '';
        }
        $user_name = GRN_ControllerUtil::getDeletedUserNameText($user_name);
    }

    if (is_null($valid)) {
        $valid = true;
    }

    $class_string = 'user20';
    if ($noimage) {
        $class_string = 'nouser'; //This is dummy class name.
    } elseif ($is_me) {
        $class_string = 'loginuser20';
    } elseif ($valid !== true) {
        $class_string = 'invaliduser20';
    } elseif ( ! $using_app) {  //T GTM-529
        $class_string = 'invalid_app_user20';
    }    //T GTM-529

    if ($image_name) {
        $class_string = $image_name;
    }

    static $include_grn_image = false;
    if ($include_grn_image === false) {
        require_once($smarty->_get_plugin_filepath('function', 'grn_image'));
        $include_grn_image = true;
    }

    if ($valid && ! $using_app) //T GTM-529
    {
        $image = $noimage
            ? ''
            : smarty_function_grn_image(['image' => $class_string . '.png'],
                $smarty);
    } else {
        $image = $noimage
            ? ''
            : smarty_function_grn_image(['image' => $class_string . '.gif'],
                $smarty);
    }


    if (array_key_exists('truncated', $params)) {
        if (strlen($params['truncated']) > 0) {
            $user_name = mb_strimwidth($user_name, 0, $params['truncated'],
                '...');
        }
    }

    //-- create return_string
    if ($nolink) {
        return '<span class="user-grn inline_block_grn">' . $image
               . htmlspecialchars($user_name) . '</span>';
    } else {
        $user_profile_url
            = GRN_Schedule_View_Util::getUserProfileURL($users_info[$uid],
            $referer_key);

        $target = '';
        if (cb_is_forest()) {
            $target = ' target="_blank"';
        } elseif ($is_popup)  // Only popup in On-premise.
        {
            return "<a href=javascript:popupWin('{$user_profile_url}','user_view',500,480,0,0,0,1,0,1)>"
                   . $image . htmlspecialchars($user_name) . '</a>';
        }

        return '<a href="' . $user_profile_url . '" ' . $onclick . $target
               . ' >' . $image . htmlspecialchars($user_name) . '</a>';
    }
}


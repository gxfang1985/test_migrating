<?php
require_once("grn/controller.csp");

use grn\grn\access\service\AppAccess;

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
 * @param  string  uid         user id
 * @param  string  name        user name
 * @param  string  image       image name
 * @param  boolean nolink
 * @param  boolean noimage
 * @param  boolean deleted_off
 * @param  boolean is_sandbox_page
 * @param  string  page         page url(optional)
 * @param  array   users_info    cached data to show users' information
 */

function smarty_function_grn_user_name($params, &$smarty)
{
    //-- the function name
    $function_name = 'grn_user_name';

    if (array_key_exists('uid', $params)) {
        $uid = $params['uid'];
    } else {
        $uid = null;
    }

    $page = null;
    if (array_key_exists('page', $params)) {
        $page = $params['page'];
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

    if (array_key_exists('image', $params)) {
        $image_name = $params['image'];
    } else {
        $image_name = null;
    }

    if (array_key_exists('users_info', $params)
        && is_array($params['users_info'])
    ) {
        $users_info = $params['users_info'];
    } else {
        $users_info = [];
    }

    if (array_key_exists('only_text', $params)) {
        $only_text = $params['only_text'];
    } else {
        $only_text = null;
    }

    $invalid = false;
    $is_me = false;
    $using_app = true; // T GTM-529
    $user_list = false; // T GTM-529
    $deleted_off = cb_at($params, 'deleted_off', false); // STM-198

    if (array_key_exists('valid', $params)) {
        $invalid = ! is_null($params['valid']);
    } else {
        $invalid = false;
    }

    $page_path = explode('/', strtolower(cb_get_pagename()));
    if ($page_path[0] == 'system'
        || (array_key_exists(1, $page_path)
            && $page_path[1] == 'system')
        || (array_key_exists(1, $page_path) && $page_path[1] == 'operation')
    ) {
        $system = true;
    } else {
        $system = false;
    }

    // $uid が指定されている場合は、ニックネームでの置き換えや優先する組織の表示を行う
    if ($uid) {
        global $G_container_base;
        $uum = $G_container_base->getInstance('uum');
        $login = $uum->getLoginUser();

        $user_info = [];
        if (array_key_exists($uid, $users_info)) {
            $user_info = $users_info[$uid];
        } else {
            if (isset($params['is_sandbox_page'])
                && $params['is_sandbox_page']
            ) {
                $user_info
                    = \grn\system\sandbox\GRN_ControllerUtilSandbox::getUserInfoToShowUserName([$uid],
                    $login);
            } else {
                $user_info
                    = GRN_ControllerUtil::getUserInfoToShowUserName([$uid],
                    $login);
            }
            $user_info = $user_info[$uid];
        }
        if (is_array($user_info)) {
            $mobi_display = false;
            if (array_key_exists('mobi_display_user_group', $params)) {
                $mobi_display = (bool)$params['mobi_display_user_group'];
            }
            // Use NickName if possible
            if (isset($params['is_sandbox_page'])
                && $params['is_sandbox_page']
            ) {
                $user_name
                    = \grn\system\sandbox\GRN_ControllerUtilSandbox::getUserNameText($login->getOID(),
                    $uid, [$uid => $user_info], $mobi_display);
            } else {
                $user_name
                    = GRN_ControllerUtil::getUserNameText($login->getOID(),
                    $uid, [$uid => $user_info],
                    $mobi_display);//false: turn off show group priority
            }
        } else {
            $user_name = '';
            if (isset($params['name'])) {
                $user_name = $params['name'];
            }

            if ('' !== trim($user_name)) {
                $user_name
                    = GRN_ControllerUtil::getDeletedUserNameText($user_name);
            } elseif ( ! $deleted_off) {
                $user_name
                    = GRN_ControllerUtil::getDeletedUserNameText($user_name);
            }
            $nolink = true;
        }

        if ($login && is_array($user_info)) {
            $is_me = $login && ($login->getOID() === $user_info['_id']);
        } else {
            $is_me = false;
        }
        if (is_array($user_info) && ! is_null($user_info['col_valid'])) {
            $invalid = true;
        }

        //GTM-529
        if (array_key_exists('app_id', $params)
            && ! is_null($params['app_id'])
        ) //Only use Notification.
        {
            $app_id = $params['app_id'];
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
                    $using_app = false; //there is no using privilege
                }
            }
        } elseif (is_array($user_info)
                  && array_key_exists('col_using_app', $user_info)
                  && is_null($user_info['col_using_app'])
        ) {
            $using_app = false;
        }
        // for user_list of Addressbook
        $user_list = (array_key_exists('userList', $params))
            ? $params['userList'] : false;

        //end GTM-529
    } else {
        $nolink = true;
        if (array_key_exists('name', $params)) {
            $user_name = $params['name'];
        } else {
            $user_name = '';
        }

        if ('' !== trim($user_name)) {
            $user_name = GRN_ControllerUtil::getDeletedUserNameText($user_name);
        } elseif ( ! $deleted_off) {
            $user_name = GRN_ControllerUtil::getDeletedUserNameText($user_name);
        }

        if ($invalid) {
            if ($login) {
                $is_me = $login && ($login->getOID() === $uid);
            } else {
                $is_me = false;
            }
        }
    }

    $class_string = 'user20';
    if ($noimage) {
        $class_string = 'nouser';
    } elseif ($is_me) {
        $class_string = 'loginuser20';
    } elseif ($invalid) {
        $class_string = 'invaliduser20';
    } elseif ( ! $using_app && ! $user_list
               && ! is_null($user_info)
    ) {  //T GTM-529
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

    //&& array_key_exists('col_foreign_key',$user_info)
    if ( ! $invalid && ! $using_app && ! $user_list && ! $is_me
         && ! is_null($user_info)
    )//T GTM-529
    {
        $image = $noimage
            ? ''
            : smarty_function_grn_image(['image' => $class_string . '.png'],
                $smarty);
    } //T GTM-529
    else {
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
    if ($only_text) {
        return htmlspecialchars($user_name);
    } elseif ($nolink) {
        //return '<span class="'.$class_string.'">' . htmlspecialchars($user_name) . '</span>';
        return '<span>' . $image . htmlspecialchars($user_name) . '</span>';
    } else {
        //link to page
        if ($page) {
            unset($params['page'], $params['truncated']);
            unset($params['nolink'], $params['noimage'], $params['image']);
            unset($params['users_info'], $params['valid'], $params['current_name'], $params['name']);
            $page_url = cb_pageurl($page, $params);

            return '<a href="' . $page_url . '">' . $image
                   . htmlspecialchars($user_name) . '</a>';
        } else //user view page
        {
            $user_info_string
                = GRN_ControllerUtil::getPopupUserProfileURL($user_info,
                $system);
            if (defined('ON_FOREST')) {
                $target = ' target="_blank"';
            } else {
                $target = '';
            }

            return '<a href="' . $user_info_string . '"' . $target . '>'
                   . $image . htmlspecialchars($user_name) . '</a>';
        }
    }

}


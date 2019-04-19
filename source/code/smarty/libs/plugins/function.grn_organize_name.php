<?php

use grn\system\sandbox\GRN_Uum_Sandbox;

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
 * @param  string  gid         organize id
 * @param  string  name        organize name
 */

function smarty_function_grn_organize_name($params, &$smarty)
{
    //-- the function name
    $function_name = 'grn_organize_name';

    if (array_key_exists('gid', $params)) {
        $gid = $params['gid'];
    } else {
        $gid = null;
    }

    if (array_key_exists('noimage', $params)) {
        $noimage = $params['noimage'];
    } else {
        $noimage = null;
    }

    if (array_key_exists('name', $params) && $params['name']) {
        $group_name = $params['name'];
    } elseif (array_key_exists('current_name', $params)
              && $params['current_name']
    ) {
        $group_name = $params['current_name'];
    } else {
        $group_name = null;
    }

    if (array_key_exists('groups_info', $params)
        && ! is_null($params['groups_info'])
    ) {
        $groups_info = $params['groups_info'];
    } else {
        $groups_info = [];
    }

    if (array_key_exists('is_sandbox_page', $params)
        && $params['is_sandbox_page']
    ) {
        $uum = GRN_Uum_Sandbox::getInstance();
    } else {
        $uum = cb_lwc_uum();
    }

    $cal_group = cb_at($params, 'cal_group', false);


    if ($gid) {

        if (is_null($group_name) && array_key_exists($gid, $groups_info)) {
            $group_name = $groups_info[$gid]['col_name'];
        } elseif (is_null($group_name)) {
            $group_info = $uum->getGroupInfo($gid);
            $group_name = $group_info['col_name'];
        }
    }

    if (is_null($group_name)) {
        $group_name = '';
    }

    static $include_grn_image = false;
    if ($include_grn_image === false) {
        require_once($smarty->_get_plugin_filepath('function', 'grn_image'));
        $include_grn_image = true;
    }

    $icon_image = 'organize20.gif';
    if ($cal_group) {
        $icon_image = 'cal_group20.png';
    }
    $image = $noimage ? ''
        : smarty_function_grn_image(['image' => $icon_image], $smarty);

    if (array_key_exists('truncated', $params)) {
        if (strlen($params['truncated']) > 0) {
            $group_name = mb_strimwidth($group_name, 0, $params['truncated'],
                '...');
        }
    }

    return $image . htmlspecialchars($group_name);
}


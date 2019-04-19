<?php

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

function smarty_function_grn_schedule_member_name($params, &$smarty)
{
    $member_id = null;
    if (array_key_exists('id', $params)) {
        $member_id = $params['id'];
        unset($params['id']);
    }

    $prefix = mb_substr($member_id, 0, 1);

    // 頭に'g'がついているのは組織
    switch ($prefix) {
        case 'g':
            // 組織表示を取り込み
            static $include_grn_organize_name = false;
            if ($include_grn_organize_name === false) {
                require_once $smarty->_get_plugin_filepath('function',
                    'grn_organize_name');
                $include_grn_organize_name = true;
            }
            $params['gid'] = mb_substr($member_id, 1);
            $params['cal_group'] = true;

            return smarty_function_grn_organize_name($params, $smarty);
            break;
        case 'f':
            static $include_grn_facility_name = false;
            if ($include_grn_facility_name === false) {
                require_once $smarty->_get_plugin_filepath('function',
                    'grn_facility_name');
                $include_grn_facility_name = true;
            }

            $params['faid'] = mb_substr($member_id, 1);

            return smarty_function_grn_facility_name($params, $smarty);
            break;
        default:
            static $include_grn_user_name = false;
            if ($include_grn_user_name === false) {
                require_once $smarty->_get_plugin_filepath('function',
                    'grn_schedule_user_name');
                $include_grn_user_name = true;
            }
            $params['uid'] = $member_id;

            return smarty_function_grn_schedule_user_name($params, $smarty);
    }
}


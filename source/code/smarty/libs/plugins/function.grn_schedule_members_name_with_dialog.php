<?php
require_once 'fw/ui.csp';
require_once 'grn/ui.csp';

/**
 * @param array $params array members
 * @param       $smarty
 *
 * @return string
 */
function smarty_function_grn_schedule_members_name_with_dialog(
    array $params,
    &$smarty
) {

    $params['app_id'] = 'schedule';
    $params['user_profile_url_array']
        = _smarty_function_grn_schedule_members_name_with_dialog_get_user_profile_url_array($smarty);

    require_once $smarty->_get_plugin_filepath('function',
        'grn_members_name_with_dialog');

    return smarty_function_grn_members_name_with_dialog($params, $smarty);
}

function _smarty_function_grn_schedule_members_name_with_dialog_get_user_profile_url_array(
    $smarty
) {

    $referer_key = $smarty->get_template_vars('referer_key');

    $login_user = cb_get_login_user();
    $schedule_event = $smarty->get_template_vars('schedule_event');

    $target_ids = [];
    $users = $schedule_event["users"];
    foreach ($users as $key => $value) {
        if (is_numeric($key)) {
            $target_ids[$key] = $key;
        }
    }
    $private_users = $schedule_event["private_users"];
    foreach ($private_users as $key => $value) {
        if (is_numeric($key)) {
            $target_ids[$key] = $key;
        }
    }
    require_once("grn/controller.csp");
    $users_info = GRN_ControllerUtil::getUserInfoToShowUserName($target_ids,
        $login_user);

    $result = [];
    foreach ($users_info as $uid => $user_info) {
        $result[$uid] = GRN_Schedule_View_Util::getUserProfileURL($user_info,
            $referer_key);
    }

    return $result;
}

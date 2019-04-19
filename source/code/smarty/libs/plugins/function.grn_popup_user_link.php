<?php
require_once('grn/controller.csp');

/**
 * @param string  uid  User ID
 */
function smarty_function_grn_popup_user_link($params)
{
    $userId = isset($params['uid']) ? $params['uid'] : null;

    return GRN_ControllerUtil::getPopupUserProfileURLById($userId);
}

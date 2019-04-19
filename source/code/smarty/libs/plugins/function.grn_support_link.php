<?php
require_once('grn/ui.csp');

/**
 * @name    grn_support_link         support link
 */
function smarty_function_grn_support_link($params, &$smarty)
{
    $function_name = "grn_support_link";

    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $login =& $uum->getLoginUser();
    $roles = [];
    if ($login) {
        $roles = $uum->getUserRolesInfo($login->getOID());
    }
    if (array_key_exists(GRN_UUM_ADMINISTRATION_ROLE, $roles)) {
        require_once('grn/license.csp');
        $lm = GRN_LicenseManager::getInstance();
        $license_info = $lm->getLicense(GRN_LICENSE_BASESYSTEM);
        $status = $lm->getStatus($license_info);
        if ($status !== GRN_LICENSE_SUCCESS) {
            return '';
        }

        $remind_days = $lm->getRemindDays($license_info['service_limit'],
            GRN_LICENSE_SERVICE_EXPIRED_OFFSET);
        if ($remind_days < 0) {
            return '';
        }

        require_once($smarty->_get_plugin_filepath('function', 'grn_link'));

        return smarty_function_grn_link($params, $smarty);
    }

    return '';
}



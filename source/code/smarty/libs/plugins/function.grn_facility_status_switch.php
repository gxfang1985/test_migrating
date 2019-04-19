<?php

function smarty_function_grn_facility_status_switch($params, $smarty)
{
    require_once("fw/i18n/system_config.csp");
    $switch = isset($params["locale"]) ? $params["locale"] : null;

    switch ($switch) {
        case "system":
            $user_style = "display:none;";
            $system_style = "";
            break;
        case "user":
        default:
            $user_style = "";
            $system_style = "display:none;";
            break;
    }
    $facilityName = _smarty_function_grn_facility_status_for_print($params);
    $user_content = cb_at($facilityName, "user", '');
    $system_content = cb_at($facilityName, "system", '');

    return "<span class=\"user\" style=\"$user_style\">$user_content</span><span class=\"system\" style=\"$system_style\">$system_content</span>";

}

function _smarty_function_grn_facility_status_for_print($params)
{
    $facilityStatus = [];
    $isApproved = cb_at($params, 'isApproved', null);

    $printLanguage = CB_I18N_SystemConfig::getPrintLanguage();
    require_once('fw/i18n.csp');
    $i18n = CB_I18N::getInstance();
    $userLanguage = $i18n->getCurrentLanguage();

    if ( ! is_null($isApproved)) {
        $facilityApprovalViewUtil = new grn\schedule\FacilityApprovalViewUtil();
        $printLanguageStatus
            = $facilityApprovalViewUtil->toCurrentStatusString($isApproved,
            $printLanguage);
        $facilityStatus["system"] = cb_msg('grn.schedule',
            'facilityApprovalStatus', ['status' => $printLanguageStatus]);

        $userLanguageStatus
            = $facilityApprovalViewUtil->toCurrentStatusString($isApproved,
            $userLanguage);
        $facilityStatus["user"] = cb_msg('grn.schedule',
            'facilityApprovalStatus', ['status' => $userLanguageStatus]);
    }

    return $facilityStatus;
}

<?php

function smarty_validate_criteria_grn_isValidPassword(
    $value,
    $empty,
    &$params,
    &$formvars
) {
    if ( ! isset($params['field2'])) {
        trigger_error("SmartyValidate: [grn_isValidPassword] parameter 'field2' is missing.");

        return false;
    }

    $retype = $formvars[$params['field2']];

    require_once('grn/uum_util.csp');
    $uum_util = GRN_UumUtil::getInstance();
    if ( ! $uum_util->isValidPassword($value)
         && ! $uum_util->isValidPassword($retype)
    ) {
        return true;
    }

    return $value == $retype;
}


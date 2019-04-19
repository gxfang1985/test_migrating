<?php

use grn\grn\Validate;

/**
 * @param string  $value
 * @param boolean $empty
 * @param array   $params
 * @param array   $formvars
 */
function smarty_validate_criteria_grn_bulletin_senderNotEmpty(
    $value,
    $empty,
    &$params,
    &$formvars
) {
    require_once('bulletin/resources.csp');
    if (cb_at($formvars, 'sender_set', GRN_BULLETIN_DEFAULT_VALUE_FROM_USER)
        === GRN_BULLETIN_DEFAULT_VALUE_FROM_MANUALLY_ENTER
    ) {
        require_once('fw/string_util.csp');
        if (Validate::isNotNull(cb_trim($value))) {
            return true;
        } else {
            return false;
        }
    } else {
        return true;
    }
}

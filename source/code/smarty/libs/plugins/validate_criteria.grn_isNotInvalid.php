<?php

/**
 * test if values are not match
 *
 * @param string  $value the value being tested
 * @param boolean $empty if field can be empty
 * @param array params validate parameter values
 * @param array formvars form var values
 */
function smarty_validate_criteria_grn_isNotInvalid(
    $value,
    $empty,
    &$params,
    &$formvars
) {
    if ( ! array_key_exists('invalid', $params)) {
        return true;
    }

    $invalid_value = $params['invalid'];

    return ($value != $invalid_value);
}


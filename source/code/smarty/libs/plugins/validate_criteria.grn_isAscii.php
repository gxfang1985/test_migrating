<?php

/**
 * test if a value is composed only of ASCII
 *
 * @param string  $value the value being tested
 * @param boolean $empty if field can be empty
 * @param array params validate parameter values
 * @param array formvars form var values
 */
function smarty_validate_criteria_grn_isAscii(
    $value,
    $empty,
    &$params,
    &$formvars
) {
    return preg_match('/^[[:ascii:]]*$/', $value);
}

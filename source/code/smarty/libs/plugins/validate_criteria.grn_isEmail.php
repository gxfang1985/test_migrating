<?php
/**
 * test if a value is a valid e-mail address
 *
 * @param string  $value the value being tested
 * @param boolean $empty if field can be empty
 * @param array params validate parameter values
 * @param array formvars form var values
 */

function smarty_validate_criteria_grn_isEmail(
    $value,
    $empty,
    &$params,
    &$formvars
) {

    if (strlen($value) == 0) {
        return $empty;
    }

    $_regex = "^[-a-zA-Z0-9.!#$'%&*+\/=?^_`{|}~]{1,64}@[-.0-9A-Za-z]+$";

    // in case value is several addresses separated by newlines
    $_addresses = preg_split('![\n\r]+!', $value);

    foreach ($_addresses as $_address) {
        if ( ! preg_match("/$_regex/", $_address)) {
            return false;
        }
    }

    return true;
}

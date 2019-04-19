<?php

/**
 * transform fuction, trim a value
 *
 * @param string $value    the value being trimmed
 * @param array  $params   the parameters passed to the transform function
 * @param array  $formvars the form variables
 */

function smarty_validate_transform_cb_trim($value, $params, &$formvars)
{
    require_once('fw/string_util.csp');

    return cb_trim($value);
}



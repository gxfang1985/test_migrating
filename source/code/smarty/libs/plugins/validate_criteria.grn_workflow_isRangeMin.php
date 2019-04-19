<?php

/**
 * test if a value is a valid Minimum range
 *
 * @param string  $value the value being tested
 * @param boolean $empty if field can be empty
 * @param array params validate parameter values
 * @param array formvars form var values
 */
function smarty_validate_criteria_grn_workflow_isRangeMin(
    $value,
    $empty,
    &$params,
    &$formvars
) {
    if ( ! isset($params['min'])) {
        trigger_error("SmartyValidate: [grn_workflow_isRangeMin] parameter 'min' is missing.");

        return false;
    }

    if ( ! isset($params['scale'])) {
        $params['scale'] = 0;
    }

    if (strlen($value) == 0) {
        return $empty;
    }

    require_once('fw/string_util.csp');

    return (bccomp(cb_trim($value), $params['min'], $params['scale']) >= 0);
}



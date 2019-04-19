<?php

function smarty_validate_criteria_grn_schedule_timeNotEmpty(
    $value,
    $empty,
    &$params,
    &$formvars
) {
    if ( ! isset($params['field'])) {
        trigger_error("SmartyValidate: [grn_schedule_timeNotEmpty] parameter 'field' is missing.");

        return false;
    }

    $hour_field = $params['field'] . 'hour';
    $minute_field = $params['field'] . 'minute';

    if (array_key_exists($hour_field, $formvars) === false) {
        trigger_error("SmartyValidate: [grn_schedule_timeNotEmpty] form field "
                      . $hour_field . " is missing.");

        return false;
    }

    if (array_key_exists($minute_field, $formvars) === false) {
        trigger_error("SmartyValidate: [grn_schedule_timeNotEmpty] form field "
                      . $minute_field . " is missing.");

        return false;
    }

    $hour = intval($formvars[$hour_field]);
    $minute = intval($formvars[$minute_field]);

    if ($hour <= 0 && $minute <= 0) {
        return false;
    }

    return true;
}


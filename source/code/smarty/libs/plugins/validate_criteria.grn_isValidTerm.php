<?php

function smarty_validate_criteria_grn_isValidTerm(
    $value,
    $empty,
    &$params,
    &$formvars
) {
    if (array_key_exists('enable', $params)) {
        $var_name = $params['enable'];

        if (array_key_exists($var_name, $formvars) && ! $formvars[$var_name]) {
            return true;
        }
    }

    require_once('fw/date.csp');

    $_date1 = null;

    if ( ! isset($params['field'])) {
        trigger_error("SmartyValidate: [grn_isValidTerm] parameter 'field' is missing.");

        return false;
    }

    if ( ! array_key_exists($params['field'] . 'year', $formvars)) {
        trigger_error("SmartyValidate: [grn_isValidTerm] form field '"
                      . $params['field'] . "year' is empty.");

        return false;
    }
    if ( ! array_key_exists($params['field'] . 'month', $formvars)) {
        trigger_error("SmartyValidate: [grn_isValidTerm] form field '"
                      . $params['field'] . "month' is empty.");

        return false;
    }
    if ( ! array_key_exists($params['field'] . 'day', $formvars)) {
        trigger_error("SmartyValidate: [grn_isValidTerm] form field '"
                      . $params['field'] . "day' is empty.");

        return false;
    }

    $_y = $formvars[$params['field'] . 'year'];
    $_m = $formvars[$params['field'] . 'month'];
    $_d = $formvars[$params['field'] . 'day'];

    $_date1 = new CB_Date;
    $_date1->year = $_y;
    $_date1->month = $_m;
    $_date1->day = $_d;

    if ( ! cb_date_validate_date($_date1)) {
        if ($_y || $_m || $_d) {
            return false;
        }

        $_date1 = null;
    }


    $_date2 = null;
    if (isset($params['field2'])) {
        if ( ! array_key_exists($params['field2'] . 'year', $formvars)) {
            trigger_error("SmartyValidate: [grn_isValidTerm] form field '"
                          . $params['field2'] . "year' is empty.");

            return false;
        }
        if ( ! array_key_exists($params['field2'] . 'month', $formvars)) {
            trigger_error("SmartyValidate: [grn_isValidTerm] form field '"
                          . $params['field2'] . "month' is empty.");

            return false;
        }
        if ( ! array_key_exists($params['field2'] . 'day', $formvars)) {
            trigger_error("SmartyValidate: [grn_isValidTerm] form field '"
                          . $params['field2'] . "day' is empty.");

            return false;
        }

        $_y = $formvars[$params['field2'] . 'year'];
        $_m = $formvars[$params['field2'] . 'month'];
        $_d = $formvars[$params['field2'] . 'day'];

        $_date2 = new CB_Date;
        $_date2->year = $_y;
        $_date2->month = $_m;
        $_date2->day = $_d;

        if ( ! cb_date_validate_date($_date2)) {
            if ($_y || $_m || $_d) {
                return false;
            }

            $_date2 = null;
        }
    }

    if ( ! is_null($_date1)) {
        $_ts = new CB_TimeStampEx();
        $_dt = $_ts->getDate();

        if ($_dt->compare($_date1) > 0) {
            return false;
        }

        if ( ! is_null($_date2)) {
            return cb_date_compare($_date1, $_date2) <= 0;
        }
    } elseif ( ! is_null($_date2)) {
        $_ts = new CB_TimeStampEx();
        $_dt = $_ts->getDate();

        if ($_dt->compare($_date2) > 0) {
            return false;
        }
    }

    return true;
}



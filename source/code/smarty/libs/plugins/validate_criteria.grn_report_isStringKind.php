<?php

/**
 * test if a value is a valid Minimum range
 *
 * @param string  $value the value being tested
 * @param boolean $empty if field can be empty
 * @param array params validate parameter values
 * @param array formvars form var values
 */
function smarty_validate_criteria_grn_report_isStringKind(
    $value,
    $empty,
    &$params,
    &$formvars
) {
    if ( ! isset($params['kind'])) {
        trigger_error("SmartyValidate: [grn_report_isStringKind] parameter 'kind' is missing.");

        return false;
    }

    if (strlen($value) == 0) {
        return $empty;
    }

    $result = true;
    switch ($params['kind']) {
        case 'zenkaku':
            $new_value = mb_convert_kana($value, 'ASKV');
            $result = ($new_value === $value) ? true : false;
            break;
        case 'hankaku':
            if (preg_match_all('/[\x{4E00}-\x{9FBF}]+/u', $value, $matches)) {
                // $value has a kanji character.
                $result = false;
                break;
            }
            $new_value = mb_convert_kana($value, 'haskV');
            $result = ($new_value === $value) ? true : false;
            break;
        default:
            break;
    }

    return $result;
}



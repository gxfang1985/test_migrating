<?php

/**
 * @name   grn_papi_text_format
 * display text value after strip invalid XML characters.
 *
 * @param string    value      attribute value
 *
 *  記述例
 *  <pre>{grn_papi_text_format value="sample"}
 */
function smarty_function_grn_papi_text_format($params, &$smarty)
{
    $function_name = 'grn_papi_text_format';

    // necessary parameter and value
    if (array_key_exists('value', $params)) {
        $string = '';
        if (strlen($params['value']) > 0) {
            $value = $params['value'];

            //remove invalid XML characters
            require_once('fw/string_util.csp');
            $value = cb_remove_invalid_xml_chars($value);

            $string .= _normalize_whitespace(htmlspecialchars($value));
        }
    }

    return $string;
}

function _normalize_whitespace($value)
{
    //Normalization white space and line feed.
    $value = str_replace("\r", "&#xD;", $value);
    $value = str_replace("\n", '&#xA;', $value);
    $value = str_replace(' ', '&#x20;', $value);
    $value = str_replace("\t", '&#x9;', $value);

    return $value;
}



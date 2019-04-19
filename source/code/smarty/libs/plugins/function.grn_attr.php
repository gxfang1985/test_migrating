<?php

/**
 * @name   grn_attr
 * create HTML/XML attribute
 *
 * @param string    name       attribute name
 * @param string    value      attribute value
 * @param boolean   require    always write attribute although value is empty
 *
 *  記述例
 *  <pre>{grn_attr name="foo" value="sample"}
 */
function smarty_function_grn_attr($params, &$smarty)
{
    $function_name = 'grn_attr';

    // necessary parameter and value
    if ( ! array_key_exists('name', $params)) {
        return htmlspecialchars($function_name) . ': missing "name" parameter';
    }

    if ( ! array_key_exists('value', $params)) {
        return htmlspecialchars($function_name) . ': missing "value" parameter';
    }

    $require = array_key_exists('require', $params);

    $attribute = '';

    if (strlen($params['value']) > 0 || $require) {
        $value = $params['value'];

        //remove invalid XML characters
        require_once('fw/string_util.csp');
        $value = cb_remove_invalid_xml_chars($value);

        $attribute = htmlspecialchars($params['name']) . '="'
                     . _normalize_characters(htmlspecialchars($value)) . '"';
    }

    return $attribute;
}

function _normalize_characters($value)
{
    //Normalization white space and line feed.
    $value = str_replace("\r", "&#xD;", $value);
    $value = str_replace("\n", '&#xA;', $value);
    $value = str_replace(' ', '&#x20;', $value);
    $value = str_replace("\t", '&#x9;', $value);

    return $value;
}



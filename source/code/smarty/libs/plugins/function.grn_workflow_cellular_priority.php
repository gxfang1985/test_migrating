<?php

require_once('workflow/properties.csp');

/**
 * @name grn_workflow_priority
 * @description 渡された配列をもとに優先度を表示する
 *
 * @date
 * @author
 *
 * @param  string  value
 * @param  array   options    要素配列
 *
 */
function smarty_function_grn_workflow_cellular_priority($params, &$smarty)
{
    $function_name = 'grn_workflow_priority';
    //-- get parameters
    $value = '0';
    if (array_key_exists('value', $params)) {
        $value = $params['value'];
    }
    $properties_logic = GRN_Workflow_Properties::getInstance();
    $property =& $properties_logic->get('priority');
    $label = "";
    if ( ! is_null($value) && strlen($value) > 0 && $value != 0) {
        foreach ($property['options'] as $key => $option) {
            if ($option['value'] == $value) {
                $label = $option['label'];
                break;
            }
        }
    }
    $label = htmlspecialchars($label);

    return $label;
}


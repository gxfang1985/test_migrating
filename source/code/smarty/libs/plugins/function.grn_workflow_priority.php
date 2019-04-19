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
function smarty_function_grn_workflow_priority($params, &$smarty)
{
    $function_name = 'grn_workflow_priority';
    //-- get parameters
    $value = '0';
    if (array_key_exists('value', $params)) {
        $value = $params['value'];
    }
    /*
    else
    {
        return htmlspecialchars($function_name) . ': $value is required';
    }
    */
    $mode = 'view';
    if (array_key_exists('mode', $params)) {
        $mode = $params['mode'];
    }
    /*
    else
    {
        return htmlspecialchars($function_name) . ': $mode is required';
    }
    */

    $properties_logic = GRN_Workflow_Properties::getInstance();
    $property =& $properties_logic->get('priority');
    if ($mode == 'view_confirm') {
        $label = "";
        foreach ($property['options'] as $key => $option) {
            if ($option['value'] == $value) {
                $label = $option['label'];
                break;
            }
        }
        $label = htmlspecialchars($label);

        return $label;
    } elseif ($mode == 'view') {
        $label = "";
        if ( ! is_null($value) && strlen($value) > 0 && $value != 0) {
            foreach ($property['options'] as $key => $option) {
                if ($option['value'] == $value) {
                    $label = $option['label'];
                    break;
                }
            }
        }
        $label
            = sprintf("<span class='wf_priority'><span class='%s'>%s</span></span>",
            htmlspecialchars($option['class']), htmlspecialchars($label));

        return $label;
    } elseif ($mode == 'view_list') {
        $label = "";
        if ( ! is_null($value) && strlen($value) > 0 && $value != 0) {
            foreach ($property['options'] as $key => $option) {
                if ($option['value'] == $value) {
                    $label = $option['label'];
                    break;
                }
            }
        }
        $label
            = sprintf("<span class='wf_priority'><span class='%s'>%s</span></span>",
            htmlspecialchars($option['class']), htmlspecialchars($label));

        return $label;
    } elseif ($mode == 'edit') {
        $param = [];
        $param['name'] = 'priority';
        $param['size'] = '1';
        $param['class'] = 'js_customization_input_urgent';
        foreach ($property['options'] as $key => $option) {
            if ($option['value'] == $value) {
                $property['options'][$key]['selected'] = true;
                break;
            }
        }
        $param['options'] = $property['options'];

        static $include_grn_select = false;
        if ($include_grn_select === false) {
            require_once($smarty->_get_plugin_filepath('function',
                'grn_select'));
            $include_grn_select = true;
        }

        return smarty_function_grn_select($param, $smarty);
    }

    return "";
}


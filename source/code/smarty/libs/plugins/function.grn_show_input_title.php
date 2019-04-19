<?php

/**
 * @param  boolean  necessary       if true, show red '*'
 *
 * @option string   title           title string
 * @option string   title_module    module path
 * @option string   title_key       module key
 *
 * @date   2005/02/16
 * @author SHIMADA Kunihiko
 */

function smarty_function_grn_show_input_title($params, &$smarty)
{
    $function_name = 'grn_show_input_title';

    $title_string = @ htmlspecialchars($params['title']);
    $necessary = @ $params['necessary'];
    $number = @ $params['number'];

    if (0 == strlen($title_string)) {
        $title_module = $params['title_module'];
        $title_key = $params['title_key'];
        $title_string = cb_msg($title_module, $title_key);
//        return $function_name . ": $title is necessary";
    }

    if ($necessary) {
        $necessary_string = '<span class="attention">*</span>';
    } else {
        $necessary_string = "";
    }

    if ($number) {
        $number_string = '<font color="blue">#</font>';
    } else {
        $number_string = "";
    }

    $return_string = $title_string . $necessary_string . $number_string;

    return $return_string;
}


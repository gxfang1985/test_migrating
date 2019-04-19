<?php

function smarty_function_grn_tab($params, &$smarty)
{
    $function_name = 'grn_tab';
    $ret = '';

    $page_param = @ $params['page_param'];

    if ( ! $page_param) {
        $page_param = [];
    }
    $page_param['page'] = @ $params['page'];

    $caption = @ $params['caption'];
    $id = @ $params['id'];

    $ret .= '<div class="tab">';

    if (array_key_exists('selected', $params) && $params['selected'] == true) {
        $ret .= "<span class=\"tab_left_on\"></span><span id=\"$id\" class=\"tab_on\">$caption</span><span class=\"tab_right_on\"></span>";
    } else {
        $page_param['caption'] = $caption;
        require_once $smarty->_get_plugin_filepath('function', 'grn_link');
        $link = smarty_function_grn_link($page_param, $smarty);
        $ret .= "<span class=\"tab_left_off\"></span><span  id=\"$id\" class=\"tab_off\">$link</span><span class=\"tab_right_off\"></span>";
    }

    $ret .= '</div>';

    return $ret;
}


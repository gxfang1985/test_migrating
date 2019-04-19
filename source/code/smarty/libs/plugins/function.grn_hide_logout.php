<?php

/**
 * @name   grn_hide_logout
 *
 * @param string assign
 *  <pre>{grn_hide_logout assign="hide_logout"}
 */
function smarty_function_grn_hide_logout($params, &$smarty)
{
    $function_name = 'grn_show_logout';

    // necessary parameter and value
    if ( ! array_key_exists('assign', $params)) {
        return htmlspecialchars($function_name) . ': missing assign parameter';
    }

    $assign_name = $params['assign'];

    global $G_config_common;
    $hide_logout = $G_config_common->get('Global', 'hide_logout');
    if ($hide_logout == 1) {
        $hide_logout = true;
    } else {
        $hide_logout = false;
    }

    $smarty->assign($assign_name, $hide_logout);
}


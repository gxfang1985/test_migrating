<?php

require_once('fw/i18n.csp');

/*
 * Smarty plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     cb_msg
 * Purpose:  Cybozu I18N message resource replacement
 * Input:    module = module ID (case insensitive)
 *           key = key for message resource
 *           replace = the parameter to call the function cb_msg_tplrc()
 *           params = assosiative array to replace parameters in
 *                    message resource (&&age&& will be replaced
 *                    with $params['age']
 * 
 * Examples: {cb_msg module="FW" key="Hello, World."}
 *           {cb_msg module="Sample" key="I am &&age&& years old." params="$myParams"}
 *           {cb_msg module="Sample" key="example" replace="true"}
 * -------------------------------------------------------------
 */
function smarty_function_cb_msg($smarty_parameters, &$smarty)
{
    if (empty($smarty_parameters['module'])) {
        $smarty->trigger_error("cb_msg: missing 'module' parameter");

        return;
    }
    if (empty($smarty_parameters['key'])) {
        $smarty->trigger_error("cb_msg: missing 'key' parameter");

        return;
    }
    $module = $smarty_parameters['module'];
    $key = $smarty_parameters['key'];

    if (isset($smarty_parameters['params'])) {
        return cb_msg($module, $key, $smarty_parameters['params']);
    }

    if (count($smarty_parameters) > 2) {
        unset($smarty_parameters['module']);
        unset($smarty_parameters['key']);

        global $G_config_common;
        $is_develop = $G_config_common->get('Global', 'develop');
        if ($is_develop && isset($smarty_parameters['replace'])) {
            if ($smarty_parameters['replace'] === 'true') {
                return cb_msg_tplrc($module, $key);
            }
        }

        return cb_msg($module, $key, $smarty_parameters);
    }

    return cb_msg($module, $key);
}


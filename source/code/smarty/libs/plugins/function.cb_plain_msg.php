<?php

require_once('fw/i18n.csp');

/*
 * Smarty plugin
 * -------------------------------------------------------------
 * Type:     function
 * Name:     cb_plain_msg
 * Version:  1.0
 * Date:     Aug 21, 2003
 * Author:   Akky AKIMOTO, Hiroki <akimoto@share360.com>
 *           Yamamoto, Hirotaka <hyamamoto@cybozu.co.jp>
 * Purpose:  Cybozu I18N message resource replacement
 * Input:    module = module ID (case insensitive)
 *           key = key for message resource
 *           params = assosiative array to replace parameters in
 *                    message resource (&&age&& will be replaced
 *                    with $params['age']
 * 
 * Examples: {cb_plain_msg module="FW" key="Hello, World."}
 *           {cb_plain_msg module="Sample" key="I am &&age&& years old." params="$myParams"}
 * -------------------------------------------------------------
 */
function smarty_function_cb_plain_msg($smarty_parameters, &$smarty)
{
    if (empty($smarty_parameters['module'])) {
        $smarty->trigger_error("cb_plain_msg: missing 'module' parameter");

        return;
    }
    if (empty($smarty_parameters['key'])) {
        $smarty->trigger_error("cb_plain_msg: missing 'key' parameter");

        return;
    }
    if (isset($smarty_parameters['params'])) {
        return cb_plain_msg($smarty_parameters['module'],
            $smarty_parameters['key'], $smarty_parameters['params']);
    } elseif (count($smarty_parameters) > 2) {
        $module = $smarty_parameters['module'];
        $key = $smarty_parameters['key'];
        unset($smarty_parameters['module']);
        unset($smarty_parameters['key']);

        return cb_plain_msg($module, $key, $smarty_parameters);
    } else {
        return cb_plain_msg($smarty_parameters['module'],
            $smarty_parameters['key']);
    }
}


<?php

function smarty_function_grn_msg_switch($params, $smarty)
{
    $locale = @$params["locale"];
    switch ($locale) {
        case "system":
            $user_style = "display:none;";
            $system_style = "";
            break;
        case "user":
        default:
            $user_style = "";
            $system_style = "display:none;";
            break;
    }
    $user_content = _smarty_function_grn_msg_switch_user($params, $smarty);
    $system_content = _smarty_function_grn_msg_switch_system($params, $smarty);

    return "<span class=\"user\" style=\"$user_style\">$user_content</span><span class=\"system\" style=\"$system_style\">$system_content</span>";
}

function _smarty_function_grn_msg_switch_user($params, $smarty)
{
    require_once($smarty->_get_plugin_filepath('function', 'cb_msg'));

    return smarty_function_cb_msg($params, $smarty);
}

function _smarty_function_grn_msg_switch_system($params, $smarty)
{
    require_once("fw/i18n.csp");
    require_once("fw/i18n/system_config.csp");
    if (isset($params["params"])) {
        return cb_msg($params["module"], $params["key"], $params["params"],
            CB_I18N_SystemConfig::getPrintLanguage());
    } else {
        return cb_msg($params["module"], $params["key"], null,
            CB_I18N_SystemConfig::getPrintLanguage());
    }
}

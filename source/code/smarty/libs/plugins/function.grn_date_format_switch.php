<?php

function smarty_function_grn_date_format_switch($params, $smarty)
{
    require_once("fw/i18n/system_config.csp");
    $switch = isset($params["locale"]) ? $params["locale"] : null;

    switch ($switch) {
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
    $user_content = _smarty_function_grn_date_format_switch_user($params,
        $smarty);
    $system_content = _smarty_function_grn_date_format_switch_system($params,
        $smarty);

    return "<span class=\"user\" style=\"$user_style\">$user_content</span><span class=\"system\" style=\"$system_style\">$system_content</span>";

}

function _smarty_function_grn_date_format_switch_user($params, $smarty)
{
    require_once($smarty->_get_plugin_filepath('function', 'grn_date_format'));

    return smarty_function_grn_date_format($params, $smarty);
}

function _smarty_function_grn_date_format_switch_system($params, $smarty)
{
    $date = array_key_exists('date', $params) ? $params['date'] : null;
    $format_key = array_key_exists('format', $params) ? $params['format']
        : "DateTimeCompact";
    $language = CB_I18N_SystemConfig::getPrintLanguage();
    $tzname = array_key_exists('tzname', $params) ? $params['tzname']
        : null;
    $user_id = array_key_exists('user', $params) ? $params['user'] : null;
    $page = array_key_exists('page', $params)
        ? strtolower($params['page']) : null;
    require_once("fw/date.csp");
    if ( ! is_null($page) && $page == 'personal_month') {
        $dateArr = cb_date_datetime2array($date, $language, $tzname);

        return cb_msg('fw.date', "DateShortMini_MD", $dateArr);
    }

    return CB_DateFormatSystem::getDateTimeFormat($format_key, $date, $user_id,
        $tzname, $language, 1);

}

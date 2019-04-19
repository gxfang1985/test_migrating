<?php

function smarty_function_grn_select_timezone($params, &$smarty)
{
    $t = new GRN_Smarty();

    $all_timezones = CB_I18N::getAvailableTimezones();
    $t->assign('all_timezones', $all_timezones);

    $t->assign('timezone_regions', CB_I18N::getTimezoneRegions());

    require_once('fw/i18n/system_config.csp');
    if (defined('ON_FOREST')) {
        $timezone_candidates = $all_timezones;
    } else {
        $timezone_candidates = CB_I18N_SystemConfig::getDisplayTimezones();
    }

    $i18n = CB_I18N::getInstance();
    $default_timezone = $i18n->getDefaultTimezone();

    if ( ! in_array($default_timezone, $timezone_candidates)) {
        $timezone_candidates[] = $default_timezone;
    }

    if (isset($params['select_timezone'])
        && strlen($params['select_timezone']) > 0
    ) {
        $t->assign('select_timezone', $params['select_timezone']);
        if ( ! in_array($params['select_timezone'], $timezone_candidates)) {
            array_unshift($timezone_candidates, $params['select_timezone']);
        }
    }

    $timezone_element_id = isset($params['key']) ? $params['key'] : 'timezone';
    $t->assign('timezone_key', $timezone_element_id);

    $t->assign('timezone_candidates', $timezone_candidates);

    return $t->fetch('grn/select_timezone.tpl');
}

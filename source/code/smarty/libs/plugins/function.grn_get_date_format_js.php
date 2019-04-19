<?php

/**
 *  Show JavaScript source to display date/time in localized format.
 *
 */
function smarty_function_grn_get_date_format_js($parameters, & $smarty)
{
    $function_name = 'grn_get_date_format';

    require_once("grn/smarty.csp");
    $t = new GRN_Smarty();

    require_once("fw/i18n.csp");
    $i18n = CB_I18N::getInstance();

    if (array_key_exists("function_name_prefix", $parameters)) {
        $t->assign("function_name_prefix", $parameters["function_name_prefix"]);
    } else {
        $t->assign("function_name_prefix", "cy_schedule_gw_date_params");
    }

    $t->assign("month_short_array",
        '[' .
        '"' . cb_msg("fw.date", "MonthShort1") . '",' .
        '"' . cb_msg("fw.date", "MonthShort2") . '",' .
        '"' . cb_msg("fw.date", "MonthShort3") . '",' .
        '"' . cb_msg("fw.date", "MonthShort4") . '",' .
        '"' . cb_msg("fw.date", "MonthShort5") . '",' .
        '"' . cb_msg("fw.date", "MonthShort6") . '",' .
        '"' . cb_msg("fw.date", "MonthShort7") . '",' .
        '"' . cb_msg("fw.date", "MonthShort8") . '",' .
        '"' . cb_msg("fw.date", "MonthShort9") . '",' .
        '"' . cb_msg("fw.date", "MonthShort10") . '",' .
        '"' . cb_msg("fw.date", "MonthShort11") . '",' .
        '"' . cb_msg("fw.date", "MonthShort12") . '"' .
        ']');

    $t->assign("month_full_array",
        '[' .
        '"' . cb_msg("fw.date", "MonthFull1") . '",' .
        '"' . cb_msg("fw.date", "MonthFull2") . '",' .
        '"' . cb_msg("fw.date", "MonthFull3") . '",' .
        '"' . cb_msg("fw.date", "MonthFull4") . '",' .
        '"' . cb_msg("fw.date", "MonthFull5") . '",' .
        '"' . cb_msg("fw.date", "MonthFull6") . '",' .
        '"' . cb_msg("fw.date", "MonthFull7") . '",' .
        '"' . cb_msg("fw.date", "MonthFull8") . '",' .
        '"' . cb_msg("fw.date", "MonthFull9") . '",' .
        '"' . cb_msg("fw.date", "MonthFull10") . '",' .
        '"' . cb_msg("fw.date", "MonthFull11") . '",' .
        '"' . cb_msg("fw.date", "MonthFull12") . '"' .
        ']');


    $t->assign("wday_short_array",
        '[' .
        '"' . cb_msg("fw.date", "WDayShort0") . '",' .
        '"' . cb_msg("fw.date", "WDayShort1") . '",' .
        '"' . cb_msg("fw.date", "WDayShort2") . '",' .
        '"' . cb_msg("fw.date", "WDayShort3") . '",' .
        '"' . cb_msg("fw.date", "WDayShort4") . '",' .
        '"' . cb_msg("fw.date", "WDayShort5") . '",' .
        '"' . cb_msg("fw.date", "WDayShort6") . '"' .
        ']');

    $t->assign("wday_full_array",
        '[' .
        '"' . cb_msg("fw.date", "WDayFull0") . '",' .
        '"' . cb_msg("fw.date", "WDayFull1") . '",' .
        '"' . cb_msg("fw.date", "WDayFull2") . '",' .
        '"' . cb_msg("fw.date", "WDayFull3") . '",' .
        '"' . cb_msg("fw.date", "WDayFull4") . '",' .
        '"' . cb_msg("fw.date", "WDayFull5") . '",' .
        '"' . cb_msg("fw.date", "WDayFull6") . '"' .
        ']');

    $t->assign("notation_array",
        '{' .
        '"AM":"' . cb_msg("fw.date", "AM") . '",' .
        '"PM":"' . cb_msg("fw.date", "PM") . '"' .
        '}');

    $date_format = cb_at(
        $parameters,
        'format',
        $i18n->getResource("message", "fw.date", "DateFull_YMDW")
    );
    $t->assign("date_template_object",
        "{" .
        '"DateFull_YMDW": "' . $date_format . '"' .
        '}');

    return $t->fetch("grn/date_format_js.tpl");
}



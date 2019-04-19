<?php

function smarty_function_cb_locale_selection($params, &$smarty)
{
    $required_keys = [
        "language_code_list",

        "language_id",
        "long_date_format_id",
        "short_date_format_id",
        "time_format_id",

        "long_date_format_list",
        "short_date_format_list",
        "time_format_list",
    ];


    require_once("grn/smarty.csp");
    $t = new GRN_Smarty();

    foreach ($required_keys as $required_key) {
        assert('array_key_exists($required_key, $params)');
        $t->assign($required_key, $params[$required_key]);
    }

    return $t->fetch("grn/locale_selection_js.tpl");
}

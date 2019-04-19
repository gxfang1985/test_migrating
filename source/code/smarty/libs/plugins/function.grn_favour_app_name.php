<?php

use grn\favour\Application as favour_applicaton;

function smarty_function_grn_favour_app_name($params, &$smarty)
{
    $function_name = 'grn_favour_app_name';
    require_once('grn/application.csp');
    $app_locator = GRN_ApplicationLocator::instance();

    return htmlspecialchars($app_locator->getName(favour_applicaton::APPLICATION_ID));
}


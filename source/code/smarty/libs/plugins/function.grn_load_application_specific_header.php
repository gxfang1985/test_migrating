<?php

/**
 * Show application specific header
 *
 * At now, This function effects only space application.
 *
 * @param array  $parameters
 * @param Smarty $smarty
 */
function smarty_function_grn_load_application_specific_header(
    $parameters,
    $smarty
) {
    /**
     * Application ID
     *
     * This is optional
     *
     * @var string
     */
    $applicationId = isset($parameter['application'])
        ? $parameter['application'] : null;

    /*
     * When $applicationId is abbreviated, the variable is initialized with PATH_INFO
     */
    if (strlen($applicationId) == 0) {
        $pathList = explode("/", cb_get_pagename());
        if (count($pathList) > 0 && $pathList[0] != "index"
            && $pathList[0] != "index.csp"
        ) {
            $applicationId = $pathList[0];
        } else {
            $applicationId = "portal";
        }
    }

    $applicationLocator = GRN_ApplicationLocator::instance();
    $activeApplications = $applicationLocator->getActiveApplicationIds();

    foreach ($activeApplications as $activeApplicationId) {
        if ($applicationId == $activeApplicationId) {
            //An now, only the space application uses this function.
            if ($applicationId == "space" || $applicationId == "mail"
                || $applicationId == "portal"
            ) {
                return $smarty->fetch($applicationId . "/header.tpl");
            }
        }
    }

    return "";
}

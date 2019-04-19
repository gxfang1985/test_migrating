<?php

/**
 * @param string page       the page name
 *
 * @option mixed   (var)    URL引数
 * @option array params      rest URL parameters
 * @option string fragment  fragments after #
 * @option string postfix     contents after /-/
 */

function smarty_function_grn_workflow_cellular_pageurl($params, &$smarty)
{
    $function_name = "grn_workflow_cellular_pageurl";

    require_once('grn/ui.csp');
    $params = grn_ui_url_params($params, $function_name, $smarty);

    $page = $params['page'];
    $fragment = @ $params['fragment'];
    $postfix = @ $params['postfix'];
    $rest_params = (array)@ $params['url_params'];

    require_once('workflow/cellular.csp');
    $pageurl = grn_workflow_cellular_pageurl($page, $rest_params, $fragment,
        $postfix);
    $pageurl = grn_workflow_cellular_remote_path($pageurl);

    return $pageurl;
}

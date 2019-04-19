<?php
require_once('grn/ui.csp');

/**
 * @param string page       the page name
 *
 * @option mixed   (var)    URL引数
 * @option array params      rest URL parameters
 * @option string fragment  fragments after #
 * @option string postfix     contents after /-/
 */

function smarty_function_grn_pageurl($params, &$smarty)
{
    $function_name = 'grn_pageurl';

    $params = grn_ui_url_params($params, $function_name, $smarty);

    $page = $params['page'];


    if (array_key_exists('fragment', $params)) {
        $fragment = $params['fragment'];
    } else {
        $fragment = null;
    }

    if (array_key_exists('postfix', $params)) {
        $postfix = $params['postfix'];
    } else {
        $postfix = null;
    }

    if (array_key_exists('url_params', $params)) {
        $rest_params = (array)$params['url_params'];
    } else {
        $rest_params = [];
    }

    unset($params['page'], $params['fragment'], $params['postfix']);

    return cb_pageurl($page, $rest_params, $fragment, $postfix);
}

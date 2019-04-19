<?php
/**
 * @param $parameters
 * @param $smarty Smarty
 *
 * @return string
 */
function smarty_function_grn_cbwebsrv_route($parameters, &$smarty)
{
    // check license
    require_once('cbwebsrv/tool_define.csp');
    require_once('cbwebsrv/common.csp');
    if ( ! grn_cbwebsrv_is_available_service(GRN_CBWEBSRV_SERVICE_ROUTE)) {
        return '';
    }
    $function_name = 'grn_cbwebsrv_route';
    //Create Route Button
    require_once('grn/application.csp');
    $locator = GRN_ApplicationLocator::instance();
    $app
        = $locator->getInstance('cbwebsrv', true);
    $token
        = grn_cbwebsrv_create_request_token();
    $base_service_url
        = $app->getConfig('transit_url');
    $service_url = $base_service_url . '?token=' . $token;
    $route_data
        = ['service_url' => $service_url];
    $route_data_container_selector
        = $parameters['route_data_container_selector'] ??
          '#js_route_search';
    $route_data['route_data_container_selector']
        = $route_data_container_selector;
    if ($parameters['route_name_field']) {
        $route_data['route_name_field'] = $parameters['route_name_field'];
    }
    if ($parameters['route_time_field']) {
        $route_data['route_time_field'] = $parameters['route_time_field'];
    }
    if ($parameters['route_fare_field']) {
        $route_data['route_fare_field'] = $parameters['route_fare_field'];
    }
    if ($parameters['popup_width']) {
        $route_data['popup_width'] = $parameters['popup_width'];
    }
    if ($parameters['popup_height']) {
        $route_data['popup_height'] = $parameters['popup_height'];
    }
    $caption = $parameters['caption'] ?? '';
    $extra_button_class = $parameters['extra_button_class'] ?? '';

    if (is_null($caption) || strlen($caption) === 0) {
        return htmlspecialchars($function_name) . ': $caption is empty';
    }

    $button_class = "aButtonStandard-grn";
    if ($extra_button_class) {
        $button_class .= ' ' . $extra_button_class;
    }
    $caption = htmlspecialchars($caption);

    $error_message = '';
    if ( ! $base_service_url) {
        $error_message = cb_msg('grn.cbwebsrv',
            'grn.cbwebsrv.invalid_transit_url');
        $button_class .= ' button_disable_filter_grn'; // disable button if error
    }
    $route_data['error_message'] = $error_message;
    $json_route_data = json_encode($route_data);
    $smarty->assign('error_message', $error_message);
    $smarty->assign('button_class', $button_class);
    $smarty->assign('json_route_data', $json_route_data);
    $smarty->assign('caption', $caption);
    $smarty->assign('route_data_container_selector',
        $route_data_container_selector);

    return $smarty->fetch('grn/cbwebsrv_route.tpl');
}


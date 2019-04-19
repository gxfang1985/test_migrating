<?php
require_once 'fw/ui.csp';
require_once 'grn/ui.csp';

/**
 * @name   grn_customer_logo
 *
 *  お客様ロゴの出力
 *
 * @date   2005/04/11
 */
function smarty_function_grn_customer_logo($params, &$smarty)
{
    require_once('grn/customer.csp');
    $customer = GRN_Customer::getInstance();
    $company_name = $customer->getProperty('company_name');
    if ($company_name) {
        $logo_title = htmlspecialchars($company_name);
    } else {
        $logo_title = cb_msg('grn.grn', 'grn.header.default_logo_title');
    }
    $logo = $customer->getProperty('logo_path');
    //URLに使用不可能な文字を除外 
    $pattern = "/[^a-zA-Z0-9\-._~%:\/?#\[\]@!$&'()*+,;=]/";
    $logo = preg_replace($pattern, "", $logo);

    global $G_config_common;
    $is_debug = ($G_config_common->get('Global', 'debug')
                 & ERROR_TRACE_LOG_FLAG_213);
    $config_grn = new CB_ConfigManager(cb_basedir() . '/garoon.ini', 'Global');
    if ( ! $config_grn || $is_debug) {
        $build_date = time();
    } else {
        $build_date = $config_grn->get('System', 'build_date');
    }

    $build_date .= '.text';

    if ($logo) {
        $page = '<img src="' . $logo . '?' . $build_date . '" border="0" alt="'
                . $logo_title
                . '" onload="grn.component.autofit.autofit(this,document.getElementById(\'cloudHeader-customer-logo\'), 26, Number.MAX_VALUE);">';
    } else {
        $logo = $customer->getProperty('logo_file');
        if ($logo) {
            $body = $logo->getCurrentBody();
            $params = ['hash' => $body->get('hash')];
            $page
                = sprintf('<img id="the-logo" src="%s" alt="%s" border="0" onload="grn.component.autofit.autofit(this,document.getElementById(\'cloudHeader-customer-logo\'), 26, Number.MAX_VALUE);">',
                cb_pageurl('grn/customer_image_download', $params, null,
                    $body->get('name')), $logo_title);
        } else {
            $page = '<span class="header_logo_grn"></span>';
        }
    }
    $url = cb_pageurl('index');
    $page
        = sprintf('<a href="%s" class="cloudHeader-logo-grn" title="%s" aria-label="%s">%s</a>',
        $url, $logo_title, $logo_title, $page);

    return $page;
}



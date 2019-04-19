<?php

/**
 * @param       array  $params
 * @param       Smarty $smarty
 *
 * @return string
 */
function smarty_function_grn_load_customization_js_css($params, $smarty)
{
    $customization_js_css_loader
        = \grn\grn\customization\CustomizationJsCssLoader::getInstance();

    if ( ! $customization_js_css_loader->isLoadableEvents()) {
        return "";
    }

    $t = new GRN_Smarty();
    $t->assign('system_js', $customization_js_css_loader->getSystemJS());
    $t->assign('application_js',
        $customization_js_css_loader->getApplicationJS());
    $t->assign('application_init_data',
        $customization_js_css_loader->getApplicationInitData());
    $t->assign('user_js', $customization_js_css_loader->getUserJS());
    $t->assign('user_css', $customization_js_css_loader->getUserCSS());
    $t->assign('event_info', $customization_js_css_loader->getEventInfo());

    $trigger_event_on_load = cb_at($params, 'trigger_event_on_load', false);
    $t->assign('trigger_event_on_load', $trigger_event_on_load);
    $t->assign('is_forest', cb_is_forest());

    return $t->fetch('grn/load_customization_js_css.tpl');
}

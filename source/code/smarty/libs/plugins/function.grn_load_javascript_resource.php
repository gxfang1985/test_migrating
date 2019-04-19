<?php

function smarty_function_grn_load_javascript_resource($params, $smarty)
{
    global $G_config_common;
    $is_develop = $G_config_common->get('Global', 'develop');
    if ($is_develop) {
        $url = cb_pageurl('js_resource');

        return "<script src='$url'></script>";
    } else {
        $html_tag_lang = $smarty->getHtmlTagLanguage();
        $url = 'grn/html/resource-' . $html_tag_lang . '.js';

        return "<script src=\"{$smarty->get_template_vars('app_path')}/{$url}?{$smarty->get_template_vars('build_date')}\"></script>";
    }
}

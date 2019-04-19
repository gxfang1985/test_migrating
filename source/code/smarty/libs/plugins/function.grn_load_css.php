<?php

function smarty_function_grn_load_css($parameters, &$smarty)
{
    $file = $parameters['file'];

    $media = '';
    if (isset($parameters['media']) && '' !== trim($parameters['media'])) {
        $media = ' media="' . $parameters['media'] . '"';
    }

    static $loadedCss = [];
    global $G_state_set;
    if ( ! $G_state_set->get('error_occurred')
         && array_key_exists($file, $loadedCss)
    ) {
        return "";
    }

    $loadedCss[$file] = 1;

    return "<link href=\"{$smarty->get_template_vars('app_path')}/{$parameters['file']}?{$smarty->get_template_vars('build_date')}\"{$media} rel=\"stylesheet\" type=\"text/css\">";
}

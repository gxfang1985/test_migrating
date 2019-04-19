<?php
/**
 * @param array      $parameters
 * @param GRN_Smarty $smarty
 *
 * @return string
 */
function smarty_function_grn_load_javascript($parameters, &$smarty)
{
    $file = $parameters['file'];

    static $loadedJs = [];
    global $G_state_set;
    if ( ! $G_state_set->get('error_occurred')
         && array_key_exists($file, $loadedJs)
    ) {
        return "";
    }

    $loadedJs[$file] = 1;

    return "<script src=\"{$smarty->get_template_vars('app_path')}/{$file}?{$smarty->get_template_vars('build_date')}\" type=\"text/javascript\"></script>";
}

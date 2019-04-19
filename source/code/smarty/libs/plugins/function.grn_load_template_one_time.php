<?php
/**
 * load template file. The file only load one time
 *
 * @param $parameters
 * @param $smarty Smarty
 *
 * @return string
 */
function smarty_function_grn_load_template_one_time($parameters, &$smarty)
{
    $file = $parameters['file'];

    static $loadedTemplate = [];
    global $G_state_set;
    if ( ! $G_state_set->get('error_occurred')
         && array_key_exists($file, $loadedTemplate)
    ) {
        return "";
    }

    $loadedTemplate[$file] = 1;

    return $smarty->fetch($file);
}

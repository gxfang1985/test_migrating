<?php
/***
 * @param array $parameters
 *
 * @return string
 */
function smarty_function_grn_customization_init_data($parameters)
{
    $module = cb_at($parameters, 'module', '');
    $json_data = json_encode(cb_at($parameters, 'init_data', []));

    return "<script> if (garoon['{$module}']) { garoon['{$module}'].init($json_data); } </script>";
}

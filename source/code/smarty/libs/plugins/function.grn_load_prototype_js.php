<?php
declare(strict_types=1);

use grn\grn\PrototypeJsLoadPage;

/**
 * @param array      $parameters
 * @param GRN_Smarty $smarty
 *
 * @return string
 */
function smarty_function_grn_load_prototype_js($parameters, &$smarty): string
{
    $page_name = cb_get_pagename();

    $prototype_js_load_page = new PrototypeJsLoadPage();
    if ($prototype_js_load_page->isLoadPage($page_name)) {
        $before  = '<script>Date.prototype.toJSONOriginal = Date.prototype.toJSON </script>';
        $load = smarty_function_grn_load_javascript(["file" => "fw/prototype.js"], $smarty);
        $customize_prototype = "<script>
delete Array.prototype.toJSON;
delete Hash.prototype.toJSON;
delete String.prototype.toJSON;
delete Number.prototype.toJSON;
Date.prototype.toJSON = Date.prototype.toJSONOriginal;
delete Date.prototype.toJSONOriginal;
</script>";

        return $before . $load . $customize_prototype;
    }

    return "";

}

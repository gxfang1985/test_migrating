<?php

use grn\grn\JSONResponse;

/**
 * return JSON string literal for REST API(v1)
 *
 * @see https://github.dev.cybozu.co.jp/garoon/garoon/pull/631/files#L0R31
 *
 * @param            $params
 * @param GRN_Smarty $smarty
 *
 * @return bool|mixed|string
 */
function smarty_function_grn_error_page_v1($params, $smarty)
{

    $result = new StdClass;
    $result->success = false;
    $result->code = $smarty->get_template_vars("ErrorNumber");
    $result->message = $smarty->get_template_vars("ErrorDiag");
    if ($smarty->get_template_vars("show_backtrace")) {
        $result->cause = $smarty->get_template_vars("ErrorCause");
        $result->developer_info
            = $smarty->get_template_vars("ErrorDeveloperInfo");
        $result->backtrace = explode("\n",
            $smarty->get_template_vars("ErrorDetailTable"));
    }
    $json = JSONResponse::create();

    return $json->encode((array)$result,
        JSON_HEX_QUOT | JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS);
}

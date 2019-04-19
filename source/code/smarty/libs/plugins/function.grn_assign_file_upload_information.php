<?php
/**
 * Smarty変数として定義する
 *
 * @param            $parameters
 * @param GRN_Smarty $smarty
 */
function smarty_function_grn_assign_file_upload_information(
    $parameters,
    &$smarty
) {
    require_once('grn/upload.csp');

    $upload_path = cb_get_upload_path();

    $smarty->assign("url", $upload_path);
}

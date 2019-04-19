<?php
/**
 * HTML5をサポートしているかどうかをSmarty変数にアサインする
 *
 * @param            $parameters
 * @param GRN_Smarty $smarty
 */
function smarty_function_grn_assign_is_html5_upload_supported(
    $parameters,
    &$smarty
) {
    $browser = $smarty->get_template_vars("browser");
    $OSType = cb_at($browser, "os_type");
    $browserType = cb_at($browser, "type");
    $browserVersion = cb_at($browser, "ver_major");
    $support = false;

    if ($browserType === "firefox" && $browserVersion >= 9) {
        $support = true;
    } elseif ($browserType === "chrome" && $browserVersion >= 16) {
        $support = true;
    } elseif ($OSType === "mac") {
        if ($browserType === "safari" && $browserVersion >= 5) {
            $support = true;
        }
    } else {
        if ($browserType === "msie" && $browserVersion >= 10) {
            $support = true;
        }
    }
    $smarty->assign("is_html5_upload_supported", $support);
}

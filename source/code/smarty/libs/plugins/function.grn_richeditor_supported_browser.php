<?php

use grn\re\SupportedBrowserDetector;

function smarty_function_grn_richeditor_supported_browser($params, &$smarty)
{
    $detector = new SupportedBrowserDetector();
    $smarty->assign('supported_browser', $detector->detect());
}

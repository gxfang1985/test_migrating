<?php
require_once('fw/slash_util.csp');

function smarty_function_grn_get_slash_logo()
{
    $region = CB_SlashUtil::getRegion();

    if ($region && $region === "CN") {
        $image = "cloudLogo_cn.png";
    } else {
        $image = "cloudLogo.png";
    }

    return $image;
}

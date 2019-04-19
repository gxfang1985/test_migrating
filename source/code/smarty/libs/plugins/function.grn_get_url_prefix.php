<?php

function smarty_function_grn_get_url_prefix($params, &$smarty)
{
    require_once('fw/miscFunctions.csp');
    return cb_get_url_prefix();
}

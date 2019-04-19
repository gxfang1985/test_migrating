<?php

require_once('fw/slash_util.csp');

function smarty_function_grn_slash_userimage($params, $smarty)
{
    if ( ! array_key_exists('size', $params)) {
        $smarty->trigger_error("grn_slash_userimage: missing 'size' parameter");

        return;
    }

    return CB_SlashDB::getInstance()->getUserImage(strtoupper($params['size']));
}

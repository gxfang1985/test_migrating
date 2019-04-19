<?php

require_once ('fw/slash_util.csp');

function smarty_function_grn_slash_assign($params, $smarty) {
    $user = cb_get_login_user();
    if( !$user )
    {
        return;
    }
    $slash = CB_SlashDB::getInstance();
    $info = $slash->getLogo();
    $smarty->assign('slash_logo', $info);
    $available = $slash->getAvailableServices();
    $smarty->assign('slash_available', $available);
    $smarty->assign('slash_username', $slash->getLoginUserName());
    $slash_skylab = [];
    $slash_skylab['license']
        = $slash->getAvailableServiceLicense('skylab');
    $slash_skylab['hasCert'] = $slash->hasSkylabCert();
    $slash_skylab['downloadCert'] = $slash->isCertDownload();
    $smarty->assign('slash_skylab', $slash_skylab);
    require_once( 'fw/slash_util.csp' );
    $smarty->assign( 'region', CB_SlashUtil::getRegion() );
}

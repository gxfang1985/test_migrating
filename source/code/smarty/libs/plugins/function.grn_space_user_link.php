<?php
require_once('grn/controller.csp');

use grn\space\common\exception\GrnInvalidArgumentException;
use grn\space\common\data\bean\SpaceMember;

function smarty_function_grn_space_user_link($params, &$smarty)
{
    $inSpaceMember = @ $params["user"];
    $noUserIcon = isset($params["noUserIcon"]);

    if ( ! ($inSpaceMember instanceof SpaceMember)) {
        throw new GrnInvalidArgumentException();
    }

    $height = cb_at($params, 'height');
    $width = cb_at($params, 'width');

    $inIsSystem = @$params["isSystem"] ? true : false;

    //T GTM-529
    global $G_container_base;
    $uum = $G_container_base->getInstance("uum");
    $login_user = $uum->getLoginUser();
    //T GTM-529
    $no_using_apps = $inSpaceMember->isNotUsingApp();

    if ($inSpaceMember->isInvalidUser() && ! $inSpaceMember->isDeleted()) {
        $iconFileName = "invaliduser20.gif";
    } elseif ( ! $inSpaceMember->isInvalidUser() && $no_using_apps
               && ! $inSpaceMember->isDeleted()
    ) //T GTM-529
    {
        $iconFileName = "invalid_app_user20.png";
    }//T GTM-529
    elseif ($inSpaceMember->getMemberID() == $login_user->getOID()) {
        $iconFileName = "loginuser20.gif";
    } else {
        $iconFileName = "user20.gif";
    }

    if ($noUserIcon === false) {
        require_once $smarty->_get_plugin_filepath('function', 'grn_image');
        $imageTag = smarty_function_grn_image([
            'image'  => $iconFileName,
            'height' => $height,
            'width'  => $width
        ], $smarty);
    } else {
        $imageTag = "";
    }

    if ($inSpaceMember->isDeleted() || ! $inSpaceMember->getMemberID()) {
        return $imageTag . htmlspecialchars($inSpaceMember->getDisplayName());
    } else {
        $userInfo = [
            '_id'             => $inSpaceMember->getMemberID(),
            'col_foreign_key' => $inSpaceMember->getForeignKey()
        ];
        $userInfoString
            = GRN_ControllerUtil::getPopupUserProfileURLById($inSpaceMember->getMemberID(),
            $inIsSystem, $userInfo);
        if (defined('ON_FOREST')) {
            $target = ' target="_blank"';
        } else {
            $target = '';
        }

        return '<a href="' . $userInfoString . '"' . $target . '>' . $imageTag
               . htmlspecialchars($inSpaceMember->getDisplayName()) . '</a>';
    }
}

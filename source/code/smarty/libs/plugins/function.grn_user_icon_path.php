<?php

/**
 * return path of the user icon
 *
 * @param array   $params $params[userId] = userId
 * @param \Smarty $smarty
 */
function smarty_function_grn_user_icon_path($params, $smarty)
{
    $userId = @$params["userId"];

    global $G_config_common;
    $grnIdentifierName = $G_config_common->get('Global', 'app_path');

    global $G_container_base;
    $uum = $G_container_base->getInstance("uum");
    $loginUser = $uum->getLoginUser();

    /** @var \grn\space\data\bean\SpaceUser $modifierUser */
    $modifierUser = cb_at($params, "modifier");

    if (is_object($loginUser) && $loginUser->getOID() == $userId) {
        return $grnIdentifierName . "/grn/image/cybozu/loginuser20.gif";
    } elseif ( ! empty($modifierUser)) {
        if ($modifierUser->isInvalidUser() && ! $modifierUser->isDeleted()) {
            return $grnIdentifierName . "/grn/image/cybozu/invaliduser20.gif";
        } elseif ( ! $modifierUser->isInvalidUser()
                   && $modifierUser->isNotUsingApp()
        ) {
            return $grnIdentifierName
                   . "/grn/image/cybozu/invalid_app_user20.png";
        } else {
            return $grnIdentifierName . "/grn/image/cybozu/user20.gif";
        }
    } else {
        return $grnIdentifierName . "/grn/image/cybozu/user20.gif";
    }
}

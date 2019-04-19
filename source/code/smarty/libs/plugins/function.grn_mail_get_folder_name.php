<?php

/**
 * @name grn_mail_get_folder_name
 * @description
 *   show the path from the root to the spcified folder
 *
 * @date   2004/12/21
 * @author K.Tokuta
 *
 * @param string folder_id the selected folder id
 *
 * @option integer truncated_caption truncate folder name character
 *  eg.)
 *   {grn_mail_get_folder_name folder_id=$folder_id truncated_caption=30}
 */
function smarty_function_grn_mail_get_folder_name($params, &$smarty)
{
    require_once('mail/utility.csp');
    $utility = GRN_Mail_Utility::getInstance();
    $mail_app = $utility->getMailApp();
    $folder_logic = $utility->getFolderLogic();

    //-- function name
    $function_name = 'grn_mail_get_folder_name';

    //-- check and assgin variables
    if ( ! array_key_exists('folder_id', $params)) {
        return htmlspecialchars($function_name) . ": \$folder_id is required";
    }

    $folder_id = $params['folder_id'];

    //-- get login user
    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $login_user = $uum->getLoginUser();
    if ( ! $login_user) {
        return htmlspecialchars($function_name) . ': not logined';
    }

    //-- get folder info of the specified folder, and get the parent folder id from the info
    $folder_data =& $folder_logic->getFolderData($folder_id, false,
        $b_throw_error = true);

    $folder_code = $folder_data['code'];

    if (strlen($folder_code) > 0) {
        $folder_name = cb_msg($mail_app->getModuleId(), $folder_code);
    } else {
        $folder_name = htmlspecialchars($folder_data['name']);
    }
    $truncated_caption = null;
    if (array_key_exists('truncated_caption', $params)) {
        $truncated_caption = @ (int)$params['truncated_caption'];
        $folder_name = mb_strimwidth($folder_name, 0, $truncated_caption,
            '...');
    }
    switch ($folder_code) {
        case GRN_MAIL_FOLDER_CODE_INBOX:
            $image = 'inbox20.gif';
            break;
        case GRN_MAIL_FOLDER_CODE_SENTBOX:
            $image = 'sentbox20.gif';
            break;
        case GRN_MAIL_FOLDER_CODE_UNSENT:
            $image = 'unsentbox20.gif';
            break;
        case GRN_MAIL_FOLDER_CODE_TRASH:
            $image = 'trashbox20.gif';
            break;
        default:
            $image = 'folder20.gif';
            break;
    }

    require_once($smarty->_get_plugin_filepath('function', 'grn_image'));

    return smarty_function_grn_image(['image' => $image], $smarty)
           . $folder_name;
}


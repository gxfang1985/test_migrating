<?php

/**
 * @name grn_message_get_folder_name
 * @description
 *   show the path from the root to the spcified folder
 *
 * @date   2004/12/21
 * @author K.Tokuta
 *
 * @param string folder_id the selected folder id
 *
 *  eg.)
 *   {grn_message_get_folder_name folder_id=$folder_id}
 */
function smarty_function_grn_message_get_folder_name($params, &$smarty)
{
    require_once('message/folder_logic.csp');
    $folder_logic = new GRN_Message_FolderLogic;

    //-- function name
    $function_name = 'grn_message_get_folder_name';

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
    $folder_info = $folder_logic->getFolderInfo($login_user, $folder_id);

    require_once('message/resources.csp');
    $folder_type = $folder_info['folder_type'];
    switch ($folder_type) {
        case GRN_MESSAGE_RECEIVINGFOLDER:
            $class = 'inbox20';
            break;
        case GRN_MESSAGE_SENDINGFOLDER:
            $class = 'sentbox20';
            break;
        case GRN_MESSAGE_DRAFTFOLDER:
            $class = 'unsentbox20';
            break;
        case GRN_MESSAGE_GARBAGEFOLDER:
            $class = 'trashbox20';
            break;
        case GRN_MESSAGE_GENERALFOLDER:
            $class = 'folder20';
            break;
    }

    $image_params = ['image' => $class . '.gif', 'alt' => ''];
    $img_tag = smarty_function_grn_image($image_params, $smarty);

    $return_string = "<span>" . $img_tag
                     . htmlspecialchars($folder_info['folder_name'])
                     . "</span>";

    //-- return string
    return $return_string;
}

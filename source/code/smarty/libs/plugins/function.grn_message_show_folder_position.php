<?php
/**
 * @name   grn_message_show_folder_position
 * @description
 *   show the path from the root to the spcified folder
 *
 * @date   11/25/2004
 * @author M.Oomori
 * @date   12/23/2004
 * @auther Eiji TAEN
 *          add html escape
 *
 * @param  string  folder_id           the selected folder id
 *
 *  eg.)
 *   {grn_message_show_folder_position folder_id=$folder_id}
 */

function _grn_message_show_folder_position_internal(
    $folder_logic,
    $folder_id,
    &$folder_type,
    $initial_string = null
) {
    //-- get login user
    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $login_user = $uum->getLoginUser();
    if ( ! $login_user) {
        return htmlspecialchars($function_name) . ': not logined';
    }

    //-- if $initial_string is set, initialize $return_string with $initial_string
    if ($initial_string) {
        $return_string = htmlspecialchars($initial_string);
    }

    //-- get folder info of the specified folder, and get the parent folder id from the info
    $folder_info = $folder_logic->getFolderInfo($login_user, $folder_id);
    $parent_folder_id = @ $folder_info['parent_id'];
    $folder_type = $folder_info['folder_type'];

    //-- if the parent folder exists, call me recursively
    if ($parent_folder_id) {
        $return_string .= _grn_message_show_folder_position_internal($folder_logic,
            $parent_folder_id, $folder_type);
        $return_string .= "&nbsp;&gt;&nbsp;"
                          . htmlspecialchars($folder_info['folder_name']);
    } else {
        // $parent_folder_id is null means the parent folder is the root
        $return_string .= "(" . htmlspecialchars($folder_info['folder_name'])
                          . ")";
    }

    //-- return string
    return $return_string;
}

function smarty_function_grn_message_show_folder_position($params, &$smarty)
{
    require_once('message/folder_logic.csp');
    $folder_logic = new GRN_Message_FolderLogic;

    //-- function name
    $function_name = 'grn_message_show_folder_position';

    //-- check and assgin variables
    if ( ! array_key_exists('folder_id', $params)) {
        return htmlspecialchars($function_name)
               . ": missing folder_id parameter";
    }
    $folder_id = $params['folder_id'];

    //-- create the path string
    $return_string = _grn_message_show_folder_position_internal($folder_logic,
        $folder_id, $folder_type, "");

    if (array_key_exists('show_icon', $params) && $params['show_icon']) {
        require_once('message/resources.csp');

        switch ($folder_type) {
            case GRN_MESSAGE_RECEIVINGFOLDER:
                $image = 'inbox20.gif';
                break;
            case GRN_MESSAGE_SENDINGFOLDER:
                $image = 'sentbox20.gif';
                break;
            case GRN_MESSAGE_DRAFTFOLDER:
                $image = 'unsentbox20.gif';
                break;
            case GRN_MESSAGE_GARBAGEFOLDER:
                $image = 'trashbox20.gif';
                break;
            default:
                $image = 'folder20.gif';
                break;
        }

        require_once($smarty->_get_plugin_filepath('function', 'grn_image'));
        $return_string = smarty_function_grn_image(['image' => $image], $smarty)
                         . $return_string;
    }

    //-- return string
    return $return_string;
}


<?php
/**
 * @name   grn_mail_show_folder_position
 * @description
 *   show the path from the root to the spcified folder
 *
 * @date   11/25/2004
 * @author M.Oomori
 * @date   12/23/2004
 * @auther Eiji TAEN
 *          add html escape
 * @date   2004/02/04
 * @auther A.Ikeda
 *
 * @param  string  folder_id           the selected folder id
 *
 *  eg.)
 *   {grn_mail_show_folder_position folder_id=$folder_id}
 */

function _grn_mail_show_folder_position_internal(
    & $mail_app,
    & $folder_logic,
    $folder_id,
    &$folder_code
) {
    $return_string = '';

    //-- get folder info of the specified folder, and get the parent folder id from the info
    $folder_data =& $folder_logic->getFolderData($folder_id, true, true);
    $folder_code = $folder_data['code'];
    $parent_folder_id = $folder_data['parent_id'];

    if (strlen($folder_code) > 0) {
        $folder_name = cb_msg($mail_app->getModuleId(), $folder_code);
    } else {
        $folder_name = htmlspecialchars($folder_data['name']);
    }

    //-- if the parent folder exists, call me recursively
    if ( ! is_null($parent_folder_id)) {
        $return_string .= _grn_mail_show_folder_position_internal($mail_app,
            $folder_logic, $parent_folder_id, $folder_code);
        $return_string .= "&nbsp;&nbsp;<strong>&gt;</strong>&nbsp;&nbsp;"
                          . $folder_name;
    } else {
        // $parent_folder_id is null means the parent folder is the root
        $return_string .= "(" . $folder_name . ")";
    }

    //-- return string
    return $return_string;
}

function smarty_function_grn_mail_show_folder_position($params, &$smarty)
{
    //-- get login user
    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $login_user = &$uum->getLoginUser();
    if ( ! $login_user) {
        return htmlspecialchars($function_name) . ': not logined';
    }

    require_once('mail/utility.csp');
    $utility = GRN_Mail_Utility::getInstance();
    $mail_app =& $utility->getMailApp();
    $folder_logic =& $utility->getFolderLogic();

    //-- function name
    $function_name = 'grn_mail_show_folder_position';

    //-- check and assgin variables
    if ( ! array_key_exists('folder_id', $params)) {
        return htmlspecialchars($function_name)
               . ": missing folder_id parameter";
    }
    $folder_id = $params['folder_id'];

    //-- create the path string
    $return_string = _grn_mail_show_folder_position_internal($mail_app,
        $folder_logic, $folder_id, $folder_code);

    if (array_key_exists('show_icon', $params) && $params['show_icon']) {
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
        $return_string = smarty_function_grn_image(['image' => $image], $smarty)
                         . $return_string;
    }

    //-- return string
    return $return_string;
}


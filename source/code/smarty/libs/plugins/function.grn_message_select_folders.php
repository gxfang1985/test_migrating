<?php
/**
 * @name   grn_message_select_folders
 * @description
 *   show <select> including folder <option> list or checkbox list
 *
 * @date     01/05/2005
 * @author   M.Oomori
 *
 * @param  string  select_name <select> tag's name
 * @param  string  selected_folder_id  the selected folder id
 * @param  string  hide_special_folder if this parameter is set, hide special folders, such as inbox, outbox, draft, and trash folder
 * @param  string  hide_root_folder if this parameter is set, hide the root folder
 * @param  string  hide_selected_folder if this parameter is set, hide the selected folder and it's child folders
 *
 * @option   string  parent_folder_id only use with hide_selected_folder option
 *
 * @param  string  need_checkbox if this parameter is set, use checkbox tag insted of select tag
 * @param  string  hide_garbage_folder if this parameter is set, hide the garbage folder
 * @param          exception_value the value of the exception option
 * @param  string  exception_item  the display name of the exception option
 *
 *  eg.)
 *   {grn_message_select_folders name="cid" selected_folder_id=5 hide_special_folder=1}
 *
 *
 * @date     2005.1
 * @author   Eiji TAEN
 * パラメータ修正
 *
 * @option   string   hide_folders   隠蔽するフォルダのマスク値
 *
 * 隠蔽したいフォルダをビットを立てて表現する。
 * 下位ビットから
 * ・ルート
 * ・受信箱
 * ・送信箱
 * ・下書き
 * ・ごみ箱
 * ・一般フォルダ
 * となる。
 *
 * hide_folders オプションが指定されている場合は hide_root_folder, hide_garbage_folder,
 * hide_special_folder のオプションは無視される。
 *
 * 例：
 *  hide_folders =  1   =>   ルートのみ隠される
 *  hide_folders = 49   =>   ルート、ごみ箱、一般フォルダが隠される
 */

function _grn_message_select_folders_internal(
    $folder_id,
    &$folder_tree,
    $selected_folder_id,
    $padding,
    $hide_special_folder,
    $hide_selected_folder,
    $parent_folder_id,
    $need_checkbox,
    $hide_folders,
    $mark
) {
    $return_string = '';

    require_once('message/resources.csp');
    $folder_type = $folder_tree['folder_type'];

    if (_grn_message_select_folders_getBit($hide_folders,
        $folder_tree['folder_type'])
    ) {
        return '';
    }

    $selected = "";
    if ($hide_selected_folder) {
        if ($selected_folder_id == $folder_id) {
            return $return_string;
        }

        if ($parent_folder_id == $folder_id) {
            $selected = " selected";
        }
    } else {
        if ($selected_folder_id == $folder_id) {
            $selected = " selected";
        }
    }

    if ($need_checkbox == '') {
        $return_string .= "<option value=\"" . htmlspecialchars($folder_id)
                          . "\"" . htmlspecialchars($selected) . ">" . $padding
                          . htmlspecialchars($mark)
                          . htmlspecialchars($folder_tree['folder_name'])
                          . "</option>\n";
    } else {
        $return_string .= $padding . htmlspecialchars($mark) . "<input id=\""
                          . htmlspecialchars($folder_id)
                          . "\" type=\"checkbox\" name=\"fid"
                          . htmlspecialchars($folder_id) . "\""
                          . htmlspecialchars(_grn_message_select_folders_internal2($folder_tree))
                          . "><label for=\"" . htmlspecialchars($folder_id)
                          . "\" onMouseOver='this.style.color=\"#ff0000\"' onMouseOut='this.style.color=\"\"'>"
                          . htmlspecialchars($folder_tree['folder_name'])
                          . "</label><br>\n";
    }

    if (array_key_exists('children', $folder_tree)) {
        $padding .= '&nbsp;';
        $mark = cb_msg('grn.message', 'select_folder_brach');
        $children = &$folder_tree['children'];
        foreach ($children as $id => $sub_tree) {
            $return_string .= _grn_message_select_folders_internal($id,
                $sub_tree, $selected_folder_id, $padding, $hide_special_folder,
                $hide_selected_folder, $parent_folder_id, $need_checkbox,
                $hide_folders, $mark);
        }
    }

    return $return_string;
}

function _grn_message_select_folders_internal2(& $folder_tree)
{
    $ret = '';
    if ($folder_tree['subscription_flag'] == '1') {
        $ret = ' checked';
    }

    return $ret;
}

function _grn_message_select_folders_getBit($str, $num)
{
    $mask = 0x01 << (int)$num;
    if (($str & $mask) == $mask) {
        return true;
    }

    return false;
}

function _grn_message_select_folders_setMask($str, $num)
{
    return $str | (0x01 << (int)$num);
}

function smarty_function_grn_message_select_folders($params, &$smarty)
{
    //-- function name
    $function_name = 'grn_message_select_folders';

    //-- parameters
    $select_name = @ $params['select_name'];
    $select_id = @ $params['select_id'];
    $selected_folder_id = @ $params['selected_folder_id'];
    $parent_folder_id = @ $params['parent_folder_id'];
    $need_checkbox = @ $params['need_checkbox'];
    $hide_selected_folder = @ $params['hide_selected_folder'];
    $onchange = @ $params['onchange'];
    $class = cb_at($params, 'class');

    $return_string = '';

    $hide_folders = @ $params['hide_folders'];
    if (is_null($hide_folders)) {
        $hide_folders = 0;
        if (@ $params['hide_root_folder']) {
            $hide_folders = _grn_message_select_folders_setMask($hide_folders,
                GRN_MESSAGE_ROOTFOLDER);
        }
        if (@ $params['hide_garbage_folder']) {
            $hide_folders = _grn_message_select_folders_setMask($hide_folders,
                GRN_MESSAGE_GARBAGEFOLDER);
        }
        if (@ $params['hide_special_folder']) {
            $hide_folders = _grn_message_select_folders_setMask($hide_folders,
                GRN_MESSAGE_RECEIVINGFOLDER);
            $hide_folders = _grn_message_select_folders_setMask($hide_folders,
                GRN_MESSAGE_SENDINGFOLDER);
            $hide_folders = _grn_message_select_folders_setMask($hide_folders,
                GRN_MESSAGE_DRAFTFOLDER);
            $hide_folders = _grn_message_select_folders_setMask($hide_folders,
                GRN_MESSAGE_GARBAGEFOLDER);
        }
    }

    $exception_value = @ $params['exception_value'];
    $exception_item = @ $params['exception_item'];
    $exception_value2 = @ $params['exception_value2'];
    $exception_item2 = @ $params['exception_item2'];

    //--
    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $login_user = $uum->getLoginUser();
    if ( ! $login_user) {
        return htmlspecialchars($function_name) . ': not logined';
    }

    require_once('message/folder_logic.csp');
    $folder_logic = new GRN_Message_FolderLogic();

    $folder_tree = [];
    $folder_logic->getFolderTree($login_user, 0, $folder_tree);
    if ($need_checkbox == '') {
        if ($onchange != '') {
            $onchange = " onchange=\"" . $onchange . "\"";
        }
        if ($select_id != '') {
            $select_id = " id=\"" . htmlspecialchars($select_id) . "\"";
        }

        $return_string = "<select" . ($class ? ' class="'
                                               . htmlspecialchars($class) . '"'
                : '') . " name=\"" . htmlspecialchars($select_name) . "\""
                         . $select_id . $onchange . ">\n";
    }

    if ( ! $exception_item == '') {
        if ($need_checkbox == '') {
            if ($exception_value == $select_id) {
                $selected_string = ' selected';
            } else {
                $selected_string = '';
            }
            $return_string .= "<option value="
                              . htmlspecialchars($exception_value)
                              . htmlspecialchars($selected_string) . ">"
                              . htmlspecialchars($exception_item)
                              . "</option>\n";
        }
    }

    reset($folder_tree);
    $root_folder = current($folder_tree);

    if ( ! _grn_message_select_folders_getBit($hide_folders,
        GRN_MESSAGE_ROOTFOLDER)
    ) {
        if (array_key_exists('root_caption', $params)) {
            $root_folder['folder_name']
                = htmlspecialchars($params['root_caption']);
        } else {
            $msg = cb_msg('grn.message',
                'root_name_decoration',
                ['root_name' => htmlspecialchars($root_folder['folder_name'])]);
            $root_folder['folder_name'] = $msg;
        }

        $folder_id = key($folder_tree);
        if ($need_checkbox == '') {
            $return_string .= "<option value=\"" . htmlspecialchars($folder_id)
                              . "\">" . $root_folder['folder_name']
                              . "</option>\n";
        } else {
            $return_string .= "<input id=\"" . htmlspecialchars($folder_id)
                              . "\" type=\"checkbox\" name=\"fid"
                              . htmlspecialchars($folder_id) . "\""
                              . htmlspecialchars(_grn_message_select_folders_internal2($root_folder))
                              . "><label for=\"" . htmlspecialchars($folder_id)
                              . "\" onMouseOver='this.style.color=\"#ff0000\"' onMouseOut='this.style.color=\"\"'>"
                              . $root_folder['folder_name'] . "</label>\n";
        }
    }

    $root_folder_children = $root_folder['children'];
    foreach ($root_folder_children as $folder_id => $folder_sub_tree) {
        $return_string .= _grn_message_select_folders_internal($folder_id,
            $folder_sub_tree, $selected_folder_id, "", $hide_special_folder,
            $hide_selected_folder, $parent_folder_id, $need_checkbox,
            $hide_folders, $mark);
    }
    if ($need_checkbox == '') {

        if ( ! $exception_item2 == '') {
            if ($exception_value2 == $selected) {
                $selected_string = ' selected';
            } else {
                $selected_string2 = '';
            }
            $return_string .= "<option value="
                              . htmlspecialchars($exception_value2)
                              . htmlspecialchars($selected_string2) . ">"
                              . htmlspecialchars($exception_item2)
                              . "</option>\n";
        }

        $return_string .= "</select>";
    }

    return $return_string;
}


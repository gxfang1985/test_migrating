<?php
/**
 * @name   grn_mail_select_folders
 * @description
 *   show <select> including folder <option> list or checkbox list
 *
 * @date     01/05/2005
 * @author   M.Oomori
 *
 * @param  string  select_name <select> tag's name
 * @param  string  selected_folder_id  the selected folder id
 *
 * @option   string  onchange   onchangeイベントハンドラ
 *
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
 *   {grn_mail_select_folders name="cid" selected_folder_id=5 hide_special_folder=1}
 *
 *
 * @date     2005.1
 * @author   Eiji TAEN
 * パラメータ修正
 *
 * @date     2005.02.04
 * @author   A.Ikeda
 *
 * @option   array   hide_folder_codes
 *
 */

function _grn_mail_select_folders_internal(
    & $mail_app,
    $folder_id,
    & $folder_tree,
    $account_id,
    $selected_folder_id,
    $padding,
    $hide_special_folder,
    $hide_selected_folder,
    $hide_normal_folder,
    $parent_folder_id,
    $need_checkbox,
    & $hide_folder_codes,
    $root_caption_key,
    $mark,
    $default_selected,
    $button_select,
    $three_pane
) {
    $return_string = '';
    $folder_code = $folder_tree['code'];

    if (strlen($folder_code) > 0) {
        // 特殊フォルダ
        if ($hide_special_folder
            || array_key_exists($folder_code, $hide_folder_codes)
        ) {
            return $return_string;
        }
    } else {
        // 一般フォルダ
        if ($hide_normal_folder) {
            return $return_string;
        }
    }

    if (strlen($folder_code) > 0) {
        if (($folder_code == GRN_MAIL_FOLDER_CODE_ROOT)
            && is_string($root_caption_key)
            && (strlen($root_caption_key) > 0)
        ) {
            $folder_name = cb_msg($mail_app->getModuleId(), $root_caption_key);
        } else {
            $folder_name = cb_msg($mail_app->getModuleId(), $folder_code);
        }
    } else {
        $folder_name = htmlspecialchars($folder_tree['name']);
    }

    $selected = "";
    if ($hide_selected_folder) {
        if ($selected_folder_id == $folder_id) {
            return $return_string;
        }

        if ($parent_folder_id == $folder_id && ! $default_selected) {
            $selected = " selected";
        }
    } else {
        if ($selected_folder_id == $folder_id && ! $default_selected) {
            $selected = " selected";
        }
    }

    if (is_null($need_checkbox) || ! $need_checkbox) {
        if ($button_select) {
            if ($folder_code === GRN_MAIL_FOLDER_CODE_TRASH) {
                $return_string .= "<li><a href='javascript:' onclick='GRN_MoveEmail_Util.move_email(\"none\")'>"
                                  . "---------------" . "</a></li>";
                $return_string .= "<li><a href='javascript:' onclick='GRN_MoveEmail_Util.move_email("
                                  . htmlspecialchars($folder_id) . ")'>"
                                  . $padding . $mark;
                if ($three_pane) {
                    $return_string .= '<span class="icon_trash_grn"></span>';
                }
                $return_string .= '<span class="vAlignMiddle-grn">'
                                  . $folder_name . "</span></a></li>";
            } else {
                $return_string .= "<li><a href='javascript:' onclick='GRN_MoveEmail_Util.move_email("
                                  . htmlspecialchars($folder_id) . ")'>"
                                  . $padding . $mark . $folder_name
                                  . "</a></li>";
            }
        } else {
            $return_string .= "<option value=\"" . htmlspecialchars($folder_id)
                              . "\"" . htmlspecialchars($selected) . ">"
                              . $padding . $mark . $folder_name . "</option>\n";
        }
    } else {
        $return_string .= $padding . $mark . "<input id=\""
                          . htmlspecialchars($folder_id)
                          . "\" type=\"checkbox\" name=\"fid" . $account_id
                          . "[]\" value=\"" . htmlspecialchars($folder_id)
                          . "\""
                          . htmlspecialchars(_grn_mail_select_folders_internal2($folder_tree))
                          . "><label for=\"" . htmlspecialchars($folder_id)
                          . "\" onMouseOver='this.style.color=\"#ff0000\"' onMouseOut='this.style.color=\"\"'>"
                          . $folder_name . "</label><br>\n";
    }

    if (array_key_exists('children', $folder_tree)) {
        $padding .= '&nbsp;';
        $mark = cb_msg('grn.mail', 'select_folder_brach');
        $children = &$folder_tree['children'];
        foreach (array_keys($children) as $id) {
            $sub_tree =& $children[$id];
            $return_string .= _grn_mail_select_folders_internal($mail_app, $id,
                $sub_tree, $account_id, $selected_folder_id, $padding,
                $hide_special_folder, $hide_selected_folder,
                $hide_normal_folder, $parent_folder_id, $need_checkbox,
                $hide_folder_codes, $root_caption_key, $mark, $default_selected,
                $button_select, $three_pane);
        }
    }

    return $return_string;
}

function _grn_mail_select_folders_internal2(& $folder_tree)
{
    $ret = '';
    if ($folder_tree['subscribed'] == '1') {
        $ret = ' checked';
    }

    return $ret;
}

function smarty_function_grn_mail_select_folders($params, &$smarty)
{
    //-- function name
    $function_name = 'grn_mail_select_folders';

    //-- parameters
    $select_name = @ $params['select_name'];
    $select_id = @ $params['select_id'];
    $account_id = @ $params['account_id'];
    $selected_folder_id = @ $params['selected_folder_id'];
    $parent_folder_id = @ $params['parent_folder_id'];
    $need_checkbox = @ $params['need_checkbox'];
    $hide_selected_folder = @ $params['hide_selected_folder'];
    $hide_special_folder = @ $params['hide_special_folder'];
    $hide_root_folder = @ $params['hide_root_folder'];
    $hide_garbage_folder = @ $params['hide_garbage_folder'];
    $hide_normal_folder = @ $params['hide_normal_folder'];
    $show_another_account = @ $params['show_another_account'];
    $root_caption_key = @ $params['root_caption_key'];
    $default_selected = @ $params['default_selected'];
    $button_select = @ $params['button_select'];
    $three_pane = @ $params['three_pane'];

    /*
        if( is_null( $account_id ) )
        {
            return '';
        }
    */

    require_once('mail/utility.csp');
    $utility = GRN_Mail_Utility::getInstance();
    $mail_app = $utility->getMailApp();
    $folder_logic = $utility->getFolderLogic();

    $hide_folder_codes = @ $params['hide_folder_codes'];
    if (is_null($hide_folder_codes)) {
        $hide_folder_codes = [];
    }

    // ルートを隠す
    if ( ! is_null($hide_root_folder) && $hide_root_folder) {
        $hide_folder_codes[GRN_MAIL_FOLDER_CODE_ROOT] = true;
    }

    // ごみ箱を隠す
    if ( ! is_null($hide_garbage_folder) && $hide_garbage_folder) {
        $hide_folder_codes[GRN_MAIL_FOLDER_CODE_TRASH] = true;
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

    $return_string = '';

    // onchange
    if (isset($params['onchange']) && (strlen($params['onchange']) > 0)) {
        $onchange_str = ' onchange="' . htmlspecialchars($params['onchange'])
                        . '"';
    } else {
        $onchange_str = '';
    }

    if (isset($params['class']) && (strlen($params['class']) > 0)) {
        $class_str = ' class="' . htmlspecialchars($params['class']) . '"';
    } else {
        $class_str = '';
    }

    if ($select_id != '') {
        $select_id = " id=\"" . htmlspecialchars($select_id) . "\"";
    }

    if (is_null($need_checkbox) || ! $need_checkbox) {
        if ($button_select) {
            if ($three_pane) {
                $return_string .= "<span class='menu_item_disable_grn'><span class='icon_move_grn'>"
                                  . htmlspecialchars($exception_item)
                                  . "</span><span class='arrow_down_small_icon_grn'></span></span><div class='mail-dropdownContents'><ul>";
            } else {
                $return_string .= "<a " . $select_id . "href='javascript:'>"
                                  . htmlspecialchars($exception_item) . "<span class='mail-arrowDownDisable-grn'></span></a>
                    <div class='mail-dropdownContents'><ul>";
            }
        } else {
            $return_string .= "<select name=\"" . htmlspecialchars($select_name)
                              . "\"" . $select_id . $onchange_str . $class_str
                              . ">\n";
        }
    }

    if ( ! is_null($exception_item) && ($exception_item != '')) {
        if (is_null($need_checkbox) || ! $need_checkbox) {
            if ( ! $button_select) {
                if ($exception_value == $selected) {
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
    }

    if ( ! is_null($account_id)) {
        $folder_tree = [];
        //$folder_logic->getFolderDataTree( $folder_tree, $login_user, $account_id, $parent_folder_id );
        $folder_logic->getFolderDataTree($folder_tree, $login_user, $account_id,
            null);
        reset($folder_tree);
        $root_id = key($folder_tree);
        $root_folder =& $folder_tree[$root_id];

        if ( ! array_key_exists(GRN_MAIL_FOLDER_CODE_ROOT,
            $hide_folder_codes)
        ) {
            // ルートフォルダ
            if (is_array($root_folder)
                && ( ! array_key_exists(GRN_MAIL_FOLDER_CODE_ROOT,
                    $hide_folder_codes))
            ) {
                if (is_string($root_caption_key)
                    && (strlen($root_caption_key) > 0)
                ) {
                    $root_name = cb_msg($mail_app->getModuleId(),
                        $root_caption_key);
                } else {
                    $root_name = cb_msg($mail_app->getModuleId(),
                        GRN_MAIL_FOLDER_CODE_ROOT);
                }

                $msg = cb_msg($mail_app->getModuleId(), 'root_name_decoration',
                    ['root_name' => $root_name]);
                if (is_null($need_checkbox) || ! $need_checkbox) {
                    if ($button_select) {
                        $return_string .= "<li><a href='javascript:' onclick='GRN_MoveEmail_Util.move_email("
                                          . htmlspecialchars($root_id) . ")'>"
                                          . $msg . "</a></li>";
                    } else {
                        $return_string .= "<option value=\""
                                          . htmlspecialchars($root_id) . "\">"
                                          . $msg . "</option>\n";
                    }
                } else {
                    $return_string .= "<input id=\""
                                      . htmlspecialchars($root_id)
                                      . "\" type=\"checkbox\" name=\"fid"
                                      . htmlspecialchars($account_id)
                                      . "[]\" value=\""
                                      . htmlspecialchars($root_id) . "\""
                                      . htmlspecialchars(_grn_mail_select_folders_internal2($root_folder))
                                      . "><label for=\""
                                      . htmlspecialchars($root_id)
                                      . "\" onMouseOver='this.style.color=\"#ff0000\"' onMouseOut='this.style.color=\"\"'>"
                                      . $msg . "</label>\n";
                }
            }
        }

        // ルート以下
        $mark = '';
        $root_folder_children = $root_folder['children'];
        foreach (array_keys($root_folder_children) as $folder_id) {
            $folder_sub_tree =& $root_folder_children[$folder_id];

            $return_string .= _grn_mail_select_folders_internal($mail_app,
                $folder_id, $folder_sub_tree, htmlspecialchars($account_id),
                $selected_folder_id, "", $hide_special_folder,
                $hide_selected_folder, $hide_normal_folder, $parent_folder_id,
                $need_checkbox, $hide_folder_codes, $root_caption_key, $mark,
                $default_selected, $button_select, $three_pane);
        }
    } else {
        if ($hide_special_folder) {
            return $return_string;
        }

        // アカウントIDが未指定の場合は特殊フォルダのみ表示
        $folder_codes = [
            GRN_MAIL_FOLDER_CODE_ROOT,
            GRN_MAIL_FOLDER_CODE_INBOX,
            GRN_MAIL_FOLDER_CODE_SENTBOX,
            GRN_MAIL_FOLDER_CODE_UNSENT,
            GRN_MAIL_FOLDER_CODE_TRASH
        ];

        foreach ($folder_codes as $folder_code) {
            if (array_key_exists($folder_code, $hide_folder_codes)
                || ($hide_root_folder
                    && ($folder_code == GRN_MAIL_FOLDER_CODE_ROOT))
                || ($hide_garbage_folder
                    && ($folder_code == GRN_MAIL_FOLDER_CODE_TRASH))
            ) {
                continue;
            }

            if (($folder_code == GRN_MAIL_FOLDER_CODE_ROOT)
                && is_string($root_caption_key)
                && (strlen($root_caption_key) > 0)
            ) {
                $folder_name = cb_msg($mail_app->getModuleId(),
                    $root_caption_key);
            } else {
                $folder_name = cb_msg($mail_app->getModuleId(), $folder_code);
            }

            $selected = "";
            if ($hide_selected_folder) {
                if ($selected_folder_id == $folder_code) {
                    continue;
                }

                if ($parent_folder_id == $folder_code) {
                    $selected = " selected";
                }
            } else {
                if ($selected_folder_id == $folder_code) {
                    $selected = " selected";
                }
            }

            if (strlen($return_string) == 0) {
                $return_string = "<select name=\""
                                 . htmlspecialchars($select_name) . "\""
                                 . $select_id . $onchange_str . ">\n";
            }

            if (is_null($need_checkbox) || ! $need_checkbox) {
                if ($button_select) {
                    if ($folder_code === GRN_MAIL_FOLDER_CODE_TRASH) {
                        $return_string .= "<li><a href='javascript:' onclick='GRN_MoveEmail_Util.move_email(\"none\")'>"
                                          . "---------------" . "</a></li>";
                        $return_string .= "<li><a href='javascript:' onclick='GRN_MoveEmail_Util.move_email("
                                          . htmlspecialchars($folder_code)
                                          . ")'>" . $padding
                                          . htmlspecialchars($mark);
                        if ($three_pane) {
                            $return_string .= '<span class="icon_trash_grn"></span>';
                        }
                        $return_string .= '<span class="vAlignMiddle-grn">'
                                          . $folder_name . "</span></a></li>";
                    } else {
                        $return_string .= "<li><a href='javascript:' onclick='GRN_MoveEmail_Util.move_email("
                                          . htmlspecialchars($folder_code)
                                          . ")'>" . $padding
                                          . htmlspecialchars($mark)
                                          . $folder_name . "</a></li>";
                    }
                } else {
                    $return_string .= "<option value=\""
                                      . htmlspecialchars($folder_code) . "\""
                                      . htmlspecialchars($selected) . ">"
                                      . $padding . htmlspecialchars($mark)
                                      . $folder_name . "</option>\n";
                }
            } else {
                $return_string .= "<input id=\""
                                  . htmlspecialchars($folder_code)
                                  . "\" type=\"checkbox\" name=\"fid"
                                  . htmlspecialchars($account_id)
                                  . "[]\" value=\""
                                  . htmlspecialchars($folder_code)
                                  . "\"><label for=\""
                                  . htmlspecialchars($folder_code)
                                  . "\" onMouseOver='this.style.color=\"#ff0000\"' onMouseOut='this.style.color=\"\"'>"
                                  . $folder_name . "</label><br>\n";
            }
        }
    }

    // 後処理
    if (is_null($need_checkbox) || ! $need_checkbox) {
        if ( ! is_null($exception_item2) && ($exception_item2 != '')) {
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

        if ( ! is_null(show_another_account) && $show_another_account) {
            if ($button_select) {
                require_once('fw/ui.csp');
                $browser = cb_ui_get_browser();

                if ($browser['type'] == 'msie') {
                    $reference = "#";
                } else {
                    $reference = "javascript:";
                }

                $return_string .= "<li><a href='javascript:' onclick='GRN_MoveEmail_Util.move_email(\"none\")'>"
                                  . "---------------" . "</a></li>";
                $another_title = cb_msg($mail_app->getModuleId(),
                    'move_another');
                $return_string .= "<li><a href='" . $reference
                                  . "' onclick='GRN_MoveEmail_Util.move_email(\"another\")'>"
                                  . $another_title . "</a></li>";
            } else {
                $return_string .= "<option value=\"\">" . "---------------"
                                  . "</option>\n";
                $another_title = cb_msg($mail_app->getModuleId(),
                    'move_another');
                $return_string .= "<option value=\"another_account\">"
                                  . $another_title . "</option>\n";
            }
        }

        if ($button_select) {
            $return_string .= "</ul></div></span>";
        } else {
            $return_string .= "</select>";
        }
    }

    return $return_string;
}


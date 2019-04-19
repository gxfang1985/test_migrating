<?php
/**
 * @name   grn_mail_folder_tree_mobile_api
 * @description
 *   show the all folder tree and mail list that existing in each folder of mail application
 *   only use for mobile api
 *
 * @date   2009/08/26
 * @author Loi Nguyen
 *
 * @param  string  account_id  the account_id selected
 *
 *  eg.)
 *   {grn_mail_folder_tree_mobile_api account_id=1}
 */

function _grn_mail_folder_tree_internal(
    & $login,
    & $folder_tree,
    $account_id,
    & $smarty
) {
    $folder_id = $folder_tree['id'];
    $folder_code = $folder_tree['code'];
    $folder_memo = $folder_tree['memo'];
    if (mb_strlen($folder_memo) > 0) {
        //remove invalid XML characters
        require_once('fw/string_util.csp');
        $folder_memo = cb_remove_invalid_xml_chars($folder_memo);
        $folder_memo = _normalize_characters(htmlspecialchars($folder_memo));
    }

    // 検索日時
    $start_ts = new CB_TimeStamp();
    $start_ts->unix_ts = time() - 60 * 60 * 24 * 7; // 一週間前以降を検索範囲とする。

    $folder_subscribed = $folder_tree['subscribed'] ? 'true' : 'false';
    require_once('cbpapi/mail_logic.csp');
    $mail_logic = GRN_CBPApi_Mail_Logic::getInstance();
    $mail_folder_list = $mail_logic->getMailDataListByAPI($login, $start_ts,
        null, [$folder_id]);
    switch ($folder_code) {
        case GRN_MAIL_FOLDER_CODE_ROOT:
            break;
        case GRN_MAIL_FOLDER_CODE_INBOX:
            $return_string .= '<account:inbox key="' . $folder_id . '"';
            if (strlen($folder_memo) > 0) {
                $return_string .= ' description="' . $folder_memo . '"';
            }
            $return_string .= ' subscribe="' . $folder_subscribed . '" >';
            if (is_array($mail_folder_list) && count($mail_folder_list) > 0) {
                foreach (array_keys($mail_folder_list) as $mail_id) {
                    $return_string .= '<account:mail id="' . $mail_id . ' "/>';
                }
            }
            $return_string .= ' </account:inbox>';
            break;
        case GRN_MAIL_FOLDER_CODE_SENTBOX:
            $return_string .= '<account:sent key="' . $folder_id . '"';
            if (strlen($folder_memo) > 0) {
                $return_string .= ' description="' . $folder_memo . '"';
            }
            $return_string .= ' subscribe="' . $folder_subscribed . '" >';
            if (is_array($mail_folder_list) && count($mail_folder_list) > 0) {
                foreach (array_keys($mail_folder_list) as $mail_id) {
                    $return_string .= '<account:mail id="' . $mail_id . ' "/>';
                }
            }
            $return_string .= ' </account:sent>';
            break;
        case GRN_MAIL_FOLDER_CODE_UNSENT:
            $return_string .= '<account:draft key="' . $folder_id . '"';
            if (strlen($folder_memo) > 0) {
                $return_string .= ' description="' . $folder_memo . '"';
            }
            $return_string .= ' subscribe="' . $folder_subscribed . '" >';
            if (is_array($mail_folder_list) && count($mail_folder_list) > 0) {
                foreach (array_keys($mail_folder_list) as $mail_id) {
                    $return_string .= '<account:mail id="' . $mail_id . ' "/>';
                }
            }
            $return_string .= ' </account:draft>';
            break;
        case GRN_MAIL_FOLDER_CODE_TRASH:
            $return_string .= '<account:trash key="' . $folder_id . '"';
            if (strlen($folder_memo) > 0) {
                $return_string .= ' description="' . $folder_memo . '"';
            }
            $return_string .= ' subscribe="' . $folder_subscribed . '" >';
            if (is_array($mail_folder_list) && count($mail_folder_list) > 0) {
                foreach (array_keys($mail_folder_list) as $mail_id) {
                    $return_string .= '<account:mail id="' . $mail_id . ' "/>';
                }
            }
            $return_string .= ' </account:trash>';
            break;
        default:
            $folder_name = $folder_tree['name'];
            if (mb_strlen($folder_name) > 0) {
                //remove invalid XML characters
                require_once('fw/string_util.csp');
                $folder_name = cb_remove_invalid_xml_chars($folder_name);
                $folder_name
                    = _normalize_characters(htmlspecialchars($folder_name));
            }
            $folder_order = $folder_tree['list_index'];
            $return_string .= '<account:folder name="' . $folder_name . '"';
            $return_string .= ' key="' . $folder_id . '"';
            if (strlen($folder_memo) > 0) {
                $return_string .= ' description="' . $folder_memo . '"';
            }
            $return_string .= ' subscribe="' . $folder_subscribed . '"';
            if (strlen($folder_order) > 0) {
                $return_string .= ' order="' . $folder_order . '" >';
            }
            if (is_array($mail_folder_list) && count($mail_folder_list) > 0) {
                foreach (array_keys($mail_folder_list) as $mail_id) {
                    $return_string .= '<account:mail id="' . $mail_id . ' "/>';
                }
            }
            if (array_key_exists('children', $folder_tree)) {
                $children = $folder_tree['children'];
                foreach ($children as $id => $sub_tree) {
                    $return_string .= _grn_mail_folder_tree_internal($login,
                        $sub_tree, $account_id, $smarty);
                }
            }
            $return_string .= ' </account:folder>';
            break;
    }

    return $return_string;
}

function smarty_function_grn_mail_folder_tree_mobile_api($params, &$smarty)
{
    //-- function name
    $function_name = 'grn_mail_folder_tree_mobile_api';

    //-- parameters
    $account_id = @ $params['account_id'];

    //--
    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $login_user = $uum->getLoginUser();
    if ( ! $login_user) {
        return htmlspecialchars($function_name) . ': not logined';
    }

    require_once('mail/utility.csp');
    $utility = GRN_Mail_Utility::getInstance();
    $personal_config = $utility->getPersonalConfig($login_user);
    $folder_logic = $utility->getFolderLogic();

    // ロジックからフォルダツリー取得
    $folder_tree = [];
    $folder_logic->getFolderDataTree($folder_tree, $login_user, $account_id,
        null, true, true);

    $return_string = '';
    reset($folder_tree);
    $root_folder = current($folder_tree);
    $root_folder_children = $root_folder['children'];
    foreach ($root_folder_children as $folder_id => $folder_sub_tree) {
        $return_string .= _grn_mail_folder_tree_internal($login_user,
            $folder_sub_tree, $account_id, $smarty);
    }

    return $return_string;
}


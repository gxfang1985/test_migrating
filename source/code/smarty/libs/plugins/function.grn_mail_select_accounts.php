<?php
/**
 * @name   grn_mail_select_accounts
 * @description
 *   show <select> including account <option> list or checkbox list
 *
 * @date   2005/02/18
 * @author A.Ikeda
 *
 * @param  string  select_name <select> tag's name
 * @param  string  selected_account_id  the selected folder id
 * @param  string  hide_disable_account if this parameter is set, hide disabled account
 * @param  string  need_checkbox if this parameter is set, use checkbox tag insted of select tag
 * @param          exception_value the value of the exception option
 * @param  string  exception_item  the display name of the exception option
 *
 *  eg.)
 *   {grn_mail_select_accounts name="user_account" selected_account_id=5 hide_disable_account=1}
 *
 */

function _grn_mail_select_accounts_internal(
    $select_name,
    $account_id,
    & $account_data,
    $padding,
    & $selected_account_ids,
    $hide_disable_account,
    $need_checkbox
) {
    $return_string = '';

    if ($hide_disable_account && $account_data['disabled']) {
        return $return_string;
    }

    if (is_null($account_name) || (strlen($account_name) == 0)) {
        $account_info =& $account_data['account_info'];
        $account_name = $account_info->email;
    }

    $account_name = htmlspecialchars($account_name);

    $selected = "";
    if (is_array($selected_account_ids)
        && (array_search($account_id, $selected_account_ids, false) !== false)
    ) {
        if (is_null($need_checkbox) || ! $need_checkbox) {
            $selected = " selected";
        } else {
            $selected = " checked";
        }
    }

    if (is_null($need_checkbox) || ! $need_checkbox) {
        $return_string .= "<option value=\"" . htmlspecialchars($account_id)
                          . "\"" . htmlspecialchars($selected) . ">"
                          . htmlspecialchars($padding)
                          . htmlspecialchars($account_name) . "</option>\n";
    } else {
        /*
                $return_string .= $padding . "<input id=\"" . $account_id . "\" type=\"checkbox\" name=\"fid" . $account_id . "\"" . _grn_mail_select_accounts_internal2( $account_data ) . "><label for=\"" . $account_id . "\" onMouseOver='this.style.color=\"#ff0000\"' onMouseOut='this.style.color=\"\"'>" . $account_name . "</label><br>\n";
        */
        $return_string .= htmlspecialchars($padding) . "<input id=\""
                          . htmlspecialchars($account_id)
                          . "\" type=\"checkbox\" name=\""
                          . htmlspecialchars($select_name) . "\" value=\""
                          . htmlspecialchars($account_id) . "\""
                          . htmlspecialchars($selected) . "><label for=\""
                          . htmlspecialchars($account_id)
                          . "\" onMouseOver='this.style.color=\"#ff0000\"' onMouseOut='this.style.color=\"\"'>"
                          . htmlspecialchars($account_name) . "</label><br>\n";
    }

    return $return_string;
}

/*
function _grn_mail_select_accounts_internal2( & $folder_tree )
{
    $ret = '';
    if( $folder_tree['subscription_flag'] == '1' )
    {
        $ret = ' checked';
    }

    return $ret;
}
*/

function smarty_function_grn_mail_select_accounts($params, &$smarty)
{
    //-- function name
    $function_name = 'grn_mail_select_accounts';

    //-- parameters
    $select_name = @ $params['select_name'];
    $selected_account_ids = @ $params['selected_account_ids'];
    $need_checkbox = @ $params['need_checkbox'];
    $hide_disable_account = @ $params['hide_disable_account'];
    $show_no_account_message = @ $params['show_no_account_message'];

    require_once('mail/utility.csp');
    $utility = GRN_Mail_Utility::getInstance();
    $system_config =& $utility->getSystemConfig();

    $exception_value = @ $params['exception_value'];
    $exception_item = @ $params['exception_item'];
    $exception_value2 = @ $params['exception_value2'];
    $exception_item2 = @ $params['exception_item2'];

    //--
    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $login_user = &$uum->getLoginUser();
    if ( ! $login_user) {
        //return $function_name . ': not logined';
        return '';
    }
    $personal_config =& $utility->getPersonalConfig($login_user);

    $account_list =& $system_config->getAccountDataList($login_user, false);
    if (is_array($account_list)) {
        if (is_null($need_checkbox) || ! $need_checkbox) {
            $return_string = "<select name=\"" . htmlspecialchars($select_name)
                             . "\">\n";
        }

        if ( ! $exception_item == '') {
            if (is_null($need_checkbox) || ! $need_checkbox) {
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

        // アカウントデータリスト
        foreach (array_keys($account_list) as $account_key) {
            $account_data =& $account_list[$account_key];

            // 受信可能かチェックする（ちと重い。。）
            if ( ! $personal_config->checkAccountForReceive($account_data['id'],
                $no_account, $no_server)
            ) {
                continue;
            }

            $return_string .= _grn_mail_select_accounts_internal($select_name,
                (string)$account_key, $account_data, "", $selected_account_ids,
                $hide_disable_account, $need_checkbox);


        }
    }

    // 後処理
    if (is_null($need_checkbox) || ! $need_checkbox) {

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

        $return_string .= "</select>\n";
    }

    if ((strlen($return_string) == 0) && ! is_null($show_no_account_message)
        && $show_no_account_message
    ) {
        // アカウントがない
        $mail_app =& $utility->getMailApp();
        $return_string = cb_msg($mail_app->getModuleId(), 'no_account_data');
    }

    return $return_string;
}


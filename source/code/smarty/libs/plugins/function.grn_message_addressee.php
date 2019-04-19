<?php

/**
 * Show user name.  If "uid" parameter indicates a valid user,
 * this will echo the current user name of that user.
 *
 * If "uid" is not specified or invalid, it will echo "name"
 * parameter as the (deleted) user name.
 *
 * @name   grn_user_name
 * @description show user name from user id with decoration
 *
 * @param  string  id          member id
 * @param  string  name        member name
 */


function smarty_function_grn_message_addressee($params, &$smarty)
{
    $t = new GRN_Smarty();

    // 必須チェック
    if ( ! array_key_exists('message', $params)) {
        return 'grn_message_addressee: missing message parameter';
    }
    $addressee_ids = [];
    foreach ($params['message']['addressee'] as $addressee) {
        if ( ! is_string($addressee['id']) || strlen($addressee['id']) === 0) {
            continue;
        }
        $addressee_ids[$addressee['id']] = $addressee;
    }

    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $login = $uum->getLoginUser();
    $login_id = $login->getOID();

    if (count($addressee_ids) > 0) {
        // サーバーから一括取得
        $users_info
            = GRN_ControllerUtil::getUserInfoToShowUserName(array_keys($addressee_ids),
            $login);
        $t->assign('users_info', $users_info);
    }

    $addressee_for_view = [];
    foreach ($params['message']['addressee'] as $addressee) {
        $addressee_for_view[] = [
            'name' => $addressee['name'],
            'uid'  => $addressee['id'],
        ];
    }

    $t->assign('message_addressee', $addressee_for_view);
    $t->assign('message_addressee_num', count($addressee_for_view));

    $addressee_ids = [];
    if (array_key_exists('delete_addressee', $params['message'])) {
        $delete_for_view
            = _smarty_function_grn_message_addressee_makeSpecificGroup('delete_addressee',
            $params['message']);
        $t->assign('message_delete_addressee', $delete_for_view);
        $t->assign('message_delete_addressee_num', count($delete_for_view));

    }
    if (array_key_exists('deleted_addressee', $params['message'])) {
        $deleted_for_view
            = _smarty_function_grn_message_addressee_makeSpecificGroup('deleted_addressee',
            $params['message']);
        $t->assign('message_deleted_addressee', $deleted_for_view);
        $t->assign('message_deleted_addressee_num', count($deleted_for_view));
    }

    return $t->fetch('message/_view_addressee.tpl');
}

function _smarty_function_grn_message_addressee_makeSpecificGroup(
    $specific_group_name,
    $message
) {
    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');

    // get user informations in bulk.
    $addressee_ids = [];
    foreach ($message[$specific_group_name] as $addressee) {
        if ( ! is_string($addressee['id']) || strlen($addressee['id']) === 0) {
            continue;
        }
        $addressee_ids[$addressee['id']] = $addressee;
    }
    if (count($addressee_ids) > 0) {
        // サーバーから一括取得
        $users_info = $uum->getUsersInfo(array_keys($addressee_ids),
            ['col_display_name', 'col_valid']);
    }

    $ret_group = [];
    foreach ($message[$specific_group_name] as $addressee) {
        $user_id = $addressee['id'];
        $user_name = '';

        $invalid = false;
        $nolink = false;
        $login_user = false;
        // 名前の生成
        if ( ! is_string($user_id) || strlen($user_id) === 0) {
            $nolink = true;
            $user_name = $addressee['name'];
        } elseif (array_key_exists($user_id, $users_info)) {
            $user_name = $users_info[$user_id]['col_display_name'];
            if ($login_id == $user_id) {
                $login_user = true;
            }
            if ( ! is_null($users_info[$user_id]['col_valid'])) {
                $invalid = true;
            }
        } else {
            $nolink = true;
            $user_name = $addressee['name'];
        }

        $ret_group[] = [
            'name'    => $user_name,
            'login'   => $login_user,
            'nolink'  => $nolink,
            'id'      => $user_id,
            'invalid' => $invalid
        ];
    }

    return $ret_group;
}


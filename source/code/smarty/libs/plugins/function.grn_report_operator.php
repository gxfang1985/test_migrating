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
 * @param  string  id          operator id
 * @param  string  name        operator name
 */


function smarty_function_grn_report_operator($params, &$smarty)
{
    $t = new GRN_Smarty();

    // 必須チェック
    if ( ! array_key_exists('operators', $params)) {
        return 'grn_report_operator: missing operators parameter';
    }

    $operator_set = null;
    if (array_key_exists('operator_set', $params)) {
        $operator_set = $params['operator_set'];
        $t->assign('operator_set', $operator_set);
    }

    $addressee_ids = [];
    if (is_array($params['operators'])) {
        foreach ($params['operators'] as $addressee) {
            if ( ! is_string($addressee) || strlen($addressee) === 0) {
                continue;
            }
            $addressee_ids[] = $addressee;
        }
    }

    if ( ! $operator_set) {
        $addressee_ids = [];
    }

    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $login = $uum->getLoginUser();

    if (count($addressee_ids) > 0) {
        // サーバーから一括取得
        $users_info
            = GRN_ControllerUtil::getUserInfoToShowUserName($addressee_ids,
            $login);
        $t->assign('users_info', $users_info);
    }

    $addressee_for_view = [];

    foreach ($addressee_ids as $addressee) {
        if ( ! array_key_exists($addressee, $users_info)) {
            $deleted_users_info = $uum->getUserInfo($addressee,
                ['col_display_name'], 0, 1, null, true);
            $users_info[$addressee] = $deleted_users_info;
        }
        $addressee_for_view[$addressee] = [
            'id'           => $addressee,
            'display_name' => $users_info[$addressee]['col_display_name']
        ];
    }
    $t->assign('report_addressee', $addressee_for_view);
    $t->assign('report_addressee_num', count($addressee_for_view));

    return $t->fetch('report/_view_operator.tpl');
}




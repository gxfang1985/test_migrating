<?php

/**
 * Make operator add parts.
 * Please use always in conjunction with function.grn_member_add.php.
 *
 * @param $params  string name
 *                 string form_name
 *                 string app_id
 *                 string operators_list_id
 *                 string operators_candidate_list_id
 *                 string member_add_name
 *                 array  selected_operators
 *                 array  candidate_operators
 * @param $smarty
 *
 * @return string
 */
function smarty_function_grn_operator_add($params, &$smarty)
{
    $t = new GRN_Smarty();

    $name = cb_at($params, 'name');
    $t->assign('name', $name);
    $form_name = cb_at($params, 'form_name', cb_get_pagename());
    $t->assign('form_name', $form_name);
    $app_id = cb_at($params, 'app_id');
    $t->assign('app_id', $app_id);

    $operators_list_id = cb_at($params, 'operators_list_id');
    $t->assign('operators_list_id', $operators_list_id);
    $operators_candidate_list_id = cb_at($params,
        'operators_candidate_list_id');
    $t->assign('operators_candidate_list_id', $operators_candidate_list_id);
    $member_add_name_list = explode(':', cb_at($params, 'member_add_names'));
    $t->assign('member_add_names', $member_add_name_list);

    $selected_operators = cb_at($params, 'selected_operators', []);
    // No filtering users.
    $t->assign('selected_operators', $selected_operators);

    $candidate_operators = cb_at($params, 'candidate_operators', []);
    // Filtering users.
    $candidate_operators
        = _smarty_function_grn_operator_add_filter_users($candidate_operators,
        $app_id);
    $t->assign('candidate_operators', $candidate_operators);

    require_once('fw/ui.csp');
    $browser = cb_ui_get_browser();
    $t->assign('os', $browser['os_type']);

    return $t->fetch('grn/operator_add.tpl');
}

/**
 * @param $operators
 * @param $app_id
 *
 * @return mixed
 */
function _smarty_function_grn_operator_add_filter_users($operators, $app_id)
{
    $target_ids = array_keys($operators);
    $target_ids
        = \grn\grn\access\service\AppAccess::filterUserIdsInternalAccessByAppId($target_ids,
        $app_id);
    $target_ids = array_flip($target_ids);

    foreach ($operators as $id => $operator) {
        if ($operator[\grn\grn\MemberLogic::MEMBER_TYPE]
            !== \grn\grn\MemberLogic::TYPE_USER
        ) {
            continue;
        }

        if ( ! isset($target_ids[$id])) {
            unset($operators[$id]);
        }
    }

    return $operators;
}

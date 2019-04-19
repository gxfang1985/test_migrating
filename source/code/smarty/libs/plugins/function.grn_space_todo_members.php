<?php

use grn\space\data\collection\TodoUserCollection;
use grn\space\common\logic\SpaceMemberLogic;

/**
 * @param array      $params ['name']            This parts name.
 *                           $params['todo_user_array'] ToDo users array.
 * @param GRN_Smarty $smarty
 *
 * @return mixed
 */
function smarty_function_grn_space_todo_members(array $params, &$smarty)
{
    // Input
    $name = cb_at($params, 'name', 'todo_users');
    $todo_user_array = cb_at($params, 'todo_user_array',
        [
            SpaceMemberLogic::SPACE_MEMBERS    => [],
            SpaceMemberLogic::NO_SPACE_MEMBERS => []
        ]);

    /** @var \grn\space\common\data\collection\SpaceMemberCollection $todo_members */
    $todo_members = $todo_user_array[SpaceMemberLogic::SPACE_MEMBERS];
    $smarty->assign('name', $name);
    $smarty->assign('todo_members', $todo_members);
    $smarty->assign('todo_members_subtotal_text',
        _grn_space_todo_members_get_subtotal_text($todo_members->count()));

    /** @var \grn\space\common\data\collection\SpaceMemberCollection $todo_members_no_space_members */
    $todo_members_no_space_members
        = $todo_user_array[SpaceMemberLogic::NO_SPACE_MEMBERS];
    $smarty->assign('name_no_space_members', $name . '_no_space_members');
    $smarty->assign('todo_members_no_space_members',
        $todo_members_no_space_members);
    $smarty->assign('todo_members_no_space_members_subtotal_text',
        _grn_space_todo_members_get_subtotal_text($todo_members_no_space_members->count()));

    return $smarty->fetch('/space/application/todo/todo_members.tpl');

}

/**
 * @param $member_count
 *
 * @return string
 */
function _grn_space_todo_members_get_subtotal_text($member_count)
{
    $result = cb_msg("grn.space", "grn.space.member_subtotal.user",
        ["count" => $member_count]);
    if ($member_count > 1) {
        // Only when language setting is English
        $result .= cb_msg("grn.space",
            "grn.space.member_subtotal.plural.suffix");
    }

    return $result;
}

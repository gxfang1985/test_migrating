<?php
/**
 * @param array      $params ['name']     This parts name.
 * @param array      $params ['space_id'] Space id.
 * @param GRN_Smarty $smarty
 *
 * @return mixed
 */
function smarty_function_grn_space_todo_out_of_members(array $params, &$smarty)
{
    // Input
    $name = cb_at($params, 'name', 'space_out_of_members');
    $space_id = cb_at($params, 'space_id');

    $smarty->assign('name', $name);
    $smarty->assign('space_id', $space_id);

    return $smarty->fetch('/space/application/todo/todo_out_of_members.tpl');
}

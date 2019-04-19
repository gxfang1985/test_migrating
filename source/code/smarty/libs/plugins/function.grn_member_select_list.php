<?php
/**
 * @name               grn_member_select_list
 * @description   Make member select list
 *
 * @param       array  $params
 * @param       Smarty $smarty
 *
 * @options       array  $selected_item_options
 * @options       string  $list_name
 * @options       string $position
 * @options       boolean $select_all
 * @options       boolean $view_detail
 * @options       string $form_name
 * @options       boolean $is_calendar
 * @options       string $div_class_name
 *
 * @return mixed|string|void
 */
function smarty_function_grn_member_select_list($params, &$smarty)
{
    $t = new GRN_Smarty();
    $selected_item_options = cb_at($params, 'selected_item_options', []);
    $list_name = cb_at($params, 'list_name');
    if ( ! is_array($selected_item_options)) {
        return '';
    }
    $div_class_name = cb_at($params, 'div_class_name', '');

    $select_all = cb_at($params, 'select_all', false);
    $view_detail = cb_at($params, 'view_detail', false);
    $form_name = cb_at($params, 'form_name', '');
    $is_calendar = cb_at($params, 'is_calendar', false);
    $style = cb_at($params, 'style', '');

    $t->assign('selected_item_options', $selected_item_options);
    $t->assign('list_name_suffix', $list_name);
    $t->assign('list_name', 'selectlist_' . $list_name);
    $t->assign('div_class_name', $div_class_name);
    $t->assign('select_all', $select_all);
    $t->assign('view_detail', $view_detail);
    $t->assign('form_name', $form_name);
    $t->assign('is_calendar', $is_calendar);
    $t->assign('style', $style);

    $t->assign('is_foreign_key_public', cb_lwc_uum()->isForeignKeyPublic());

    return $t->fetch('grn/member_select_list.tpl');
}

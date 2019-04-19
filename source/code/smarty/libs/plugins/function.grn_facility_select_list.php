<?php
/**
 * @name               grn_facility_select_list
 * @description   Make facility select list
 *
 * @param       array  $params
 * @param       Smarty $smarty
 *
 * @options       array  $selected_item_options
 * @options       string  $list_name
 * @options       string $div_class_name
 * @options       boolean $select_all
 * @options       boolean $view_detail
 * @options       string $style
 * @options       boolean $show_affiliation_group
 * @options       boolean $is_view_facility_path
 *
 * @return mixed|string|void
 */
function smarty_function_grn_facility_select_list($params, &$smarty)
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
    $style = cb_at($params, 'style');
    $show_affiliation_group = cb_at($params, 'show_affiliation_group');
    $is_view_facility_path = cb_at($params, 'is_view_facility_path', false);

    $t->assign('selected_item_options', $selected_item_options);
    $t->assign('list_name', 'selectlist_' . $list_name);
    $t->assign('div_class_name', $div_class_name);
    $t->assign('select_all', $select_all);
    $t->assign('view_detail', $view_detail);
    $t->assign('style', $style);
    $t->assign('is_view_facility_path', $is_view_facility_path);
    $t->assign('show_affiliation_group', $show_affiliation_group);

    return $t->fetch('grn/facility_select_list.tpl');
}

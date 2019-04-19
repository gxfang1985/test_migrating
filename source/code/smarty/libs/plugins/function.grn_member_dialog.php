<?php
/**
 * @param string link_name
 * @param string anchor_id
 * @param string dialog_tpl_name
 * @param number want_page
 *
 * @return string
 */
function smarty_function_grn_member_dialog(array $params, &$smarty)
{

    // Parameters
    $dialog_link_tpl_name = cb_at($params, 'dialog_link_tpl_name', '');
    if (empty($dialog_link_tpl_name)) {
        cb_throw_error(E_GRN_MISSING_MANDATORY);
    }
    $link_name = cb_at($params, 'link_name', '');
    if (empty($link_name)) {
        cb_throw_error(E_GRN_MISSING_MANDATORY);
    }
    $anchor_id = cb_at($params, 'anchor_id', '');
    if (empty($anchor_id)) {
        cb_throw_error(E_GRN_MISSING_MANDATORY);
    }
    $want_page = cb_at($params, 'want_page', 1);
    $dialog_name = cb_at($params, 'dialog_name', 'span-member-dialog');

    // Smarty assign
    $t = new GRN_Smarty();
    $t->assign('link_name', $link_name);
    $t->assign('anchor_id', $anchor_id);
    $t->assign('want_page', $want_page);
    $t->assign('dialog_name', $dialog_name);

    return $t->fetch($dialog_link_tpl_name);

}


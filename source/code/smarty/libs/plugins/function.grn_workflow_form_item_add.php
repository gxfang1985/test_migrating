<?php
/**
 * @name   grn_workflow_item_add
 * @description フォーム項目選択の表示
 *
 * @date        2012/05/22
 * @author      K.Kajita
 */
function smarty_function_grn_workflow_form_item_add($params, &$smarty)
{
    $t = new GRN_Smarty();

    $form_id = 0;
    if (array_key_exists('form_id', $params)
        && strlen($params['form_id']) > 0
    ) {
        $form_id = $params['form_id'];
    }

    $item_util = GRN_Workflow_Item_Controller_Utility::getInstance();
    //get custome item List
    $item_list = $item_util->getSimpleListView($form_id);
    $t->assign('item_list', $item_list);

    //item index
    $item_index = [
        "no",
        "creator",
        "creator_login_name",
        "creat_date",
        "form_name",
        "status"
    ];
    foreach ($item_list as $item) {
        $item_index[] = $item['iid'];
    }
    $item_index[] = "path_step";
    $item_index = join(':', $item_index);
    $t->assign('item_index', $item_index);

    return $t->fetch('workflow/form_item_add.tpl');
}


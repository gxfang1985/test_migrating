<?php
/**
 * @name   grn_workflow_include_item
 *  申請項目のインクルード
 *
 * @date   2006/01/10
 * @author Yuichi,Nakamura
 * @option int    category_id              //申請カテゴリID
 * @option int    form_id                  //申請フォームID
 * @option int    folder_id                //申請フォルダID
 * @option int    petition_id              //申請ID
 * @option array  params                   //その他のID
 * @option string serected_foreign_key     //申請項目コード
 * @option array  item                     //申請項目（データ）
 * @option string display                  //表示タイプ
 *                                          view/view-system/view-operation/view-confirm:表示画面（ ユーザー/システム/運用管理/申請の作成(内容の確認) ）
 *                                          input/input-system/input-operation:入力画面（ユーザー/システム/運用管理）
 *                                          add/add-system/add-operation:追加画面（ユーザー/システム/運用管理）
 *                                          modify/modify-system/modify-operation:変更画面（ユーザー/システム/運用管理）
 *                                          detail/detail-system/detail-operation:詳細画面（ユーザー/システム/運用管理）
 *
 *  記述例
 *  <pre>{grn_workflow_include_item category=$category_id, form_id=$form_id, item=$item, selected_foreign_key=$selected_foreign_key display='add-system'}</pre>
 */

function smarty_function_grn_workflow_include_item($params, &$smarty)
{
    $function_name = "grn_workflow_include_item";

    //Get Display Parameters
    $display = @ $params['display'];
    $disabled = @ $params['disabled'];

    //Check Necessary Parameter and Value
    $nessecary_list = ['display'];
    foreach ($nessecary_list as $nessecary) {
        if ( ! array_key_exists($nessecary, $params)) {
            return htmlspecialchars($function_name) . ": missing "
                   . htmlspecialchars($nessecary) . " parameter";
        }
        if ($params[$nessecary] === '' || is_null($params[$nessecary])) {
            return htmlspecialchars($function_name) . ": missing "
                   . htmlspecialchars($nessecary) . " parameter";
        }
    }

    //Get ID Parameters
    $assign_id_list = [
        'category_id',
        'form_id',
        'folder_id',
        'petition_id',
        'params'
    ];
    foreach ($assign_id_list as $assign_id) {
        if (array_key_exists($assign_id, $params)) {
            if ($assign_id == 'params') {
                $smarty->assign($params[$assign_id]);
            } else {
                $smarty->assign($assign_id, $params[$assign_id]);
            }
        }
    }

    // Include Portlet File
    $t =& $smarty;
    require_once('workflow/item_resources.csp');
    switch ($display) {
        case 'input':
        case 'input-system':
        case 'input-operation':
        case 'view':
        case 'view-confirm':
        case 'view-system':
        case 'view-operation':
            //Check Arguments
            if ($params['item'] === '' || is_null($params['item'])) {
                return htmlspecialchars($function_name)
                       . ": missing item parameter";
            }

            //Get Item Utility
            $selected_foreign_key = $params['item']['foreign_key'];
            if ($selected_foreign_key == GRN_WORKFLOW_BLANK_SPACE_ITEM) {
                return "<td><div id='js_customization_item_"
                       . $params['item']['code'] . "'></div> </td>";
            }
            $item_util = grn_workflow_get_item_util($selected_foreign_key);

            //Include Input and View Template
            $t->assign('item', $params['item']);
            if (isset($params['is_mobile'])) {
                $t->assign('is_mobile', $params['is_mobile']);
            }
            if (strlen($item_util->_view_template) != 0) {
                include(cb_basedir() . '/code/doc_root/'
                        . $item_util->_view_template);
            }
            break;
        case 'add':
        case 'add-system':
        case 'add-operation':
            //Check Arguments
            if ($params['selected_foreign_key'] === ''
                || is_null($params['selected_foreign_key'])
            ) {
                return htmlspecialchars($function_name)
                       . ": missing selected_foreign_key parameter";
            }

            //Get Item Utility
            $selected_foreign_key = $params['selected_foreign_key'];
            $item_util
                = grn_workflow_get_item_util($selected_foreign_key);

            //Include Setting Template
            include(cb_basedir() . '/code/doc_root/'
                    . $item_util->_set_template);
            break;
        case 'modify':
        case 'modify-system':
        case 'modify-operation':
            //Check Arguments
            if ($params['item'] === '' || is_null($params['item'])) {
                return htmlspecialchars($function_name)
                       . ": missing item parameter";
            }

            //Get Item Utility
            $selected_foreign_key = $params['selected_foreign_key'];
            if ( ! $selected_foreign_key) {
                $selected_foreign_key = $params['item']['foreign_key'];
            }
            $item_util =& grn_workflow_get_item_util($selected_foreign_key);

            //Include Setting Template
            $t->assign('item', $params['item']);
            include(cb_basedir() . '/code/doc_root/'
                    . $item_util->_set_template);
            break;
        case 'detail':
        case 'detail-system':
        case 'detail-operation':
            //Check Arguments
            if ($params['item'] === '' || is_null($params['item'])) {
                return htmlspecialchars($function_name)
                       . ": missing item parameter";
            }

            //Get Item Utility
            $selected_foreign_key = $params['item']['foreign_key'];
            $item_util
                =& grn_workflow_get_item_util($selected_foreign_key);

            //Include Detail Template
            $t->assign('disabled', $disabled);
            $t->assign('item', $params['item']);
            if ($display == 'detail-system') {
                $t->assign('config_id', 'system');
                $t->assign('modify_page', 'workflow/system/formlayout_modify');
                $t->assign('delete_page', 'workflow/system/formlayout_delete');
            } elseif ($display == 'detail-operation') {
                $t->assign('config_id', '');
                $t->assign('modify_page',
                    'workflow/operation/formlayout_modify');
                $t->assign('delete_page',
                    'workflow/operation/formlayout_delete');
            } else {
                $t->assign('config_id', '');
                $t->assign('modify_page', 'workflow/formlayout_modify');
                $t->assign('delete_page', 'workflow/formlayout_delete');
            }
            include(cb_basedir() . '/code/doc_root/'
                    . $item_util->_detail_template);
            break;
        default:
            return htmlspecialchars($function_name) . ": invalid template name";
            break;
    }
}


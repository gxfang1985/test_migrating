<?php

/**
 * @name   grn_workflow_include_item
 *  報告項目のインクルード
 *
 * @date   2009/09/24
 * @option int    category_id              //報告カテゴリID
 * @option int    form_id                  //報告フォームID
 * @option int    report_id                //報告ID
 * @option array  params                   //その他のID
 * @option string selected_data_type       //報告項目コード
 * @option array  item                     //報告項目（データ）
 * @option string display                  //表示タイプ
 *                                          view/view-system/view-operation/view-confirm:表示画面（ ユーザー/システム/運用管理/報告の作成(内容の確認) ）
 *                                          input/input-system/input-operation:入力画面（ユーザー/システム/運用管理）
 *                                          add/add-system/add-operation:追加画面（ユーザー/システム/運用管理）
 *                                          modify/modify-system/modify-operation:変更画面（ユーザー/システム/運用管理）
 *                                          detail/detail-system/detail-operation:詳細画面（ユーザー/システム/運用管理）
 *
 *  記述例
 *  <pre>{grn_report_include_item category=$category_id, form_id=$form_id, item=$item, selected_data_type=$selected_data_type display='add-system'}</pre>
 */

function smarty_function_grn_report_include_item($params, &$smarty)
{
    $function_name = "grn_report_include_item";

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
    $assign_id_list = ['category_id', 'form_id', 'report_id', 'params'];
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
    require_once('report/item_resources.csp');
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
            $selected_data_type = $params['item']['data_type'];
            $item_util = grn_report_get_item_util($selected_data_type);

            //Include Input and View Template
            $t->assign('item', $params['item']);
            include(cb_basedir() . '/code/doc_root/'
                    . $item_util->_view_template);
            break;
        case 'add':
        case 'add-system':
        case 'add-operation':
            //Check Arguments
            if ($params['selected_data_type'] === ''
                || is_null($params['selected_data_type'])
            ) {
                return htmlspecialchars($function_name)
                       . ": missing selected_data_type parameter";
            }

            //Get Item Utility
            $selected_data_type = $params['selected_data_type'];
            $item_util = grn_report_get_item_util($selected_data_type);

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
            $selected_data_type = $params['selected_data_type'];
            if ( ! $selected_data_type) {
                $selected_data_type = $params['item']['data_type'];
            }
            $item_util =& grn_report_get_item_util($selected_data_type);

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
            $selected_data_type = $params['item']['data_type'];
            $item_util
                =& grn_report_get_item_util($selected_data_type);

            //Include Detail Template
            $t->assign('disabled', $disabled);
            $t->assign('item', $params['item']);
            if ($display == 'detail-system') {
                $t->assign('config_id', 'system');
                $t->assign('modify_page', 'report/system/formlayout_modify');
                $t->assign('delete_page', 'report/system/formlayout_delete');
            } elseif ($display == 'detail-operation') {
                $t->assign('config_id', '');
                $t->assign('modify_page', 'report/operation/formlayout_modify');
                $t->assign('delete_page', 'report/operation/formlayout_delete');
            } else {
                $t->assign('config_id', '');
                $t->assign('modify_page', 'report/formlayout_modify');
                $t->assign('delete_page', 'report/formlayout_delete');
            }
            include(cb_basedir() . '/code/doc_root/'
                    . $item_util->_detail_template);
            break;
        default:
            return htmlspecialchars($function_name) . ": invalid template name";
            break;
    }
}


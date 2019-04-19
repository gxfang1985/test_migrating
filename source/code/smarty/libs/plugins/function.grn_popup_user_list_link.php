<?php

/**
 * @param array      $params
 * @param GRN_Smarty $smarty
 *
 * @name         grn_popup_user_list_link
 * @description ユーザー一覧ポップアップ画面へのリンク表示
 *
 * @option      string caption           リンクに表示する文字列
 * @option      string form_name         選択完了後のデータ移行先フォーム名（デフォルトは現在のページ名）
 * @option      boolean system_display   システム設定で使用する（デフォルトはFALSE）
 * @option      string function_name     ポップアップ画面を呼び出す関数名（デフォルトはpopupUserList）
 * @return mixed
 */
function smarty_function_grn_popup_user_list_link($params, & $smarty)
{
    $caption = '';
    if (array_key_exists('caption', $params)
        && strlen($params['caption']) > 0
    ) {
        $caption = $params['caption'];
    }
    $system_display = false;
    if (array_key_exists('system_display', $params)
        && $params['system_display']
    ) {
        $system_display = true;
    }
    $var_CID = 'CID[]';
    if (array_key_exists('var_CID', $params) && $params['var_CID']) {
        $var_CID = $params['var_CID'];
    }
    $duplication = false;
    if (array_key_exists('duplication', $params) && $params['duplication']) {
        $duplication = $params['duplication'];
    }
    $function_name = 'popupUserList';
    if (array_key_exists('function_name', $params)
        && strlen($params['function_name']) > 0
    ) {
        $function_name = $params['function_name'];
    }
    $list_name = cb_at($params, 'list_name');
    if ($list_name) {
        $function_name .= "_" . $list_name;
    }
    $is_button = cb_at($params, 'is_button', true);

    $popup_user_list_link = 'grn/popup_user_list';
    if ($smarty->isSystem()) {
        $popup_user_list_link = 'grn/system/popup_user_list';
    } elseif ($smarty->isOperation()) {
        $popup_user_list_link = 'grn/operation/popup_user_list';
    }

    $t = new GRN_Smarty();
    $t->assign('caption', $caption);
    $t->assign('system_display', $system_display ? '1' : '0');
    $t->assign('var_CID', $var_CID);
    $t->assign('duplication', $duplication);
    $t->assign('popup_function_name', $function_name);
    $t->assign('popup_user_list_link', $popup_user_list_link);
    $t->assign('list_name', $list_name);
    $t->assign('is_button', $is_button);

    if (array_key_exists('module', $params) && strlen($params['module']) > 0) {
        $module = $params['module'];
        $t->assign('module', $module);
    }

    if (array_key_exists('form_name', $params)
        && strlen($params['form_name']) > 0
    ) {
        $form_name = $params['form_name'];
        $t->assign('form_name', $form_name);
    }

    return $t->fetch('grn/popup_user_list_link.tpl');
}



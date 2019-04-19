<?php

/**
 * @name grn_popup_user_select_link
 * @description ユーザー選択ポップアップ画面へのリンク表示
 *
 * @param string caption           リンクに表示する文字列
 * @param boolean no_multiple      単数選択（デフォルトはFALSE）
 * @param string form_name         選択完了後のデータ移行先フォーム名（デフォルトは現在のページ名）
 * @param string select_name       選択完了後のデータ移行先セレクトボックス名（デフォルトは"sUID[]"）
 * @param boolean system           システム設定で使用する（デフォルトはFALSE）
 * @param boolean system_display   システム設定で使用する（デフォルトはFALSE）
 * @param boolean include_org      選択対象に組織も含める（デフォルトはFALSE）
 * @param boolean send_cgi_parameter
 *                                  特定ページで使用
 *                                  自動的に単数選択となる（デフォルトはFALSE）
 *
 * @option      array access_plugin     アクセス制限のためのプラグインドライバ名とドライバのメソッドに引数として渡す連想配列
 *                                  $access_plugin = array( 'name' => $plugin_name,
 *                                                          'params' => $plugin_params );
 * @option      string  plugin_session_name pluginデータの格納されるセッションオブジェクト名(default:ページ名)
 * @option      string  plugin_data_name    pluginデータの格納されるデータ名(default:'access_plugin')
 * @option      array extension_items   追加アイテムデータ
 *                                  $extension_items = array( 'caption' => $caption,
 *                                                            'prefix' => $prefix,
 *                                                            'data' => $data );
 * @option      string  item_session_name 追加アイテムデータの格納されるセッションオブジェクト名(default:ページ名)
 * @option      string  item_data_name    追加アイテムデータの格納されるデータ名(default:'extension_items')
 * @option      string  app_id            呼び出し元アプリケーションID
 *                                    複数ユーザー選択で選択したデータを保持するSessionのキー
 * @option      string  return_page        戻り先ページ
 * @option      string  plid              ポートレットID
 * @option      string require_role_tab   ロール選択ができるかどうか
 * @option      string is_calendar        組織予定かどうか
 * @option      string show_group_role    一覧に組織とロールをアイコン付きで表示できるかどうか
 * @option      bool  disable_link
 * @option      string require_dynamic_roles   Dynamic roles can be selected
 * @option      string require_administrator_role   Administrator role can be selected
 * @option      string ajax_url           Return Ajax to get selected list
 * @option      string selected_tid       Selected target id list
 */
function smarty_function_grn_popup_user_select_link($params, &$smarty)
{
    $caption = '';
    if (array_key_exists('caption', $params)
        && strlen($params['caption']) > 0
    ) {
        $caption = $params['caption'];
    }
    $form_name = cb_get_pagename();
    if (array_key_exists('form_name', $params)
        && strlen($params['form_name']) > 0
    ) {
        $form_name = $params['form_name'];
    }
    $select_name = 'sUID[]';
    if (array_key_exists('select_name', $params)
        && strlen($params['select_name']) > 0
    ) {
        $select_name = $params['select_name'];
    }
    $system = false;
    if (array_key_exists('system', $params) && $params['system']) {
        $system = true;
    }
    $system_display = false;
    if (array_key_exists('system_display', $params)
        && $params['system_display']
    ) {
        $system_display = true;
    }
    $include_org = false;
    if (array_key_exists('include_org', $params) && $params['include_org']) {
        $include_org = true;
    }
    $no_multiple = false;
    if (array_key_exists('no_multiple', $params) && $params['no_multiple']) {
        $no_multiple = true;
    }
    $send_cgi_parameter = false;
    if (array_key_exists('send_cgi_parameter', $params)
        && $params['send_cgi_parameter']
    ) {
        $send_cgi_parameter = true;
        $no_multiple = true;
    }
    $app_id = 'grn.common';
    if (array_key_exists('app_id', $params) && $params['app_id']) {
        $app_id = $params['app_id'];
    }
    $return_page = '';
    if (array_key_exists('return_page', $params) && $params['return_page']) {
        $return_page = $params['return_page'];
    }
    $multi_apply = false;
    if (array_key_exists('multi_apply', $params) && $params['multi_apply']) {
        $multi_apply = true;
    }
    $plid = null;
    if (array_key_exists('plid', $params) && $params['plid']) {
        $plid = $params['plid'];
    }
    $module = null;
    if (array_key_exists('module', $params) && $params['module']) {
        $module = $params['module'];
    }

    $popup_url = 'grn/popup_user_select';
    if (cb_at($params, 'use_new_ui', false)) {
        $popup_url = 'grn/popup_member_select';
    }
    $require_role_tab = cb_at($params, 'require_role_tab', '0');
    $require_administrator_role = cb_at($params, 'require_administrator_role',
        '0');
    $require_dynamic_roles = cb_at($params, 'require_dynamic_roles', '0');
    $width = cb_at($params, 'width', '');
    $height = cb_at($params, 'height', '');
    $is_calendar = cb_at($params, 'is_calendar', '0');
    $show_group_role = cb_at($params, 'show_group_role', '1');

    $url_params = [];

    $plugin_session_name = cb_get_pagename();
    if (array_key_exists('plugin_session_name', $params)
        && strlen($params['plugin_session_name']) > 0
    ) {
        $plugin_session_name = $params['plugin_session_name'];
    }
    $plugin_data_name = 'access_plugin';
    if (array_key_exists('plugin_data_name', $params)
        && strlen($params['plugin_data_name']) > 0
    ) {
        $plugin_data_name = $params['plugin_data_name'];
    }
    if (array_key_exists('access_plugin', $params)
        && is_array($params['access_plugin'])
        && array_key_exists('name', $params['access_plugin'])
        && array_key_exists('params', $params['access_plugin'])
    ) {
        require_once('fw/session_manager.csp');
        $sm = CB_SessionManager::getInstance();
        $session = $sm->getSession($plugin_session_name);
        $session->set($plugin_data_name, $params['access_plugin']);
        $url_params['plugin_session_name'] = $plugin_session_name;
        $url_params['plugin_data_name'] = $plugin_data_name;
    }

    $item_session_name = cb_get_pagename();
    if (array_key_exists('item_session_name', $params)
        && strlen($params['item_session_name']) > 0
    ) {
        $item_session_name = $params['item_session_name'];
    }
    $item_data_name = 'extension_items';
    if (array_key_exists('item_data_name', $params)
        && strlen($params['item_data_name']) > 0
    ) {
        $item_data_name = $params['item_data_name'];
    }
    if (array_key_exists('extension_items', $params)
        && is_array($params['extension_items'])
        && array_key_exists('caption', $params['extension_items'])
        && array_key_exists('prefix', $params['extension_items'])
        && array_key_exists('data', $params['extension_items'])
    ) {
        require_once('fw/session_manager.csp');
        $sm = CB_SessionManager::getInstance();
        $session =& $sm->getSession($item_session_name);
        $session->set($item_data_name, $params['extension_items']);
        $url_params['item_session_name'] = $item_session_name;
        $url_params['item_data_name'] = $item_data_name;
    }

    $ajax_url = '';
    if (array_key_exists('ajax_url', $params)
        && strlen($params['ajax_url']) > 0
    ) {
        $ajax_url = $params['ajax_url'];
    }
    $url_params['ajax_url'] = $ajax_url;

    $selected_tid = '';
    if (array_key_exists('selected_tid', $params)
        && strlen($params['selected_tid']) > 0
    ) {
        $selected_tid = $params['selected_tid'];
    }
    $url_params['selected_tid'] = $selected_tid;

    $url_params['form_name'] = $form_name;
    $url_params['select_name'] = $select_name;
    $url_params['app_id'] = $app_id;
    $url_params['return_page'] = $return_page;
    $url_params['plid'] = $plid;
    if ($system) {
        $url_params['system'] = '1';
    } else {
        $url_params['system'] = '0';
    }
    if ($include_org) {
        $url_params['include_org'] = '1';
    } else {
        $url_params['include_org'] = '0';
    }
    if ($system_display) {
        $url_params['system_display'] = '1';
    } else {
        $url_params['system_display'] = '0';
    }
    if ($no_multiple) {
        $url_params['no_multiple'] = '1';
    } else {
        $url_params['no_multiple'] = '0';
    }
    if ($send_cgi_parameter) {
        $url_params['send_cgi_parameter'] = '1';
    } else {
        $url_params['send_cgi_parameter'] = '0';
    }
    if ($multi_apply) {
        $url_params['multi_apply'] = '1';
    } else {
        $url_params['multi_apply'] = '0';
    }
    if ($require_role_tab) {
        $url_params['require_role_tab'] = '1';
    } else {
        $url_params['require_role_tab'] = '0';
    }
    if ($is_calendar) {
        $url_params['is_calendar'] = '1';
    } else {
        $url_params['is_calendar'] = '0';
    }
    if ($show_group_role) {
        $url_params['show_group_role'] = '1';
    } else {
        $url_params['show_group_role'] = '0';
    }
    if ($require_dynamic_roles) {
        $url_params['require_dynamic_roles'] = '1';
    } else {
        $url_params['require_dynamic_roles'] = '0';
    }
    if ($require_administrator_role) {
        $url_params['require_administrator_role'] = '1';
    } else {
        $url_params['require_administrator_role'] = '0';
    }

    // disable link
    $disable_link = array_key_exists('disable_link', $params)
        ? $params['disable_link'] : false; //default enable

    $t = new GRN_Smarty();
    $t->assign('caption', $caption);
    $t->assign('url_params', $url_params);
    $t->assign('disable_link', $disable_link);
    $t->assign('module', $module);
    $t->assign('popup_url', $popup_url);
    $t->assign('width', $width);
    $t->assign('height', $height);

    return $t->fetch('grn/popup_user_select_link.tpl');
}



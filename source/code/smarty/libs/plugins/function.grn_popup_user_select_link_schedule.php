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
 */
function smarty_function_grn_popup_user_select_link_schedule($params, &$smarty)
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
        $session =& $sm->getSession($plugin_session_name);
        $session->set($plugin_data_name, $params['access_plugin']);
        $url_params['plugin_session_name'] = $plugin_session_name;
        $url_params['plugin_data_name'] = $plugin_data_name;
    }

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

    $t = new GRN_Smarty();
    $t->assign('caption', $caption);
    $t->assign('url_params', $url_params);

    return $t->fetch('grn/popup_user_select_link_schedule.tpl');
}



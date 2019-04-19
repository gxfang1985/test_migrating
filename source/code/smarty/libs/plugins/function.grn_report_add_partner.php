<?php

use \grn\grn\access\service\AppAccess;

/**
 * @name   grn_user_add
 * @description ユーザー一覧の表示
 *
 * @date        2005/01/28
 * @author      SHIMADA Kunihiko
 *
 * @param  string  form_name         formタグのname属性
 *
 * @option      string  sUID              選択されたユーザーリストのselectタグのname属性(default:sUID[])
 * @option      string  CGID              選択候補グループリストのselectタグのname属性(default:CGID)
 * @option      string  CID               選択候補ユーザーリストのselectタグのname属性(default:CID[])
 * @option      array   selected_users    初期選択済みユーザー表示リスト
 *                                    キーはoptionのvalue,値はoptionのtext
 * @option      array   access_plugin     アクセス制限のためのプラグインドライバ名とドライバのメソッドに引数として渡す連想配列
 *                                    $access_plugin = array( 'name' => $plugin_name,
 *                                                          'params' => $plugin_params );
 * @option      string  plugin_session_name pluginデータの格納されるセッションオブジェクト名(default:ページ名)
 * @option      string  plugin_data_name    pluginデータの格納されるデータ名(default:'access_plugin')
 * @option      boolean include_org      「組織図から選択する」にて開く画面の組織選択タブの有無(default:FALSE)
 * @option      boolean org_direct        組織をそのままメンバーとして追加する
 */
function smarty_function_grn_report_add_partner($params, &$smarty)
{
    require_once('grn/uum_util.csp');

    $t = new GRN_Smarty();

    // 引数取得(フォーム名、セレクトボックス名)
    $form_name = cb_get_pagename();
    if (array_key_exists('form_name', $params)
        && strlen($params['form_name']) > 0
    ) {
        $form_name = $params['form_name'];
    }
    $sUID = 'sUID[]';
    if (array_key_exists('sUID', $params) && strlen($params['sUID']) > 0) {
        $sUID = $params['sUID'];
    }
    $CGID = 'CGID';
    if (array_key_exists('CGID', $params) && strlen($params['CGID']) > 0) {
        $CGID = $params['CGID'];
    }
    $CID = 'CID[]';
    if (array_key_exists('CID', $params) && strlen($params['CID']) > 0) {
        $CID = $params['CID'];
    }
    $t->assign('form_name', $form_name);
    $t->assign('sUID', $sUID);
    $t->assign('CGID', $CGID);
    $t->assign('CID', $CID);

    // 引数取得(不必須パラメタ)
    if (array_key_exists('partners', $params)) {
        $t->assign('partners', $params['partners']);
    }

    require_once('fw/ui.csp');
    $browser = cb_ui_get_browser();
    $t->assign('os', $browser['os_type']);

    //Assign Address Availability
    require_once('report/address_util.csp');
    $address_available = GRN_ReportAddressUtil::isAddressAvailable();
    $shared_book_available = GRN_ReportAddressUtil::isSharedBookAvailable();
    $t->assign('address_available',
        $address_available && $shared_book_available);
    $t->assign('address_available_for_external',
        AppAccess::isAppAvailableExternalAccess('address'));
    //GTM-529 tv
    if (array_key_exists('path_mode', $params)) {
        $t->assign('path_mode', $params['path_mode']);
    } else {
        $t->assign('path_mode', "report/ajax/address_index");
    }

    if (array_key_exists('path_mode_get_address', $params)) {
        $t->assign('path_mode_get_address', $params['path_mode_get_address']);
    } else {
        $t->assign('path_mode_get_address', "report/ajax/get_addresses");
    }
    //end GTM-529 tv
    $t->assign('input', GRN_REPORT_INPUT);

    return $t->fetch('report/_add_partner.tpl');
}



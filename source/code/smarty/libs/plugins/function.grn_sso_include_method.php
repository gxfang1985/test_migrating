<?php

/**
 * @name    grn_include_method
 *  SSO方法のインクルード
 *
 * @date    2004/11/10
 * @author  Yuichi,Nakamura
 * @option  string  method    方法データ
 * @option  string  display 表示タイプ （add-system:システム設定追加画面/modify-system：システム設定編集画面
 *                                        add-personal:個人設定追加画面/modify-personal個人設定編集画面）
 *  <pre>{grn_sso_include_method method=$login_method display=login identifier=$identifier}</pre>
 */

function smarty_function_grn_sso_include_method($params, &$smarty)
{
    $function_name = "grn_sso_include_method";

    // Check Necessary Parameter and Value
    if ( ! array_key_exists('method', $params)) {
        return htmlspecialchars($function_name) . ": missing method parameter";
    }
    if ($params['method'] === '' || is_null($params['method'])) {
        return htmlspecialchars($function_name) . ": missing method parameter";
    }
    if ( ! array_key_exists('display', $params)) {
        return htmlspecialchars($function_name) . ": missing display parameter";
    }
    if ($params['display'] === '' || is_null($params['display'])) {
        return htmlspecialchars($function_name) . ": missing display parameter";
    }

    //Get Parameters
    $method = $params['method'];
    $display = $params['display'];
    if (array_key_exists('identifier', $params)) {
        $identifier = $params['identifier'];
    }
    if (array_key_exists('sso_link', $params)) {
        $sso_link = $params['sso_link'];
    }

    // Load Driver
    $driver = null;
    if (mb_strpos($method['driver_type'], GRN_SSO) !== false) {
        require_once('grn/sso.csp');
        $sso_service = GRN_SSO_Service::getInstance();
        $driver =& $sso_service->getSSODriver($method['driver_type']);
    }

    // Include Driver Template File
    $page = $driver->getPage($display);
    if ($page) {
        include(cb_basedir() . '/code/doc_root/' . $page);
    } else {
        assert('FALSE');
    }
}


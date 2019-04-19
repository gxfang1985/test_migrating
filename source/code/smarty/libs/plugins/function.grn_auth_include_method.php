<?php

/**
 * @name    grn_include_method
 *   ログイン/認証/ユーザー/SSO方法のインクルード
 *
 * @date    2004/11/10
 * @author  Yuichi,Nakamura
 * @option  string  method    方法データ
 * @option  string  display 表示タイプ （login:ログイン画面/add-system:システム設定追加画面/modify-system：システム設定編集画面
 *                                        add-personal:個人設定追加画面/modify-personal個人設定編集画面）
 *  <pre>{grn_auth_include_method method=$login_method display=login}</pre>
 */

function smarty_function_grn_auth_include_method($params, &$smarty)
{
    $function_name = "grn_auth_include_method";

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

    // Get Parameters
    $method = $params['method'];
    $display = $params['display'];

    // Load Driver
    require_once('grn/sso.csp');
    $driver = null;
    if (mb_strpos($method['driver_type'], GRN_AUTH_LOGIN) !== false) {
        require_once('grn/authentication.csp');
        $authentication_service = GRN_Authentication_Service::getInstance();
        $driver
            =& $authentication_service->getLoginDriver($method['driver_type']);
    }
    if (mb_strpos($method['driver_type'], GRN_AUTH_AUTHENTICATE) !== false) {
        require_once('grn/authentication.csp');
        $authentication_service = GRN_Authentication_Service::getInstance();
        $driver
            = $authentication_service->getAuthenticateDriver($method['driver_type']);
    }
    if (mb_strpos($method['driver_type'], GRN_AUTH_REPOSITORY) !== false) {
        require_once('grn/authentication.csp');
        $authentication_service = GRN_Authentication_Service::getInstance();
        $driver
            =& $authentication_service->getRepositoryDriver($method['driver_type']);
    }

    // Include Driver Template File
    $page = $driver->getPage($display);
    if ( ! $page) {
        cb_throw_error();
    }

    include(cb_basedir() . '/code/doc_root/' . $page);
}


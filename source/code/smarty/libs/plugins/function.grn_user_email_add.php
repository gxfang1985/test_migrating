<?php

function smarty_function_grn_user_email_add($params, &$smarty)
{
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
    $duplication = false;
    if (array_key_exists('duplication', $params)
        && strlen($params['duplication']) > 0
    ) {
        $duplication = $params['duplication'];
    }
    $skip = false;
    if (array_key_exists('skip', $params) && 0 < strlen($params['skip'])) {
        $skip = $params['skip'];
    }
    $order_by = true;
    if (array_key_exists('order_by', $params)) {
        $order_by = $params['order_by'];
    }
    if (array_key_exists('no_escape', $params)) {
        $t->assign('no_escape', true);
    }
    $mygroup_id = null;
    if (array_key_exists('mygroup_id', $params)) {
        $mygroup_id = $params['mygroup_id'];
    }

    $browser = cb_ui_get_browser();
    //get client OS
    $os = '';
    if (array_key_exists('os_type', $browser)) {
        $os = $browser['os_type'];
    }

    $t->assign('form_name', $form_name);
    $t->assign('sUID', $sUID);
    $t->assign('CGID', $CGID);
    $t->assign('CID', $CID);
    $t->assign('duplication', $duplication);
    $t->assign('order_by', $order_by);
    $t->assign('mygroup_id', $mygroup_id);
    $t->assign('os', $os);

    if (array_key_exists('selected_address_users', $params)) {
        $t->assign('selected_address_users', $params['selected_address_users']);
    }

    // --

    require_once('address/application.csp');
    $app_locator = GRN_ApplicationLocator::instance();
    /** @var GRN_Address_Application $app */
    $app = $app_locator->getInstance(GRN_ADDRESS_APPLICATION_ID);
    $book_manager =& $app->getBookManager();

    global $G_container_base;
    /** @var GRN_Uum $uum */
    $uum = $G_container_base->getInstance('uum');
    $login =& $uum->getLoginUser();
    $login_id = $login->getOID();

    require_once('address/config.csp');
    $config_manager = GRN_Address_ConfigManager::getInstance();
    $system_config =& $config_manager->getSystemConfig();
    $personal_config =& $config_manager->getPersonalConfig($login);

    // 使用権限を取得する
    require_once('address/access.csp');
    $access_manager = GRN_Address_AccessManager::getInstance();
    if ( ! ($row =& $access_manager->getAbstractData(GRN_ADDRESS_AVAILABLE))) {
        assert('FALSE');
    }

    // ダイナミックロールを取得する
    $dynamic_roles = $uum->listGrantedRoles();

    // 使用権限を評価する
    $authorities = ['private_address', 'shared_address'];
    $security_model = $access_manager->getSecurityModel($row);
    $access = $access_manager->evaluateAccess($row, $login,
        $dynamic_roles, $authorities, $security_model);

    // 個人アドレス帳の使用権限を評価する
    $authorities = ['private_address'];
    $access_for_view['private_address']
        = $access_manager->isAllowedAccess($access, $authorities,
        $security_model);

    // 共有アドレス帳の使用権限を評価する
    $authorities = ['shared_address'];
    $access_for_view['shared_address']
        = $access_manager->isAllowedAccess($access, $authorities,
        $security_model);

    // load shared books
    $books = [];
    $books_for_view = [];
    $allow_books = [];
    $accesses = [];
    require_once('address/view_util.csp');
    $view_util = GRN_Address_ViewUtil::getInstance();
    if ($access_for_view['shared_address']) {
        // 共有アドレスブック一覧を取得する
        $books = $book_manager->listSharedAddressBooks();

        if (0 < count($books)) {
            // 共有アドレスブック一覧の閲覧権限を評価する
            $rows = [];
            foreach (array_keys($books) as $book_id) {
                $rows[$book_id] =& $books[$book_id]->getRow();
            }
            $authorities = ['browse', 'editing', 'operation'];
            $accesses = $access_manager->evaluateAccesses($rows, $login,
                $dynamic_roles, $authorities);

            $authorities = ['browse'];
            foreach ($accesses as $book_id => $access) {
                $row =& $rows[$book_id];
                $security_model = $access_manager->getSecurityModel($row);
                if ($access_manager->isAllowedAccess($accesses[$book_id],
                    $authorities, $security_model)
                ) {
                    $allow_books[$book_id] =& $row;
                }
            }

            // 共有アドレスブック情報一覧を取得する
            $books_for_view = $view_util->listBooks($books, $allow_books);
        }
    }

    // create books-options
    $books_options = [];
    foreach ($books_for_view as $book_id => $item) {
        $books_options[] = [
            'value' => 'sharedbook:' . $book_id,
            'type'  => 'sharedbook',
            'name'  => $item['display_name']
        ];
    }

    if ($access_for_view['private_address']) {
        $books_options[] = [
            'value' => 'privatebook',
            'type'  => 'privatebook',
            'name'  => cb_msg('grn.common', 'user_email_add_private_book')
        ];
    }

    // load book items
    // - shared book
    $item_options = [];
    foreach ($books as $book) {
        $book_id = $book->getOID();
        if (array_key_exists($book_id, $allow_books)) {
            $book_items = $book->listDatasFast(0, -1);
            $item_options["sharedbook:$book_id"] = [];
            foreach ($book_items as $key => $item) {
                $item_options["sharedbook:$book_id"][] = [
                    'value' => $item['_id'],
                    'type'  => 'sharedbook',
                    'name'  => $item['subject'],
                    'email' => $item['email_address']
                ];
            }
        }
    }
    // - private book
    if ($access_for_view['private_address']) {
        $prv_book =& $book_manager->getPrivateAddressBookByUserId($login_id);

        $prv_book_items = [];
        if ($prv_book) {
            $prv_book_items = $prv_book->listDatasFast(0, -1);
        }

        $item_options["privatebook"] = [];
        foreach ($prv_book_items as $key => $item) {
            $item_options["privatebook"][] = [
                'value' => $item['_id'],
                'type'  => 'privatebook',
                'name'  => $item['subject'],
                'email' => $item['email_address']
            ];
        }
    }

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
    $access_plugin = null;
    if (array_key_exists('access_plugin', $params)
        && is_array($params['access_plugin'])
        && array_key_exists('name', $params['access_plugin'])
        && array_key_exists('params', $params['access_plugin'])
    ) {
        $access_plugin = $params['access_plugin'];
        require_once('fw/session_manager.csp');
        $sm = CB_SessionManager::getInstance();
        $session =& $sm->getSession($plugin_session_name);
        $session->set($plugin_data_name, $access_plugin);
        $t->assign('access_plugin', $access_plugin);
        $t->assign('plugin_session_name', $plugin_session_name);
        $t->assign('plugin_data_name', $plugin_data_name);
    }

    // create selected items options
    $selected_item_options = [];
    if (count($item_options) > 0) {
        $keys = array_keys($item_options);
        $selected_item_options = $item_options[$keys[0]];
    }

    $t->assign('books_options', $books_options);
    $t->assign('item_options', $item_options);
    $t->assign('selected_item_options', $selected_item_options);

    $url_param_names = ['plugin_data_name', 'plugin_session_name'];
    $url_params = [];
    foreach ($url_param_names as $url_param_name) {
        $url_params[$url_param_name] = $$url_param_name;
    }
    $t->assign('url_params', $url_params);


    return $t->fetch('grn/user_email_add.tpl');
}


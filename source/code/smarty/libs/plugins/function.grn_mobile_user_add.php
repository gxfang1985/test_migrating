<?php

/**
 * @name   grn_user_add_for_mobile
 *
 * @date   2013/12/13
 * @author Nguyen Huynh Long
 */
function smarty_function_grn_mobile_user_add($params, &$smarty)
{
    require_once('grn/uum_util.csp');
    require_once("grn/controller.csp");

    $t = new GRN_Smarty();

    // 引数取得(フォーム名、セレクトボックス名)
    $form_name = cb_get_pagename();
    if (array_key_exists('form_name', $params)
        && strlen($params['form_name']) > 0
    ) {
        $form_name = $params['form_name'];
    }
    $app_id = '';
    if (array_key_exists('app_id', $params)) {
        $app_id = $params['app_id'];
    }
    $sUID = 'sUID[]';
    if (array_key_exists('sUID', $params) && strlen($params['sUID']) > 0) {
        $sUID = $params['sUID'];
    }

    if (array_key_exists('element_id', $params)) {
        $t->assign('element_id', $params['element_id']);
    }
    if (array_key_exists('associate_id', $params)) {
        $t->assign('associate_id', $params['associate_id']);
    }
    if (array_key_exists('upper_page', $params)) {
        $t->assign('upper_page', $params['upper_page']);
    }
    if (array_key_exists('upper_page', $params)) {
        $t->assign('currnet_page_name', $params['currnet_page_name']);
    }

    $t->assign('form_name', $form_name);
    $t->assign('app_id', $app_id);
    $t->assign('sUID', $sUID);

    // 引数取得(不必須パラメタ)
    $selected_users = '';
    if (array_key_exists('selected_users', $params)) {
        $selected_users = $params['selected_users'];
    } else {
        $selected_users = json_encode([], 31);
    }
    $t->assign('selected_users', $selected_users);

    // 引数取得(アクセス権プラグイン)
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
    $plugin = null;
    $plugin_param = [];
    if (array_key_exists('access_plugin', $params)
        && is_array($params['access_plugin'])
        && array_key_exists('name', $params['access_plugin'])
        && array_key_exists('params', $params['access_plugin'])
    ) {
        $access_plugin = $params['access_plugin'];
        require_once('fw/session_manager.csp');
        $sm = CB_SessionManager::getInstance();
        $session = $sm->getSession($plugin_session_name);
        $session->set($plugin_data_name, $access_plugin);
        $t->assign('access_plugin_encoded',
            base64_encode(serialize($access_plugin)));
        $t->assign('access_plugin', $access_plugin);
        $t->assign('plugin_session_name', $plugin_session_name);
        $t->assign('plugin_data_name', $plugin_data_name);
        $loader = new CB_PluginLoader('grn.common.user.select');
        $plugin = $loader->loadDriver($params['access_plugin']['name']);
        $plugin_param = $params['access_plugin']['params'];
    }

    // 引数取得(bool)
    $include_org = false;
    if (array_key_exists('include_org', $params) && $params['include_org']) {
        $include_org = true;
    }
    $t->assign('include_org', $include_org);

    $isCalendar = false;
    if (isset($params["isCalendar"]) && $params["isCalendar"]) {
        $isCalendar = true;
    }
    $t->assign('isCalendar', $isCalendar);

    $isAllowedRole = false;
    if (isset($params["isAllowedRole"]) && $params["isAllowedRole"]) {
        $isAllowedRole = true;
    }
    $t->assign('isAllowedRole', $isAllowedRole);
    $include_role = false;
    if (isset($params["include_role"]) && $params["include_role"]) {
        $include_role = true;
    }
    $t->assign('include_role', $include_role);
    $popup_include_role = false;
    if ($isAllowedRole && $include_role) {
        $popup_include_role = true;
    }
    $t->assign('popup_include_role', $popup_include_role);

    if (isset($params["show_group_role"])) {
        $show_group_role = $params["show_group_role"];
    } else {
        // default is true
        $show_group_role = true;
    }
    $t->assign('show_group_role', $show_group_role);

    // uum
    global $G_container_base;
    /** @var $uum \GRN_Uum */
    $uum = $G_container_base->getInstance('uum');
    $login = $uum->getLoginUser();
    $login_id = $login->getOID();

    $category_options = [];
    $item_options = [];


    require_once('grn/ui.csp');
    $manager = GRN_UIConfigManager::getInstance();
    $config = $manager->getUserConfig($login);

    if ($config->getMyGroupPosition() == 'upper') {
        // Myグループ
        _smarty_function_grn_user_add_getMyGroups($login, $plugin,
            $plugin_param, $category_options, $item_options);

        // よく利用する組織
        _smarty_function_grn_user_add_getOftenusedGroups($login, $plugin,
            $plugin_param, $category_options, $item_options);
    } else {
        // よく利用する組織
        _smarty_function_grn_user_add_getOftenusedGroups($login, $plugin,
            $plugin_param, $category_options, $item_options);

        // Myグループ
        _smarty_function_grn_user_add_getMyGroups($login, $plugin,
            $plugin_param, $category_options, $item_options);
    }


    // 優先する組織
    // 削除フラグチェックを行う必要がないので、第2引数に TRUE を渡す。
    $primary_group = $uum->getUserPrimaryGroupInfo($login_id, true);
    $primary_group_id = '';
    $primary_group_name = '';
    if ($primary_group !== false) {
        $isPermission = true;

        if ($plugin) {
            //アクセス権
            $ret
                = $plugin->evalGroups([$primary_group['_id'] => $primary_group],
                $plugin_param);
            if (count($ret) <= 0) {
                $isPermission = false;
            }
        }

        if ($isPermission) {
            $primary_group_id = $primary_group['_id'];
            $group_id = $primary_group_id;
            $primary_group_name = $primary_group['col_name'];
            $category_options[] = [
                'value' => "g$group_id",
                'type'  => 2,
                'name'  => $primary_group_name
            ];
            $item_options["g$group_id"] = [];
        }
    }

    // 所属する組織
    // 削除フラグチェックを行う必要がないので、第2引数に TRUE を渡す。
    $usergroups = $uum->getUserGroupsInfo($login_id, true);
    if ($plugin) {
        //アクセス権
        $usergroups = $plugin->evalGroups($usergroups, $plugin_param);
    }
    foreach ($usergroups as $group) {
        $group_id = $group['_id'];
        $group_name = $group['col_name'];
        if ($primary_group_id == $group_id) {
            continue;
        }
        $category_options[] = [
            'value' => "g$group_id",
            'type'  => 3,
            'name'  => $group_name
        ];
        $item_options["g$group_id"] = [];
    }


    //最近選択した組織
    _smarty_function_grn_user_add_getGroupHistory($login, $plugin,
        $plugin_param, $category_options, $item_options);

    //最近選択したユーザー
    $category_options[] = [
        'value' => "frequent",
        'type'  => 5
    ];
    $item_options['frequent'] = [];

    $item_options_keys = array_keys($item_options);
    $type = $item_options_keys[0]{0};

    if ($type == 'f') {
        $frequentusers_id = $uum->getFrequentUsersId($login->getOID());
        if ($plugin) {
            //アクセス権
            $frequentusers_id = $plugin->evalUsers($frequentusers_id,
                $plugin_param);
        }
        if ( ! is_array($frequentusers_id) || count($frequentusers_id) == 0) {
            // no frequent users, remove category option 'frequent'
            for ($i = 0; $i < count($category_options); $i++) {
                if (strcmp($category_options[$i]['value'], 'frequent') === 0) {
                    unset($category_options[$i]);
                    break;
                }
            }
        }
    }


    $t->assign('category_option_disabled', count($category_options) == 0);
    $t->assign('skip', $skip);

    $category_menu = [];
    foreach ($category_options as $option) {
        switch ($option['type']) {
            case 1:
                $menu = [
                    'value' => $option['value'],
                    'title' => $option['name'] . cb_msg('grn.grn',
                            'GRN_GRN-813') . cb_msg('grn.grn', 'GRN_GRN-814')
                ];
                break;
            case 2:
                $menu = [
                    'value' => $option['value'],
                    'title' => $option['name'] . cb_msg('grn.grn',
                            'GRN_GRN-815')
                ];
                break;
            case 3:
                $menu = [
                    'value' => $option['value'],
                    'title' => $option['name'] . cb_msg('grn.grn',
                            'GRN_GRN-816')
                ];
                break;
            case 4:
                $menu = [
                    'value' => $option['value'],
                    'title' => cb_plain_msg('grn.common',
                        'title_frequent_group', ['name' => $option['name']])
                ];
                break;
            case 5:
                $menu = [
                    'value' => $option['value'],
                    'title' => cb_msg('grn.grn', 'GRN_GRN-817')
                               . cb_msg('grn.common', 'title_frequent_users')
                               . cb_msg('grn.grn', 'GRN_GRN-818')
                ];
                break;
            case 6:
                $menu = [
                    'value' => $option['value'],
                    'title' => cb_plain_msg('grn.common',
                        'title_oftenused_group', ['name' => $option['name']])
                ];
                break;
        }
        $category_menu[] = $menu;
    }

    $t->assign('category_menu', $category_menu);

    // org tree view
    require_once('grn/org_tree.csp');

    $page_name = cb_get_pagename() . '/user';

    $util = GRN_OrgTreeUtil::getInstance();
    $tree = $util->getTree($page_name, null, null, true);

    $s_oid = $tree->getSelectedNode();

    $tree->setSelectedNode($s_oid);
    $util->setTree($page_name, $tree);

    $tree_for_view = [
        'tree_name' => 'group_categories_tree_' . $sUID,
        'root'      => $tree->getRoot(),
        'async_url' => 'grn/ajax_get_sub_group_for_mobile',
        'oid_key'   => 'oid',
        'page_name' => $page_name,
        'no_root'   => true
    ];
    $t->assign('user_categories_tree', $tree_for_view);

    if ($popup_include_role) {
        $list_static_roles = $uum->listStaticRoles();
        unset($list_static_roles[GRN_UUM_ADMINISTRATION_ROLE]);
        $role_info_list = [];
        foreach ($list_static_roles as $static_role) {
            $role_id = $static_role->getOID();
            $role_info = [
                'oid'      => $role_id,
                'name'     => $static_role->get("foreign_key"),
                'parent'   => null,
                'expanded' => false,
                'count'    => 0,
                'children' => []
            ];
            $role_info_list[$role_id] = $role_info;
        }
        $tree_for_view = [
            'tree_name' => 'role_categories_tree_' . $sUID,
            'root'      => $role_info_list,
            'async_url' => 'grn/ajax_get_sub_group_for_mobile',
            'oid_key'   => 'oid',
            'page_name' => $page_name,
            'no_root'   => true
        ];
        $t->assign('role_categories_tree', $tree_for_view);
    }

    // end tree view
    $t->assign('product_term', cb_get_product_term(CB_TYPE_TEXT));
    $t->assign('copyright', cb_get_copyright(CB_TYPE_TEXT));

    return $t->fetch('grn/mobile_user_add.tpl');
}


//最近選択した組織
function _smarty_function_grn_user_add_getGroupHistory(
    &$login,
    $plungin,
    $plungin_param,
    &$category_options,
    &$item_options
) {
    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');

    $frequent_groups = $uum->getFrequentGroupsInfo($login->getOID());

    if ($plugin) {
        //アクセス権
        $frequent_group_ids = $plugin->evalGroups($frequent_groups_hash,
            $plugin_param);
    }

    foreach ($frequent_groups as $group) {
        $group_id = $group['_id'];
        $group_name = $group['col_name'];
        $category_options[] = [
            'value' => "g$group_id",
            'type'  => 4,
            'name'  => $group_name
        ];
        $item_options["g$group_id"] = [];
    }
}

function _smarty_function_grn_user_add_getOftenusedGroups(
    &$login,
    $plugin,
    $plugin_param,
    &$category_options,
    &$item_options
) {
    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');

    $oftenused_groups = $uum->getOftenusedGroupsInfo($login->getOID());

    if ($plugin) {
        //アクセス権
        $oftenusedgroups = $plugin->evalGroups($oftenused_groups,
            $plugin_param);
        /** IDs of groups are set into the values of $oftenused_group_ids. Its keys are just incremental number. */
    }

    foreach ($oftenused_groups as $group) {
        $group_id = $group['_id'];
        $group_name = $group['col_name'];
        $category_options[] = [
            'value' => "g$group_id",
            'type'  => 6,
            'name'  => $group_name
        ];
        $item_options["g$group_id"] = [];
    }
}

function _smarty_function_grn_user_add_getMyGroups(
    &$login,
    $plugin,
    $plugin_param,
    &$category_options,
    &$item_options
) {
    $uum = cb_lwc_uum();

    $mygroups = $uum->getMyGroupsInfo($login->getOID(), 'user');
    foreach ($mygroups as $mygroup) {
        $mygroup_id = $mygroup['_id'];
        $mygroup_name = $mygroup['col_name'];
        $category_options[] = [
            'value' => "m$mygroup_id",
            'type'  => 1,
            'name'  => $mygroup_name
        ];
        $item_options["m$mygroup_id"] = [];
    }
}



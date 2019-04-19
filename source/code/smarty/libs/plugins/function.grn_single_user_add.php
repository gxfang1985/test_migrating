<?php

/**
 * @name   grn_single_user_add
 * @description ユーザー一覧の表示
 *
 * @date        2005/01/28
 * @author      SHIMADA Kunihiko
 *
 * @param  string  form_name         formタグのname属性
 *
 * @option      array   selected_user     初期選択済みユーザー
 *                                    $selected_user = array( 'title' => $user_name,
 *                                                            'id' => $user_id );
 * @option      array   access_plugin     アクセス制限のためのプラグインドライバ名とドライバのメソッドに引数として渡す連想配列
 *                                    $access_plugin = array( 'name' => $plugin_name,
 *                                                          'params' => $plugin_params );
 * @option      string  plugin_session_name pluginデータの格納されるセッションオブジェクト名(default:ページ名)
 * @option      string  plugin_data_name    pluginデータの格納されるデータ名(default:'access_plugin')
 * @option      boolean include_org      「組織図から選択する」にて開く画面の組織選択タブの有無(default:FALSE)
 * @option      string  ftree_async_page  施設グループツリーの非同期読み込み用のページ名
 * @option      string  ftree_page_name  施設グループツリーのページ名
 */
function smarty_function_grn_single_user_add($params, &$smarty)
{
    $t = new GRN_Smarty();

    // 引数取得( 施設グループのツリーでデータを問い合わせるときに使うページ名)
    $t->assign('page_name', $params['page_name']);

    // 引数取得( 施設グループのプルダウンの初期値)
    $t->assign('default_group_name', $params['default_group_name']);

    // 引数取得( 施設グループツリーの初期値)
    $t->assign('group_id', $params['group_id']);

    // 引数取得( 所属施設グループの表示の有無)
    $t->assign('show_affiliation_group', $params['show_affiliation_group']);

    // 引数取得(フォーム名、セレクトボックス名)
    $form_name = cb_get_pagename();
    if (array_key_exists('form_name', $params)
        && strlen($params['form_name']) > 0
    ) {
        $form_name = $params['form_name'];
    }
    $t->assign('form_name', $form_name);

    // 引数取得(不必須パラメタ)
    if (array_key_exists('selected_user', $params)) {
        $t->assign('selected_user', $params['selected_user']);
    }
    if (array_key_exists('item_group', $params)) {
        $t->assign('item_group', $params['item_group']);
    }

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
        $session =& $sm->getSession($plugin_session_name);
        $session->set($plugin_data_name, $access_plugin);
        $t->assign('access_plugin', $access_plugin);
        $t->assign('plugin_session_name', $plugin_session_name);
        $t->assign('plugin_data_name', $plugin_data_name);
        $loader = new CB_PluginLoader('grn.common.user.select');
        $plugin =& $loader->loadDriver($params['access_plugin']['name']);
        $plugin_param = $params['access_plugin']['params'];
    }

    // 引数取得(bool)
    $include_org = false;
    if (array_key_exists('include_org', $params) && $params['include_org']) {
        $include_org = true;
    }
    $t->assign('include_org', $include_org);

    // uum
    global $G_container_base;
    /** @var GRN_Uum $uum */
    $uum = $G_container_base->getInstance('uum');
    $login =& $uum->getLoginUser();

    require_once('grn/ui.csp');
    $manager = GRN_UIConfigManager::getInstance();
    $config =& $manager->getUserConfig($login);

    $category_options = [];
    $item_options = [];

    if ($config->getMyGroupPosition() == 'upper') {
        _smarty_function_grn_single_user_add_getMyGroupsInfo($login, $plugin,
            $plugin_param,
            $category_options, $item_options);
        _smarty_function_grn_single_user_add_getOftenusedGroupsInfo($login,
            $plugin, $plugin_param,
            $category_options, $item_options);
    } else {
        _smarty_function_grn_single_user_add_getOftenusedGroupsInfo($login,
            $plugin, $plugin_param,
            $category_options, $item_options);
        _smarty_function_grn_single_user_add_getMyGroupsInfo($login, $plugin,
            $plugin_param,
            $category_options, $item_options);
    }
    // 優先する組織
    $primary_group = $uum->getUserPrimaryGroupInfo($login->getOID());
    $primary_group_id = '';
    if ($primary_group !== false) {
        if ($plugin) {
            //アクセス権
            $ret
                = $plugin->evalGroups([$primary_group['_id'] => $primary_group],
                $plugin_param);
            if (count($ret) > 0) {
                $primary_group_id = $primary_group['_id'];
                $group_id = $primary_group_id;
                $group_name = $primary_group['col_name'];
                $category_options[] = [
                    'value' => "g$group_id",
                    'type'  => 2,
                    'name'  => $group_name
                ];
                $item_options["g$group_id"] = [];

                if ($include_org == '1') {
                    $item_options["g$group_id"][] = [
                        'value' => "g$group_id",
                        'type'  => 'group',
                        'name'  => $group_name
                    ];
                }

                $users_id = $uum->getGroupUsersId($group_id);
                if ($plugin) {
                    $users_id = $plugin->evalUsers($users_id, $plugin_param);
                }

                foreach ($users_id as $uid) {
                    $item_options["g$group_id"][] = [
                        'value' => $uid . ':' . $group_id,
                        'type'  => 'user',
                        'name'  => GRN_ControllerUtil::getUserNameText($login->getOID(),
                            $uid)
                    ];
                }
            }
        }
    }

    // 所属する組織
    $usergroups = $uum->getUserGroupsInfo($login->getOID());
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
        if ($include_org == '1') {
            $item_options["g$group_id"][] = [
                'value' => "g$group_id",
                'type'  => 'group',
                'name'  => $group_name
            ];
        }
        $users_id = $uum->getGroupUsersId($group_id);
        if ($plugin) {
            $users_id = $plugin->evalUsers($users_id, $plugin_param);
        }
        foreach ($users_id as $uid) {
            $item_options["g$group_id"][] = [
                'value' => $uid . ':' . $group_id,
                'type'  => 'user',
                'name'  => GRN_ControllerUtil::getUserNameText($login->getOID(),
                    $uid)
            ];
        }
    }

    //最近選択した組織
    _smarty_function_grn_single_user_add_getFrequentGroupsInfo($login, $plugin,
        $plugin_param, $category_options, $item_options);
    //最近選択したユーザー
    _smarty_function_grn_single_user_add_getFrequentUsersInfo($login, $plugin,
        $plugin_param, $category_options, $item_options);

    $t->assign('category_option_disabled', count($category_options) == 0);
    $t->assign('category_options', $category_options);
    $item_options_keys = array_keys($item_options);
    if ($primary_group_id != '') {
        $t->assign('selected_item_options',
            $item_options["g$primary_group_id"]);
    } else {
        $t->assign('selected_item_options',
            $item_options[$item_options_keys[0]]);
    }
    $t->assign('item_options', $item_options);

    if (array_key_exists('ftree_page_name', $params)
        && strlen($params['ftree_page_name']) > 0
    ) {
        $ftree_page_name = $params['ftree_page_name'];
    } else {
        $ftree_page_name = cb_get_pagename();
    }

    /////////////////////////////////////////////////
    // For tree
    require_once('schedule/portlet_view_util.csp');
    $tree_data
        = GRN_Schedule_Portlet_Dropdown_Util::makeFacilityGroupsTreeMenu($ftree_page_name,
        $group_id, 0);

    $t->assign('fgroup_list', $tree_data['org']);
    $t->assign('ftree_name', $ftree_page_name);
    $t->assign('fgroup_selected_id', $tree_data['selected_id']);
    $t->assign('ftree_async_page', @$params['ftree_async_page']);

    return $t->fetch('grn/single_user_add.tpl');
}

/**
 * My グループの一覧を作成
 *
 * @param CB_User $login
 * @param         $plugin
 * @param         $plugin_param
 * @param         $category_options
 * @param         $item_options
 */
function _smarty_function_grn_single_user_add_getMyGroupsInfo(
    &$login,
    &$plugin,
    &$plugin_param,
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
        $users_id = $uum->getMyGroupUsersId($mygroup_id);
        if ($plugin) {
            $users_id = $plugin->evalUsers($users_id, $plugin_param);
        }
        foreach ($users_id as $uid) {
            $item_options["m$mygroup_id"][] = [
                'value' => $uid,
                'type'  => 'user',
                'name'  => GRN_ControllerUtil::getUserNameText($login->getOID(),
                    $uid)
            ];
        }
    }
}

/**
 * よく使う組織の一覧を作成
 *
 * @param CB_User $login
 * @param         $plugin
 * @param         $plugin_param
 * @param         $category_options
 * @param         $item_options
 */
function _smarty_function_grn_single_user_add_getOftenusedGroupsInfo(
    &$login,
    &$plugin,
    &$plugin_param,
    &$category_options,
    &$item_options
) {
    //よく使う組織
    require_once('grn/uum_util.csp');
    global $G_container_base;
    /** @var GRN_Uum $uum */
    $uum = $G_container_base->getInstance('uum');

    $oftenusedgroups = $uum->getOftenusedGroupsInfo($login->getOID());
    if ($plugin) {
        //アクセス権
        $oftenusedgroups = $plugin->evalGroups($oftenusedgroups, $plugin_param);
    }
    foreach ($oftenusedgroups as $group) {
        $group_id = $group['_id'];
        $group_name = $group['col_name'];
        $category_options[] = [
            'value' => "g$group_id",
            'type'  => 6,
            'name'  => $group_name
        ];
        $item_options["g$group_id"] = [];
        if ($include_org == '1') {
            $item_options["g$group_id"][] = [
                'value' => "g$group_id",
                'type'  => 'group',
                'name'  => $group_name
            ];
        }
        $users_id = $uum->getGroupUsersId($group_id);
        if ($plugin) {
            $users_id = $plugin->evalUsers($users_id, $plugin_param);
        }
        foreach ($users_id as $uid) {
            $item_options["g$group_id"][] = [
                'value' => $uid . ':' . $group_id,
                'type'  => 'user',
                'name'  => GRN_ControllerUtil::getUserNameText($login->getOID(),
                    $uid)
            ];
        }
    }
}

/**
 * 最近選択した組織の一覧を作成
 *
 * @param CB_User $login
 * @param         $plugin
 * @param         $plugin_param
 * @param         $category_options
 * @param         $item_options
 */
function _smarty_function_grn_single_user_add_getFrequentGroupsInfo(
    &$login,
    &$plugin,
    &$plugin_param,
    &$category_options,
    &$item_options
) {
    require_once('grn/uum_util.csp');
    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');

    $frequentgroups = $uum->getFrequentGroupsInfo($login->getOID());
    if ($plugin) {
        //アクセス権
        $frequentgroups = $plugin->evalGroups($frequentgroups, $plugin_param);
    }
    foreach ($frequentgroups as $group) {
        $group_id = $group['_id'];
        $group_name = $group['col_name'];
        $category_options[] = [
            'value' => "g$group_id",
            'type'  => 4,
            'name'  => $group_name
        ];
        $item_options["g$group_id"] = [];
        if ($include_org == '1') {
            $item_options["g$group_id"][] = [
                'value' => "g$group_id",
                'type'  => 'group',
                'name'  => $group_name
            ];
        }
        $users_id = $uum->getGroupUsersId($group_id);
        if ($plugin) {
            $users_id = $plugin->evalUsers($users_id, $plugin_param);
        }
        foreach ($users_id as $uid) {
            $item_options["g$group_id"][] = [
                'value' => $uid . ':' . $group_id,
                'type'  => 'user',
                'name'  => GRN_ControllerUtil::getUserNameText($login->getOID(),
                    $uid)
            ];
        }
    }
}

/**
 * 最近選択したユーザーの項目(１つ)を作成
 *
 * @param CB_User $login
 * @param         $plugin
 * @param         $plugin_param
 * @param         $category_options
 * @param         $item_options
 */
function _smarty_function_grn_single_user_add_getFrequentUsersInfo(
    &$login,
    &$plugin,
    &$plugin_param,
    &$category_options,
    &$item_options
) {
    require_once('grn/uum_util.csp');
    global $G_container_base;
    /** @var GRN_Uum $uum */
    $uum = $G_container_base->getInstance('uum');

    $frequentusers_id = $uum->getFrequentUsersId($login->getOID());
    if ($plugin) {
        //アクセス権
        $frequentusers_id = $plugin->evalUsers($frequentusers_id,
            $plugin_param);
    }
    if (is_array($frequentusers_id) && count($frequentusers_id) > 0) {
        $category_options[] = [
            'value' => "frequent",
            'type'  => 5
        ];
        $item_options['frequent'] = [];
        foreach ($frequentusers_id as $uid) {
            $item_options['frequent'][] = [
                'value' => $uid,
                'type'  => 'user',
                'name'  => GRN_ControllerUtil::getUserNameText($login->getOID(),
                    $uid)
            ];
        }
    }
}



<?php

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
function smarty_function_grn_user_add($params, &$smarty)
{
    require_once('grn/uum_util.csp');
    require_once("grn/controller.csp");
    require_once($smarty->_get_plugin_filepath('function', 'grn_user_name'));

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
    if (array_key_exists('btn_add_onClick', $params)) {
        $t->assign('btn_add_onClick', $params['btn_add_onClick']);
    }
    if (array_key_exists('btn_rmv_onClick', $params)) {
        $t->assign('btn_rmv_onClick', $params['btn_rmv_onClick']);
    }
    if (array_key_exists('function_name', $params)) {
        $t->assign('function_name', $params['function_name']);
    }
    $t->assign('form_name', $form_name);
    $t->assign('sUID', $sUID);
    $t->assign('CGID', $CGID);
    $t->assign('CID', $CID);
    $t->assign('duplication', $duplication);
    $t->assign('order_by', $order_by);

    // 引数取得(不必須パラメタ)
    if (array_key_exists('selected_users', $params)) {
        $t->assign('selected_users', $params['selected_users']);
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

    //popup_include_org(bool)
    $popup_include_org = false;
    if (array_key_exists('popup_include_org', $params)
        && $params['popup_include_org']
    ) {
        $popup_include_org = true;
    }
    $t->assign('popup_include_org', $popup_include_org);

    // 組織をそのままメンバーに追加する(スケジューラ用)
    $org_direct = false;
    if (array_key_exists('org_direct', $params) && $params['org_direct']) {
        $org_direct = true;
    }
    $t->assign('org_direct', $org_direct);

    // uum
    global $G_container_base;
    /** @var $uum \GRN_Uum */
    $uum = $G_container_base->getInstance('uum');
    $login = $uum->getLoginUser();

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
    $primary_group = $uum->getUserPrimaryGroupInfo($login->getOID(), true);
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
    $usergroups = $uum->getUserGroupsInfo($login->getOID(), true);
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
    $column = [
        'col_display_name',
        'col_display_name_language',
        'col_nickname'
    ];

    $users_info = [];
    if ($primary_group_id != '') {
        $users_id = $uum->getGroupUsersId($primary_group_id);
        if ($plugin) {
            $users_id = $plugin->evalUsers($users_id, $plugin_param);
        }
        $users_info = [];

        if ($skip) {
            $users_info[] = [
                'value' => 0,
                'type'  => 'user',
                'name'  => cb_msg('grn.schedule', 'grn_user_add_item_skip')
            ];
        }

        if ($include_org == '1') {
            $users_info[] = [
                'value' => "g$primary_group_id",
                'type'  => 'group',
                'name'  => htmlspecialchars($primary_group_name)
            ];
        }

        $users = GRN_ControllerUtil::getUserInfoToShowUserName($users_id,
            $login);

        foreach ($users_id as $uid) {
            $users_info[] = [
                'value' => $uid . ':' . $primary_group_id,
                'type'  => 'user',
                'name'  => smarty_function_grn_user_name(
                    [
                        "uid"        => $uid,
                        "name"       => $users[$uid]["col_display_name"],
                        "only_text"  => true,
                        "users_info" => $users
                    ],
                    $smarty
                )
            ];
        }
    } else {
        $item_options_keys = array_keys($item_options);
        $type = $item_options_keys[0]{0};
        $group_id = substr($item_options_keys[0], 1);

        switch ($type) {
            // MyGroup Users
            case 'm':
                $users_id = $uum->getMyGroupUsersId($group_id);
                if ($plugin) {
                    $users_id = $plugin->evalUsers($users_id, $plugin_param);
                }
                if ($skip) {
                    $users_info[] = [
                        'value' => 0,
                        'type'  => 'user',
                        'name'  => cb_msg('grn.schedule',
                            'grn_user_add_item_skip')
                    ];
                }

                $users
                    = GRN_ControllerUtil::getUserInfoToShowUserName($users_id,
                    $login);

                foreach ($users_id as $uid) {
                    $users_info[] = [
                        'value' => $uid,
                        'type'  => 'user',
                        'name'  => smarty_function_grn_user_name(
                            [
                                "uid"        => $uid,
                                "name"       => $users[$uid]["col_display_name"],
                                "only_text"  => true,
                                "users_info" => $users
                            ],
                            $smarty
                        )
                    ];

                }
                break;

            // Group Users
            case 'g':
                $users_id = $uum->getGroupUsersId($group_id);

                $group_name = '';
                for ($i = 0; $i < count($category_options); $i++) {
                    if (($category_options[$i]['type'] === 3
                         || $category_options[$i]['type'] === 4
                         || $category_options[$i]['type'] === 6)
                        && strcmp($category_options[$i]['value'], "g$group_id")
                           === 0
                    ) {
                        $group_name = $category_options[$i]['name'];
                        break;
                    }
                }
                if ($skip) {
                    $users_info[] = [
                        'value' => 0,
                        'type'  => 'user',
                        'name'  => cb_msg('grn.schedule',
                            'grn_user_add_item_skip')
                    ];
                }
                if ($include_org == '1') {
                    $users_info[] = [
                        'value' => "g$group_id",
                        'type'  => 'group',
                        'name'  => htmlspecialchars($group_name)
                    ];
                }
                if ($plugin) {
                    $users_id = $plugin->evalUsers($users_id, $plugin_param);
                }

                $users
                    = GRN_ControllerUtil::getUserInfoToShowUserName($users_id,
                    $login);

                foreach ($users_id as $uid) {
                    $users_info[] = [
                        'value' => $uid . ':' . $group_id,
                        'type'  => 'user',
                        'name'  => smarty_function_grn_user_name(
                            [
                                "uid"        => $uid,
                                "name"       => $users[$uid]["col_display_name"],
                                "only_text"  => true,
                                "users_info" => $users
                            ],
                            $smarty
                        )
                    ];
                }
                break;

            // Frequent Users
            case 'f':
                $frequentusers_id = $uum->getFrequentUsersId($login->getOID());
                if ($plugin) {
                    //アクセス権
                    $frequentusers_id = $plugin->evalUsers($frequentusers_id,
                        $plugin_param);
                }

                if (is_array($frequentusers_id)
                    && count($frequentusers_id) > 0
                ) {
                    if ($skip) {
                        $users_info[] = [
                            'value' => 0,
                            'type'  => 'user',
                            'name'  => cb_msg('grn.schedule',
                                'grn_user_add_item_skip')
                        ];
                    }

                    $frequentusers
                        = GRN_ControllerUtil::getUserInfoToShowUserName($frequentusers_id,
                        $login);

                    foreach ($frequentusers_id as $uid) {
                        $users_info[] = [
                            'value' => $uid,
                            'type'  => 'user',
                            'name'  => smarty_function_grn_user_name(
                                [
                                    "uid"        => $uid,
                                    "name"       => $frequentusers[$uid]["col_display_name"],
                                    "only_text"  => true,
                                    "users_info" => $frequentusers
                                ],
                                $smarty
                            )
                        ];
                    }
                } else {
                    // no frequent users, remove category option 'frequent'
                    for ($i = 0; $i < count($category_options); $i++) {
                        if (strcmp($category_options[$i]['value'], 'frequent')
                            === 0
                        ) {
                            unset($category_options[$i]);
                            break;
                        }
                    }
                    $users_info = $item_options['login'];
                }
                break;

            // ログインユーザー
            case 'l':
                $users_info = $item_options['login'];
                break;

        }
    }

    $t->assign('category_option_disabled', count($category_options) == 0);
    $t->assign('skip', $skip);
    $t->assign('category_options', $category_options);
    $t->assign('selected_item_options', $users_info);
    require_once('fw/ui.csp');
    $browser = cb_ui_get_browser();
    $t->assign('os', $browser['os_type']);

    $module = '';
    if (array_key_exists('module', $params) && strlen($params['module']) > 0) {
        $module = '_' . $params['module'];
    }

    if (array_key_exists('no_caption', $params) && $params['no_caption']) {
        $t->assign('no_caption', $params['no_caption']);
    }

    if (array_key_exists('id_searchbox', $params)
        && strlen($params['id_searchbox']) > 0
    ) {
        $t->assign('id_searchbox', $params['id_searchbox']);
    } else {
        $t->assign('id_searchbox', 'users');
    }

    return $t->fetch('grn/user_add' . $module . '.tpl');
}

/**
 * 最近選択した組織
 *
 * @param CB_User $login
 * @param         $plungin
 * @param         $plungin_param
 * @param         $category_options
 * @param         $item_options
 */
function _smarty_function_grn_user_add_getGroupHistory(
    &$login,
    $plungin,
    $plungin_param,
    &$category_options,
    &$item_options
) {
    global $G_container_base;
    /** @var GRN_Uum $uum */
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

/**
 * @param CB_User $login
 * @param         $plugin
 * @param         $plugin_param
 * @param         $category_options
 * @param         $item_options
 */
function _smarty_function_grn_user_add_getOftenusedGroups(
    &$login,
    $plugin,
    $plugin_param,
    &$category_options,
    &$item_options
) {
    global $G_container_base;
    /** @var GRN_Uum $uum */
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

/**
 * @param CB_User $login
 * @param         $plugin
 * @param         $plugin_param
 * @param         $category_options
 * @param         $item_options
 */
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



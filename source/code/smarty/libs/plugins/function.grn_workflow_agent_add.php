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
 */
function smarty_function_grn_workflow_agent_add($params, &$smarty)
{
    $t = new GRN_Smarty();

    // 引数取得(フォーム名、セレクトボックス名)
    $form_name = cb_get_pagename();
    if (array_key_exists('form_name', $params)
        && strlen($params['form_name']) > 0
    ) {
        $form_name = $params['form_name'];
    }
    $user = false;
    if (array_key_exists('user', $params) && count($params['user']) > 0) {
        $user = $params['user'];
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
    $preview = false;
    if (array_key_exists('preview', $params) && $params['preview']) {
        $preview = $params['preview'];
    }
    $preview_params = false;
    if (array_key_exists('params', $params) && $params['params']) {
        $preview_params = $params['params'];
    }
    $cancel_page = '';
    if (array_key_exists('cancel_page', $params) && $params['cancel_page']) {
        $cancel_page = $params['cancel_page'];
    }
    $oid = '';
    if (array_key_exists('oid', $params) && $params['oid']) {
        $oid = $params['oid'];
    }
    $system_flag = false;
    if (array_key_exists('system_flag', $params) && $params['system_flag']) {
        $system_flag = $params['system_flag'];
    }
    $sf = null;
    if (array_key_exists('sf', $params) && $params['sf']) {
        $sf = $params['sf'];
    }

    $t->assign('form_name', $form_name);
    $t->assign('user', $user);
    $t->assign('sUID', $sUID);
    $t->assign('CGID', $CGID);
    $t->assign('CID', $CID);
    $t->assign('duplication', $duplication);
    $t->assign('preview', $preview);
    $t->assign('params', $preview_params);

    $t->assign('cancel_page', $cancel_page);
    $t->assign('oid', $oid);
    $t->assign('system_flag', $system_flag);
    $t->assign('sf', $sf);

    // 引数取得(代理人タイプリスト：初期ユーザー情報を含む)
    if (array_key_exists('agent_type_list', $params)) {
        $t->assign('agent_type_list', $params['agent_type_list']);
    }
    if (array_key_exists('agent_type_count', $params)) {
        $t->assign('agent_type_count', $params['agent_type_count']);
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

    // uum
    global $G_container_base;
    /** @var GRN_Uum $uum */
    $uum = $G_container_base->getInstance('uum');
    $login =& $uum->getLoginUser();

    $category_options = [];
    $item_options = [];

    require_once('grn/ui.csp');
    $manager = GRN_UIConfigManager::getInstance();
    $config =& $manager->getUserConfig($login);

    if ($config->getMyGroupPosition() == 'upper') {
        // Myグループ
        _smarty_function_grn_workflow_agent_add_getMyGroups($login, $plugin,
            $plugin_param, $category_options, $item_options);

        // よく使う組織
        _smarty_function_grn_workflow_agent_add_getOftenusedGroups($login,
            $plugin, $plugin_param, $category_options, $item_options);
    } else {
        // よく使う組織
        _smarty_function_grn_workflow_agent_add_getOftenusedGroups($login,
            $plugin, $plugin_param, $category_options, $item_options);

        // Myグループ
        _smarty_function_grn_workflow_agent_add_getMyGroups($login, $plugin,
            $plugin_param, $category_options, $item_options);
    }

    // 優先する組織
    $primary_group = $uum->getUserPrimaryGroupInfo($login->getOID());
    $primary_group_id = '';
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

            if ($isPermission) {
                $primary_group_id = $primary_group['_id'];
                $group_id = $primary_group_id;
                $group_name = $primary_group['col_name'];
                $category_options[] = [
                    'value' => "g$group_id",
                    'type'  => 2,
                    'name'  => $group_name
                ];
                $item_options["g$group_id"] = [];
                $users_id = $uum->getGroupUsersId($group_id);
                if ($plugin) {
                    $users_id = $plugin->evalUsers($users_id, $plugin_param);
                }
                foreach ($users_id as $uid) {
                    $userObj = new FunctionGrnWorkflowAgent_User();
                    $userObj->setValue($uid . ':' . $group_id);
                    $userObj->setType('user');
                    $userObj->setId($uid);
                    $item_options["g$group_id"][] = $userObj;
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
        $users_id = $uum->getGroupUsersId($group_id);
        if ($plugin) {
            $users_id = $plugin->evalUsers($users_id, $plugin_param);
        }
        foreach ($users_id as $uid) {
            $userObj = new FunctionGrnWorkflowAgent_User();
            $userObj->setValue($uid . ':' . $group_id);
            $userObj->setType('type');
            $userObj->setId($uid);
            $item_options["g$group_id"][] = $userObj;
        }
    }

    //最近選択した組織
    require_once('grn/uum_util.csp');
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
        $users_id = $uum->getGroupUsersId($group_id);
        if ($plugin) {
            $users_id = $plugin->evalUsers($users_id, $plugin_param);
        }
        foreach ($users_id as $uid) {
            $userObj = new FunctionGrnWorkflowAgent_User();
            $userObj->setValue($uid . ':' . $group_id);
            $userObj->setType('user');
            $userObj->setId($uid);
            $item_options["g$group_id"][] = $userObj;
        }
    }

    //最近選択したユーザー
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
            $userObj = new FunctionGrnWorkflowAgent_User();
            $userObj->setValue($uid);
            $userObj->setType('user');
            $userObj->setId($uid);
            $item_options['frequent'][] = $userObj;
        }
    }

    $t->assign('category_option_disabled', count($category_options) == 0);
    $t->assign('category_options', $category_options);

    //make a list of users.
    $users_id = [];
    foreach ($item_options as $userList) {
        foreach ($userList as $userObj) {
            $users_id[$userObj->getId()] = 1;
        }
    }
    $users_id = array_keys($users_id);

    //set users' names.
    require_once("grn/controller.csp");
    $users_info = GRN_ControllerUtil::getUserInfoToShowUserName($users_id,
        $login);

    foreach ($item_options as $userList) {
        foreach ($userList as $userObj) {
            $userObj->setName(GRN_ControllerUtil::getUserNameText($login->getOID(),
                $userObj->getId(), $users_info));
        }
    }
    $t->assign('item_options', $item_options);

    $item_options_keys = array_keys($item_options);
    if ($primary_group_id != '') {
        $t->assign('selected_item_options',
            $item_options["g$primary_group_id"]);
    } else {
        $t->assign('selected_item_options',
            $item_options[$item_options_keys[0]]);
    }


    return $t->fetch('workflow/agent_add.tpl');
}

/**
 * @param CB_User $login
 * @param         $plugin
 * @param         $plugin_param
 * @param         $category_options
 * @param         $item_options
 */
function _smarty_function_grn_workflow_agent_add_getMyGroups(
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
            $userObj = new FunctionGrnWorkflowAgent_User();
            $userObj->setValue($uid);
            $userObj->setType('user');
            $userObj->setId($uid);
            $item_options["m$mygroup_id"][] = $userObj;
        }
    }
}

/**
 * @param CB_User $login
 * @param         $plugin
 * @param         $plugin_param
 * @param         $category_options
 * @param         $item_options
 */
function _smarty_function_grn_workflow_agent_add_getOftenusedGroups(
    &$login,
    &$plugin,
    &$plugin_param,
    &$category_options,
    &$item_options
) {
    global $G_container_base;
    /** @var GRN_Uum $uum */
    $uum = $G_container_base->getInstance('uum');

    require_once('grn/uum_util.csp');
    $frequentgroups = $uum->getOftenusedGroupsInfo($login->getOID());
    if ($plugin) {
        //アクセス権
        $frequentgroups = $plugin->evalGroups($frequentgroups, $plugin_param);
    }
    foreach ($frequentgroups as $group) {
        $group_id = $group['_id'];
        $group_name = $group['col_name'];
        $category_options[] = [
            'value' => "g$group_id",
            'type'  => 6,
            'name'  => $group_name
        ];
        $item_options["g$group_id"] = [];
        $users_id = $uum->getGroupUsersId($group_id);
        if ($plugin) {
            $users_id = $plugin->evalUsers($users_id, $plugin_param);
        }
        foreach ($users_id as $uid) {
            $agent = new FunctionGrnWorkflowAgent_User();
            $agent->setValue($uid . ':' . $group_id);
            $agent->setType("user");
            $agent->setId($uid);

            $item_options["g$group_id"][] = $agent;
        }
    }
}

class FunctionGrnWorkflowAgent_User
{
    private $value;

    public function getValue()
    {
        return $this->value;
    }

    public function setValue($value)
    {
        $this->value = $value;
    }

    private $type;

    public function getType()
    {
        return $this->type;
    }

    public function setType($type)
    {
        $this->type = $type;
    }

    private $id;

    public function getId()
    {
        return $this->id;
    }

    public function setId($id)
    {
        $this->id = $id;
    }

    private $name;

    public function getName()
    {
        return $this->name;
    }

    public function setName($name)
    {
        $this->name = $name;
    }
}

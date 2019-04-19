<?php

/**
 * @name               grn_member_add
 *
 * @param       array  $params
 * @param       Smarty $smarty
 *
 * @options      string  name
 * @options      string  form_name
 * @options      string  sUID              The name attribute of selected user list.(default:sUID[])
 * @options      string  CGID              The name attribute of select tag that has candidate group list.(default:CGID)
 * @options      string  CID               The name attribute of candidate user list.(default:CID[])
 * @options      array   selected_users    Selected user list.
 * @options      array   candidate_users   Candidate user list.
 * @options      array   operator_add_name The name attribute of operator add name.
 * @options      string  app_id
 * @options      array   access_plugin     The plugin driver for permission logic.
 *                                    $access_plugin = array( 'name' => $plugin_name,
 *                                                          'params' => $plugin_params );
 * @options      string  plugin_session_name Session object name which has plugin data.(default:page name)
 * @options      string  plugin_data_name    The data name of plugin data(default:'access_plugin')
 * @options      boolean include_org      The flag of organizations select tab in "Select from organizations".(default:FALSE)
 * @options      boolean popup_include_org
 * @options      boolean is_calendar
 * @options      boolean show_group_role
 * @options      boolean|string require_role_tab
 * @options      array   order_parts_options The options of order parts.
 *                                            $order_parts_options    = array('is_use'           => TRUE);
 * @options      array   pulldown_parts_options The options of pulldown parts.
 *                                            $pulldown_parts_options = array('is_use'           => TRUE);
 * @options      array   search_box_options The options of search box.
 *                                            $search_box_options     = array('is_use'           => TRUE,
 *                                                                            'id_searchbox'     => 'user',
 *                                                                            'url'              => 'grn/ajax/search_members_by_keyword',
 *                                                                            'append_post_data' => array());
 * @options      boolean is_extended_plugin
 * @return mixed|string|void
 */
function smarty_function_grn_member_add($params, &$smarty)
{
    require_once('grn/uum_util.csp');
    require_once("grn/controller.csp");
    require_once('grn/ui.csp');
    require_once('fw/ui.csp');

    require_once($smarty->_get_plugin_filepath('function', 'grn_user_name'));

    if (array_key_exists('is_extended_plugin', $params)) {
        $t = $smarty;
    } else {
        $t = new GRN_Smarty();
    }

    $name = cb_at($params, 'name');
    $form_name = cb_at($params, 'form_name', cb_get_pagename());
    $sUID = cb_at($params, 'sUID', 'sUID');
    $CGID = cb_at($params, 'CGID', 'CGID');
    $CID = cb_at($params, 'CID', 'CID');
    $selected_users = cb_at($params, 'selected_users', []);
    $candidate_users = cb_at($params, 'candidate_users', []);
    $t->assign('name', $name);
    $t->assign('form_name', $form_name);
    $t->assign('sUID', $sUID);
    $t->assign('CGID', $CGID);
    $t->assign('CID', $CID);
    $t->assign('selected_users', $selected_users);
    $t->assign('candidate_users', $candidate_users);

    $search_box_options = cb_at($params,
        'search_box_options', []);
    $search_box_options['is_use'] = cb_at($search_box_options,
        'is_use', true);
    $search_box_options['id_searchbox'] = cb_at($search_box_options,
        'id_searchbox', 'user');
    $search_box_options['url'] = cb_at($search_box_options, 'url',
        'grn/ajax/search_members_by_keyword');
    $search_box_options['append_post_data'] = cb_at($search_box_options,
        'append_post_data', []);
    $t->assign('search_box_options', $search_box_options);

    $pulldown_parts_options = cb_at($params,
        'pulldown_parts_options', []);
    $pulldown_parts_options['is_use'] = cb_at($pulldown_parts_options,
        'is_use', true);
    $pulldown_parts_options['pulldown_id'] = $CID . "_pulldown";
    $t->assign('pulldown_parts_options', $pulldown_parts_options);

    $order_parts_options = cb_at($params, 'order_parts_options', []);
    $order_parts_options['is_use'] = cb_at($order_parts_options, 'is_use',
        true);
    $t->assign('order_parts_options', $order_parts_options);

    _smarty_function_grn_member_add_assignCandidateStyle($t,
        $search_box_options['is_use'],
        $pulldown_parts_options['is_use']);

    $operator_add_name = cb_at($params, 'operator_add_name', "");
    $t->assign('operator_add_name', $operator_add_name);

    $app_id = cb_at($params, 'app_id');
    $t->assign('app_id', $app_id);
    $include_org = (array_key_exists('include_org', $params)
                    && $params['include_org']);
    $t->assign('include_org', $include_org);
    $popup_include_org = (array_key_exists('popup_include_org', $params)
                          && $params['popup_include_org']);
    $t->assign('popup_include_org', $popup_include_org);
    $is_calendar = cb_at($params, 'is_calendar', false);
    $t->assign('is_calendar', $is_calendar);
    $show_group_role = cb_at($params, 'show_group_role', true);
    $t->assign('show_group_role', $show_group_role);
    $use_order_parts = cb_at($params, 'use_order_parts', true);
    $t->assign('use_order_parts', $use_order_parts);
    $show_omitted = (array_key_exists('show_omitted', $params)
                     && $params['show_omitted']);
    $t->assign('show_omitted', $show_omitted);
    $add_org_with_users = (array_key_exists('add_org_with_users', $params)
                           && $params['add_org_with_users']);
    $t->assign('add_org_with_users', $add_org_with_users);

    $select_all_users_in_search = $params['select_all_users_in_search'] ??
                                  false;
    $t->assign('select_all_users_in_search', $select_all_users_in_search);

    $require_role_tab = cb_at($params, 'require_role_tab', '0');
    $t->assign('require_role_tab', $require_role_tab);
    $plugin = null;
    $plugin_param = [];
    $access_plugin = cb_at($params, 'access_plugin');
    if (array_key_exists('access_plugin', $params)
        && is_array($access_plugin)
        && array_key_exists('name', $access_plugin)
        && array_key_exists('params', $access_plugin)
    ) {
        $plugin_session_name = cb_at($params, 'plugin_session_name',
            cb_get_pagename());
        $plugin_data_name = cb_at($params, 'plugin_data_name',
            'access_plugin');
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
        $plugin = $loader->loadDriver($access_plugin['name']);
        $plugin_param = $access_plugin['params'];
    }

    global $G_container_base;
    /** @var $uum \GRN_Uum */
    $uum = $G_container_base->getInstance('uum');
    $login = $uum->getLoginUser();

    $category_options = [];
    $manager = GRN_UIConfigManager::getInstance();
    $config = $manager->getUserConfig($login);

    if ($config->getMyGroupPosition() == 'upper') {
        _smarty_function_grn_member_add_getMyGroups($login, $category_options);
        _smarty_function_grn_member_add_getOftenUsedGroups($login,
            $category_options);
    } else {
        _smarty_function_grn_member_add_getOftenUsedGroups($login,
            $category_options);
        _smarty_function_grn_member_add_getMyGroups($login, $category_options);
    }

    $primary_group = $uum->getUserPrimaryGroupInfo($login->getOID(), true);
    $primary_group_id = '';
    if ($primary_group !== false) {
        $isPermission = true;

        if ($plugin) {
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
        }
    }

    $usergroups = $uum->getUserGroupsInfo($login->getOID(), true);
    if ($plugin) {
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
    }

    _smarty_function_grn_member_add_getGroupHistory($login, $category_options);

    $category_options[] = [
        'value' => "frequent",
        'type'  => 5
    ];
    $t->assign('category_option_disabled', count($category_options) == 0);
    $t->assign('category_options', $category_options);

    $browser = cb_ui_get_browser();
    $t->assign('os', $browser['os_type']);

    // layout template
    $layout_template = $params['layout_template'] ?? 'grn/member_add.tpl';

    return $t->fetch($layout_template);
}

/**
 * 最近選択した組織
 *
 * @param CB_User $login
 * @param         $category_options
 * @param         $item_options
 */
function _smarty_function_grn_member_add_getGroupHistory(
    $login,
    &$category_options
) {
    $uum = cb_lwc_uum();

    $frequent_groups = $uum->getFrequentGroupsInfo($login->getOID());

    foreach ($frequent_groups as $group) {
        $group_id = $group['_id'];
        $group_name = $group['col_name'];
        $category_options[] = [
            'value' => "g$group_id",
            'type'  => 4,
            'name'  => $group_name
        ];
    }
}

/**
 * @param CB_User $login
 * @param         $category_options
 */
function _smarty_function_grn_member_add_getOftenUsedGroups(
    $login,
    &$category_options
) {
    global $G_container_base;
    /** @var GRN_Uum $uum */
    $uum = $G_container_base->getInstance('uum');

    $often_used_groups = $uum->getOftenusedGroupsInfo($login->getOID());

    foreach ($often_used_groups as $group) {
        $group_id = $group['_id'];
        $group_name = $group['col_name'];
        $category_options[] = [
            'value' => "g$group_id",
            'type'  => 6,
            'name'  => $group_name
        ];
    }
}

/**
 * @param CB_User $login
 * @param         $category_options
 */
function _smarty_function_grn_member_add_getMyGroups($login, &$category_options)
{
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
    }
}

/**
 * @param GRN_Smarty $t
 * @param boolean    $is_use_searchbox
 * @param boolean    $is_use_pulldown
 */
function _smarty_function_grn_member_add_assignCandidateStyle(
    &$t,
    $is_use_searchbox,
    $is_use_pulldown
) {

    if ($is_use_searchbox && $is_use_pulldown) {
        $t->assign('select_list_div_class_name', 'selectlist_r_grn');
        $t->assign('view_detail', true);
    } elseif ($is_use_searchbox) {
        $t->assign('select_list_div_class_name',
            'selectlist_r_grn_no_use_pull_down');
        $t->assign('view_detail', true);
    } else {
        $t->assign('select_list_div_class_name',
            'selectlist_r_grn_selectlist_only');
        $t->assign('view_detail', false);
    }

}

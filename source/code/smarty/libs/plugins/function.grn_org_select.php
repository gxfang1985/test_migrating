<?php

require_once('function.grn_select.php');

/**
 * @name        grn_org_select
 * @description 組織選択の表示
 *
 * @date        2005/04/19
 * @author      YOSHIDA Hideyasu
 *
 * @param   int     user_id         ユーザーID
 * @param   int     selected_id     選択組織ID
 * @param   string  return_url      リダイレクト先URL
 * @param   string  app_id          呼び出し元アプリケーションID
 * @param   string  select_style    セレクトボックスのスタイル
 */
function smarty_function_grn_org_select($params, & $smarty)
{
    $t = new GRN_Smarty();

    $function_name = 'grn_org_select';

    // Smartyプラグインのパラメータを検証する
    if (array_key_exists('user_id', $params)) {
        $user_id = $params['user_id'];
    } else {
        return htmlspecialchars($function_name) . ': user_id is required';
    }
    if (array_key_exists('selected_id', $params)) {
        $selected_id = $params['selected_id'];
    } else {
        return htmlspecialchars($function_name) . ': selected_id is required';
    }
    if (array_key_exists('return_url', $params)) {
        $return_url = $params['return_url'];
        $t->assign('return_url', $return_url);
    } else {
        return htmlspecialchars($function_name) . ': return_url is required';
    }

    if (array_key_exists('tp', $params)) {
        $tp = $params['tp'];
        $t->assign('tp', $tp);
    }
    /*    else
        {
            return htmlspecialchars($function_name) . ': tp is required';
        }*/
    if (array_key_exists('ppid', $params)) {
        $ppid = $params['ppid'];
        $t->assign('ppid', $ppid);
    }
    /*
        else
        {
            return htmlspecialchars($function_name) . ': ppid is required';
        }*/

    $app_id = 'grn.common';
    if (array_key_exists('app_id', $params)) {
        $app_id = $params['app_id'];
    }
    $t->assign('app_id', $app_id);

    // uum
    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    require_once('grn/uum_util.csp');
    $uum_util = GRN_UumUtil::getInstance();

    $login = $uum->getUser($user_id);
    $group_options = [];

    $category_selected = false;

    if ('selected' == $selected_id) {
        $group_options[] = [
            'value'    => 'selected',
            'type'     => 7,
            'selected' => true
        ];
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
        $t->assign('access_plugin', $access_plugin);
        $t->assign('plugin_session_name', $plugin_session_name);
        $t->assign('plugin_data_name', $plugin_data_name);
    }


    require_once('grn/ui.csp');
    $manager = GRN_UIConfigManager::getInstance();
    $config = $manager->getUserConfig($login);

    $category_options = [];
    $item_options = [];

    if ($config->getMyGroupPosition() == 'upper') {
        // Myグループを追加する
        _smarty_function_grn_org_select_getMyGroups($login, $selected_id,
            $category_selected, $group_options);
        // よく使う組織を追加する
        _smarty_function_grn_org_select_getOftenusedGroups($login, $selected_id,
            $category_selected, $group_options);
    } else {
        // よく使う組織を追加する
        _smarty_function_grn_org_select_getOftenusedGroups($login, $selected_id,
            $category_selected, $group_options);
        // Myグループを追加する
        _smarty_function_grn_org_select_getMyGroups($login, $selected_id,
            $category_selected, $group_options);
    }

    // 優先する組織を追加する
    $primary_group = $uum->getUserPrimaryGroupInfo($user_id);
    $primary_group_id = '';
    if ($primary_group !== false) {
        $primary_group_id = $primary_group['_id'];
        $primary_group_name = $primary_group['col_name'];

        if ($selected_id == $primary_group_id) {
            $category_selected = true;
            $uum_util->selectGroups($login, [$primary_group_id]);
            $group_options[] = [
                'value'    => $primary_group_id,
                'type'     => 2,
                'name'     => $primary_group_name,
                'selected' => true
            ];
        } else {
            $group_options[] = [
                'value'    => $primary_group_id,
                'type'     => 2,
                'name'     => $primary_group_name,
                'selected' => false
            ];
        }
    }

    // 所属する組織を追加する
    $user_groups = $uum->getUserGroupsInfo($user_id);
    if (is_array($user_groups) && 0 < count($user_groups)) {
        foreach (array_keys($user_groups) as $user_group_id) {
            $user_group_name = $user_groups[$user_group_id]['col_name'];
            if ($primary_group_id == $user_group_id) {
                continue;
            }
            if ($selected_id == $user_group_id) {
                $category_selected = true;
                $uum_util->selectGroups($login, [$user_group_id]);
                $group_options[] = [
                    'value'    => $user_group_id,
                    'type'     => 3,
                    'name'     => $user_group_name,
                    'selected' => true
                ];
            } else {
                $group_options[] = [
                    'value'    => $user_group_id,
                    'type'     => 3,
                    'name'     => $user_group_name,
                    'selected' => false
                ];
            }
        }
    }

    // 最近選択した組織を追加する
    require_once('grn/uum_util.csp');
    $frequent_groups = $uum->getFrequentGroupsInfo($user_id);
    if (is_array($frequent_groups) && 0 < count($frequent_groups)) {
        foreach (array_keys($frequent_groups) as $frequent_group_id) {
            $frequent_group_name
                = $frequent_groups[$frequent_group_id]['col_name'];
            if ($selected_id == $frequent_group_id) {
                $category_selected = true;
                $uum_util->selectGroups($login, [$frequent_group_id]);
                $group_options[] = [
                    'value'    => $frequent_group_id,
                    'type'     => 4,
                    'name'     => $frequent_group_name,
                    'selected' => true
                ];
            } else {
                $group_options[] = [
                    'value'    => $frequent_group_id,
                    'type'     => 4,
                    'name'     => $frequent_group_name,
                    'selected' => false
                ];
            }
        }
    }

    if (array_key_exists('all', $params)) {
        // 全員を追加する
        $value = -1;
        $selected = ($selected_id == $value);
        if ($selected) {
            $category_selected = true;
        }
        $group_options[] = [
            'value'    => $value,
            'type'     => 5,
            'selected' => $selected
        ];
    }

    if ( ! $category_selected && $selected_id > 0
         && ($groupinfo
            = $uum->getGroupInfo($selected_id))
    ) {
        // 選択された組織
        $opt = [
            'value'    => $groupinfo['_id'],
            'type'     => 6,
            'name'     => $groupinfo['col_name'],
            'selected' => true
        ];
        array_unshift($group_options, $opt);
    }

    $t->assign('group_options', $group_options);

    $t->assign('select_style', @$params['select_style']);

    return $t->fetch('grn/org_select_parts.tpl');
}

function _smarty_function_grn_org_select_getMyGroups(
    &$login,
    $selected_id,
    &$category_selected,
    &$group_options
) {
    $uum = cb_lwc_uum();

    $my_groups = $uum->getMyGroupsInfo($login->getOID());
    if (is_array($my_groups) && 0 < count($my_groups)) {
        foreach (array_keys($my_groups) as $my_group_id) {
            $my_group_name = $my_groups[$my_group_id]['col_name'];
            if ($selected_id == 'm' . $my_group_id) {
                $category_selected = true;
                $group_options[] = [
                    'value'    => 'm' . $my_group_id,
                    'type'     => 1,
                    'name'     => $my_group_name,
                    'selected' => true
                ];
            } else {
                $group_options[] = [
                    'value'    => 'm' . $my_group_id,
                    'type'     => 1,
                    'name'     => $my_group_name,
                    'selected' => false
                ];
            }
        }
    }
}

function _smarty_function_grn_org_select_getOftenusedGroups(
    &$login,
    $selected_id,
    &$category_selected,
    &$group_options
) {
    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');

    require_once('grn/uum_util.csp');
    $uum_util = GRN_UumUtil::getInstance();

    $oftenused_groups = $uum->getOftenusedGroupsInfo($login->getOID());
    if (is_array($oftenused_groups) && 0 < count($oftenused_groups)) {
        foreach (array_keys($oftenused_groups) as $oftenused_group_id) {
            $oftenused_group_name
                = $oftenused_groups[$oftenused_group_id]['col_name'];
            if ($selected_id == $oftenused_group_id) {
                $category_selected = true;
                $uum_util->selectGroups($login, [$oftenused_group_id]);
                $group_options[] = [
                    'value'    => $oftenused_group_id,
                    'type'     => 8,
                    'name'     => $oftenused_group_name,
                    'selected' => true
                ];
            } else {
                $group_options[] = [
                    'value'    => $oftenused_group_id,
                    'type'     => 8,
                    'name'     => $oftenused_group_name,
                    'selected' => false
                ];
            }
        }
    }
}



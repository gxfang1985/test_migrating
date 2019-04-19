<?php

/**
 * @name grn_cellular_select_group
 * @description 組織選択の<select>タグ表示
 *
 * @date        2005/03/11
 * @author      T.Tosaka
 *
 * @param  string  name              select name
 *
 * @option      string  selected          selected
 * @option      array   access_plugin     アクセス制限のためのプラグインドライバ名とドライバに引数として渡す連想配列
 * @option      array   option_add        追加するオプションメニューの連想配列
 *
 *  ※１
 *  access_plugin例
 *      array(
 *          'name'   => 'schedule',
 *          'params' => array(
 *              'action' => array( 'read','add' ),
 *          ),
 *      );
 *
 *  ※２
 *  option_add例
 *      array(
 *          'f' => array(
 *              'name' => 'MENU_NAME',
 *              'list' => array(
 *                  'ID1' => 'NAME1',
 *                  'ID2' => 'NAME2',
 *              ),
 *          ),
 *      );
 *
 * {grn_cellular_select_group name="gid" selected=$gid}
 *
 */
function smarty_function_grn_cellular_select_group($params, &$smarty)
{
    $function_name = 'grn_cellular_select_group';

    $uum = cb_lwc_uum();
    $dynamic_roles = $uum->listGrantedRoles();
    $login = &$uum->getLoginUser();
    if ($login == false) {
        return htmlspecialchars($function_name) . ": not logined";
    }

    // アクセス権制御用プラグイン
    $evaluator = null;
    $access_params = null;
    $access_plugin = @ $params['access_plugin'];
    if ( ! is_null($access_plugin)) {
        // プラグイン名
        $plugin_name = $access_plugin['name'];
        // アクセス評価パラメータ
        $access_params = $access_plugin['params'];

        // プラグインドライバを読み込む
        // プラグインドライバはアクセス権評価に用いる
        $loader = new CB_PluginLoader('grn.common.user.select');
        $evaluator =& $loader->loadDriver($plugin_name);
        if ($evaluator === false) {
            $evaluator = null;
        }
    }

    $name = @ $params['name'];

    // 状態
    $select_page = 0;
    $mode = '-';
    $group_id = '';
    $selected = @ $params['selected'];
    if (strlen($selected)) {
        $mode = mb_substr($selected, 0, 1);
        $group_id = mb_substr($selected, 1);
        if (strlen($group_id)) {
            if ( ! strncmp($group_id, '-', 1)) {
                $select_page = mb_substr($group_id, 1) + 0;
                $group_id = '';
                $selected = $mode . '-';
            }
        } else {
            $selected = $mode . '-';
        }
    }

    if ( ! strncmp($mode, '-', 1)) {
        $prefix = ['m', 'b', 'h'];
    } else {
        $prefix = [$mode];
    }

    // location
    require_once('fw/i18n.csp');
    $str_allow = cb_msg('grn.cellular.common', 'group_allow');
    $str_line = cb_msg('grn.cellular.common', 'group_line');
    $str_my = cb_msg('grn.cellular.common', 'my_group_name');
    $str_belonging = cb_msg('grn.cellular.common', 'belonging_group_name');
    $str_frequent_g = cb_msg('grn.cellular.common', 'frequent_group_name');
    $str_frequent_u = cb_msg('grn.cellular.common', 'frequent_user_name');
    $str_tree = cb_msg('grn.cellular.common', 'tree_group_name');
    $str_root = cb_msg('grn.cellular.common', 'tree_root_name');

    $menu_list = [];
    // 優先する組織
    $primary_group = $uum->getUserPrimaryGroupInfo($login->getOID());
    if ($primary_group !== false) {
        $menu_list['p' . $primary_group['_id']] = $primary_group['col_name'];
    }
    $menu_list['u0'] = $str_frequent_u;
    $menu_list['m'] = $str_allow . $str_my;
    $menu_list['b'] = $str_allow . $str_belonging;
    $menu_list['h'] = $str_allow . $str_frequent_g;
    $menu_list['g'] = $str_allow . $str_tree;

    // 追加メニュー
    $option_add = @ $params['option_add'];
    if (is_array($option_add) && count($option_add)) {
        foreach ($option_add as $_prefix => $_add) {
            $menu_list[$_prefix] = $str_allow . $_add['name'];
            if (is_array($_add['list']) && count($_add['list'])) {
                if ( ! strncmp($mode, '-', 1)) {
                    array_push($prefix, $_prefix);
                }
            }
        }
    }

    $chunk_num = 30 - count($menu_list) - 2;
    $chunk_list = [];
    $page = 0;
    $tree = "";
    foreach ($prefix as $_prefix) {
        switch ($_prefix) {
            case 'm':
                // Myグループ
                if ($chunk_num - count($chunk_list[$page]) <= 1) {
                    $page++;
                }
                $chunk_list[$page]['m-'] = $str_line . $str_my;
                $my_groups
                    = $uum->getMyGroupsInfo($login->getOID());
                if ( ! is_null($my_groups)) {
                    foreach ($my_groups as $_group) {
                        if ($chunk_num - count($chunk_list[$page]) < 1) {
                            $page++;
                            $chunk_list[$page]['m-'] = $str_line . $str_my;
                        }
                        $chunk_list[$page]['m' . $_group['_id']]
                            = $_group['col_name'];
                    }
                }
                break;
            case 'b':
                // 所属する組織
                if ($chunk_num - count($chunk_list[$page]) <= 1) {
                    $page++;
                }
                $chunk_list[$page]['b-'] = $str_line . $str_belonging;
                $belonging_groups
                    = $uum->getUserGroupsInfo($login->getOID());
                if ( ! is_null($evaluator)) {
                    // アクセス権
                    $belonging_groups
                        = $evaluator->evalGroups($belonging_groups,
                        $access_params, true);
                }
                if ( ! is_null($belonging_groups)) {
                    foreach ($belonging_groups as $_group) {
                        if ($chunk_num - count($chunk_list[$page]) < 1) {
                            $page++;
                            $chunk_list[$page]['b-'] = $str_line
                                                       . $str_belonging;
                        }
                        $chunk_list[$page]['b' . $_group['_id']]
                            = $_group['col_name'];
                    }
                }
                break;
            case 'h':
                // 最近選択した組織
                if ($chunk_num - count($chunk_list[$page]) <= 1) {
                    $page++;
                }
                $chunk_list[$page]['h-'] = $str_line . $str_frequent_g;
                $frequent_groups
                    = $uum->getFrequentGroupsInfo($login->getOID());
                if ( ! is_null($evaluator)) {
                    // アクセス権
                    $frequent_groups = $evaluator->evalGroups($frequent_groups,
                        $access_params, true);
                }
                if ( ! is_null($frequent_groups)) {
                    $frequent_groups = array_slice($frequent_groups, 0, 10);
                    foreach ($frequent_groups as $_group) {
                        if ($chunk_num - count($chunk_list[$page]) < 1) {
                            $page++;
                            $chunk_list[$page]['h-'] = $str_line
                                                       . $str_frequent_g;
                        }
                        $chunk_list[$page]['h' . $_group['_id']]
                            = $_group['col_name'];
                    }
                }
                break;
            case 'g':
                // 組織図から選択
                if ($chunk_num - count($chunk_list[$page]) <= 1) {
                    $page++;
                }
                $chunk_list[$page]['g-'] = $str_line . $str_tree;
                if (strlen($group_id)) {
                    $group =& $uum->getGroup($group_id);
                    $pgroup =& $group->get('parent');
                    if ($pgroup) {
                        $merge_param = [
                            'page'    => cb_get_pagename(),
                            'caption' => $pgroup->get('name'),
                            $name     => $_prefix . $pgroup->getOID()
                        ];
                    } else {
                        $merge_param = [
                            'page'    => cb_get_pagename(),
                            'caption' => $str_root,
                            $name     => 'g-'
                        ];
                    }
                    global $G_INPUT;
                    $link_param = array_merge($G_INPUT, $merge_param);
                    require_once($smarty->_get_plugin_filepath('function',
                        'grn_cellular_link'));
                    $tree .= smarty_function_grn_cellular_link($link_param,
                        $smarty);
                    $tree .= "<br>-> ";
                    $tree .= htmlspecialchars($group->get('name')) . "<br>";
//                $tree .= $group->get( 'name' ) ."<br>";
                    $child_groups = $uum->getChildGroupsInfo($group_id);
                } else {
                    $child_groups = $uum->getChildGroupsInfo(null);
                }

                if ( ! is_null($evaluator)) {
                    // アクセス権
                    $child_groups = $evaluator->evalGroups($child_groups,
                        $access_params, true);
                }

                if ( ! is_null($child_groups)) {
                    foreach ($child_groups as $_group) {
                        if ($chunk_num - count($chunk_list[$page]) < 1) {
                            $page++;
                            $chunk_list[$page]['g-'] = $str_line . $str_tree;
                        }
                        $chunk_list[$page]['g' . $_group['_id']]
                            = $_group['col_name'];
                    }
                }
                $selected = 'g-';
                break;
            default:
                if (array_key_exists($_prefix, $option_add)) {
                    $_option = &$option_add[$_prefix];
                    if (is_array($_option['list']) && count($_option['list'])) {
                        if ($chunk_num - count($chunk_list[$page]) <= 1) {
                            $page++;
                        }
                        $chunk_list[$page][$_prefix . '-'] = $str_line
                                                             . $_option['name'];
                        foreach ($_option['list'] as $_id => $_name) {
                            if ($chunk_num - count($chunk_list[$page]) < 1) {
                                $page++;
                                $chunk_list[$page][$_prefix . '-'] = $str_line
                                                                     . $_option['name'];
                            }
                            $chunk_list[$page][$_prefix . $_id] = $_name;
                        }
                    }
                }
                break;
        }
    }

    // タグ生成
    $tag = "<select name=\"" . htmlspecialchars($name) . "\">\n";
    foreach ($menu_list as $_value => $_name) {
        $tag .= "<option value=\"" . $_value . "\"";
        $tag .= ($_value == $selected) ? " selected" : "";
        $tag .= ">" . htmlspecialchars($_name) . "</option>\n";
    }
    if ($select_page) {
        //前へ
        $_value = $mode . '-' . ($select_page - 1);
        $_name = cb_msg('grn.cellular.common', 'selectbox_back');
        $tag .= "<option value=\"" . $_value . "\">"
                . htmlspecialchars($_name) . "</option>\n";
    }
    if (count($chunk_list)) {
        foreach ($chunk_list[$select_page] as $_value => $_name) {
            $tag .= "<option value=\"" . $_value . "\"";
            $tag .= ($_value == $selected) ? " selected" : "";
            $tag .= ">" . htmlspecialchars($_name) . "</option>\n";
        }
    }
    if (count($chunk_list[$select_page + 1])) {
        //次へ
        $_value = $mode . '-' . ($select_page + 1);
        $_name = cb_msg('grn.cellular.common', 'selectbox_next');
        $tag .= "<option value=\"" . $_value . "\">"
                . htmlspecialchars($_name) . "</option>\n";
    }
    $tag .= "</select>\n";

    return $tree . $tag;
}


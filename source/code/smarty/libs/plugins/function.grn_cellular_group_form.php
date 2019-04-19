<?php

/**
 * @name grn_cellular_group_form
 * @description 組織選択の<form><select>タグ表示
 *
 * @date        2006/03/11
 * @author      T.Tosaka
 *
 * @param  string  method            form method
 * @param  string  page              the page name
 *
 * @option      array   params            hidden parameters
 *
 * @param  string  selected          selected
 *
 * @option      array   access_plugin     アクセス制限のためのプラグインドライバ名とドライバに引数として渡す連想配列
 * @option      array   option_list       組織以外のselectメニューを表示する場合
 *
 *  access_plugin例
 *      array(
 *          'name'   => 'schedule',
 *          'params' => array(
 *              'action' => array( 'read','add' ),
 *          ),
 *      );
 *
 *  option_list例
 *      array(
 *          'ID1' => 'NAME1',
 *          'ID2' => 'NAME2',
 *      );
 *
 * {grn_cellular_group_form selected=$gid}
 *
 */
function smarty_function_grn_cellular_group_form($params, &$smarty)
{
    $function_name = 'grn_cellular_group_form';

    $uum = cb_lwc_uum();
    $dynamic_roles = $uum->listGrantedRoles();
    $login = &$uum->getLoginUser();
    if ($login == false) {
        return htmlspecialchars($function_name) . ": not logined";
    }

    // 状態
    $prefix = 'g';
    $group_id = '';
    $paging = false;
    $page = 0;
    $selected = @ $params['selected'];
    if (strlen($selected)) {
        if (($p = strpos($selected, ':')) !== false) {
            $paging = true;
            $page = substr($selected, $p + 1);
            if ( ! strlen($page)) {
                $page = 0;
            }
            $selected = substr($selected, 0, $p);
        }

        if (strlen($selected)) {
            $prefix = substr($selected, 0, 1);
            if ( ! is_numeric($prefix)) {
                $group_id = substr($selected, 1);
                if ($group_id == false && $prefix == 'f') {
                    $selected = 'f0';
                }
            } else {
                $prefix = 'g';
                $group_id = $selected;
                $selected = $prefix . $selected;
            }
        }
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

    // 代替のoption
    $option_list = @ $params['option_list'];

    require_once('fw/i18n.csp');

    $chunk_num = 20;
    $prefix_list = [];
    $chunk_list = [];
    switch ($prefix) {
        case 'm':
            // Myグループ
            $page_name = cb_at($params, 'page');
            if (isShowAllMygroupOnMyGroupUserSelection($page_name)) {
                $my_groups = $uum->getMyGroupsInfo($login->getOID());
            } else {
                $my_groups = $uum->getMyGroupsInfo($login->getOID(), 'user');
            }
            if ( ! is_null($my_groups)) {
                foreach ($my_groups as $_group) {
                    $chunk_list['m' . $_group['_id']] = $_group['col_name'];
                }
            }
            break;
        case 'b':
            // 所属する組織
            $belonging_groups = $uum->getUserGroupsInfo($login->getOID());
            if ( ! is_null($evaluator)) {
                // アクセス権
                $belonging_groups = $evaluator->evalGroups($belonging_groups,
                    $access_params, true);
            }
            if ( ! is_null($belonging_groups)) {
                foreach ($belonging_groups as $_group) {
                    $chunk_list['b' . $_group['_id']] = $_group['col_name'];
                }
            }
            break;
        case 'h':
            // 最近選択した組織
            $frequent_groups = $uum->getFrequentGroupsInfo($login->getOID());
            if ( ! is_null($evaluator)) {
                // アクセス権
                $frequent_groups = $evaluator->evalGroups($frequent_groups,
                    $access_params, true);
            }
            if ( ! is_null($frequent_groups)) {
                $frequent_groups = array_slice($frequent_groups, 0, 10);
                foreach ($frequent_groups as $_group) {
                    $chunk_list['h' . $_group['_id']] = $_group['col_name'];
                }
            }
            break;
        case 'g':
            // 組織図から選択
            if (strlen($group_id) && $group_id > 0) {
                $prefix_list['g'] = cb_msg('grn.cellular.common',
                    'selectbox_root', [
                        'rootname' => cb_msg('grn.cellular.common',
                            'group_rootname')
                    ]);
                $group =& $uum->getGroup($group_id);
                $pgroup =& $group->get('parent');
                if ($pgroup) {
                    $prefix_list['g' . $pgroup->getOID()]
                        = cb_msg('grn.cellular.common', 'selectbox_up');
                }
                $prefix_list['g' . $group->getOID()] = $group->get('name');
                $child_groups
                    = $uum->getChildGroupsInfo($group_id);
            } else {
                //root
                $prefix_list['g'] = cb_msg('grn.cellular.common',
                    'group_rootname');
                $child_groups = $uum->getChildGroupsInfo(null);
            }

            if ( ! is_null($evaluator)) {
                // アクセス権
                $child_groups = $evaluator->evalGroups($child_groups,
                    $access_params, true);
            }

            if ( ! is_null($child_groups)) {
                foreach ($child_groups as $_group) {
                    $chunk_list['g' . $_group['_id']] = $_group['col_name'];
                }
            }
            break;
        case 'o':
            // よく使う組織から選択
            require_once("grn/history.csp");
            $group_history = GRN_Uum_HistoryManager::getInstance();

            $chunk_group_ids
                = $group_history->getOftenusedGroups($login->getOID());
            $chunk_groups = $uum->getGroupInfoList($chunk_group_ids);
            if ( ! is_null($evaluator)) {
                $chunk_groups = $evaluator->evalGroups($chunk_groups,
                    $access_params, true);
            }

            foreach ($chunk_group_ids as $id) {
                $chunk_list['o' . $id] = $chunk_groups[$id]['col_name'];
            }
            break;
        default:
            if (is_array($option_list) && count($option_list)) {
                $chunk_list =& $option_list;
            }
            break;
    }

    $option_array = [];
    if (count($prefix_list)) {
        $option_array = array_merge($option_array, $prefix_list);
    }

    // chunk部分のリスト
    $prev = null;
    $next = null;
    if (count($chunk_list) > $chunk_num) {
        $_chunk = array_chunk($chunk_list, $chunk_num, true);
        if ( ! $paging) {
            // ページングが発生してない(':'が付いてない)時だけ、選択されたページを探す
            if (strlen($selected)) {
                foreach ($_chunk as $_page => $_groups) {
                    if (array_key_exists($selected, $_groups)) {
                        $page = $_page;
                    }
                }
            }
        }
        if (array_key_exists($page - 1, $_chunk)) {
            $tmp = [];
            $tmp[$selected . ':' . ($page - 1)] = cb_msg('grn.cellular.common',
                'selectbox_back');
            $option_array = array_merge($option_array,
                $tmp);
        }
        $option_array = array_merge($option_array, $_chunk[$page]);
        if (array_key_exists($page + 1, $_chunk)) {
            $tmp = [];
            $tmp[$selected . ':' . ($page + 1)] = cb_msg('grn.cellular.common',
                'selectbox_next');
            $option_array = array_merge($option_array,
                $tmp);
        }
    } else {
        $option_array = array_merge($option_array, $chunk_list);
    }

    //リストformの生成
    if (count($option_array)) {
        // form
        $form_params = [];
        $form_params['method'] = $params['method'];
        $form_params['page'] = $params['page'];
        $form_params['params'] = @ $params['params'];
        require_once($smarty->_get_plugin_filepath('function',
            'grn_cellular_form'));
        $out = smarty_function_grn_cellular_form($form_params, $smarty);

        // select
        $out .= "<select name=\"gid\">\n";
        foreach ($option_array as $_value => $_name) {
            if (is_array($_name)) {
                if ($_name['extra_param'] == 1 || $_name['extra_param'] == 2) {
                    $out .= "<option value=\"" . htmlspecialchars($_name['id'])
                            . "_" . htmlspecialchars($_name['extra_param'])
                            . "\"";
                    $str = $_name['id'] . "_" . $_name['extra_param'];
                } else {
                    $out .= "<option value=\"" . htmlspecialchars($_name['id'])
                            . "\"";
                    $str = $_name['id'];
                }
                if ($_name['extra_param'] != '-') {
                    $out .= ($str == $selected) ? " selected" : "";
                }
                $out .= ">" . htmlspecialchars($_name['name']) . "</option>\n";
            } else {
                $out .= "<option value=\"" . htmlspecialchars($_value) . "\"";
                $out .= ($_value == $selected) ? " selected" : "";
                $out .= ">" . htmlspecialchars($_name) . "</option>\n";
            }
        }
        $out .= "</select><br>\n";

        // submit
        $accesskey = 1;
        if (array_key_exists('accesskey', $params)) {
            $accesskey = $params['accesskey'];
        }
        $submit_params = [];
        $submit_params['name'] = 'GO';
        $submit_params['accesskey'] = $accesskey;
        $submit_params['caption'] = cb_msg('grn.cellular.common',
            'submit_move');
        require_once($smarty->_get_plugin_filepath('function',
            'grn_cellular_submit'));
        $out .= smarty_function_grn_cellular_submit($submit_params, $smarty);

        // /form
        $out .= "</form>\n";

    } else {
        // リストが無い場合
        $out = cb_msg('grn.cellular.common', 'group_nothing');

    }

    return $out;
}


function isShowAllMygroupOnMyGroupUserSelection($page_name)
{
    $list_screen_support_my_group = [
        'schedule/cellular/day_gr',
        'address/cellular/list',
    ];

    if (array_search($page_name, $list_screen_support_my_group) !== false) {
        return true;
    }

    return false;
}

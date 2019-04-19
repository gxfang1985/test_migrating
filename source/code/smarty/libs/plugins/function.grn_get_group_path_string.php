<?php

/**
 * @name grn_get_group_path_string
 * @description 識別子をもとにユーザー名/組織名の上位組織から経路を取得
 *
 * @date        2011/01/13
 * @author      Zhang.bingxia
 *
 * @param string eid 識別子付きのID(識別子:ユーザID=u　組織ID=o)
 *
 * Examples;
 * {grn_get_group_path_string eid='u_1'}
 * {grn_get_group_path_string eid='o_1'}
 */
function smarty_function_grn_get_group_path_string($params, &$smarty)
{
    $function_name = "grn_get_group_path_string";

    //-- get parameters
    if (array_key_exists('eid', $params)) {
        $eid = $params['eid'];
        assert('strlen($eid) > 2');
    } else {
        return htmlspecialchars($function_name) . ": \$eid is required";
    }

    if (array_key_exists('users_info', $params)
        && is_array($params['users_info'])
    ) {
        $users_info = $params['users_info'];
    } else {
        $users_info = [];
    }

    $prefix = substr($eid, 0, 2);
    $id = substr($eid, 2);
    $group_path = "";

    global $G_container_base;
    $uum =& $G_container_base->getInstance('uum');
    require_once('grn/uum_util.csp');
    $uum_util = GRN_UumUtil::getInstance();

    switch ($prefix) {
        case 'u_':
            if ($id) {
                if (array_key_exists($id, $users_info)) {
                    $primary_group = $users_info[$id]['primary_group'];
                } else {
                    $primary_group = $uum->getUserPrimaryGroupInfo($id);
                }
                if ($primary_group !== false) {
                    $group_path
                        = $uum_util->getGroupPathString($primary_group['_id'],
                        ' > ');
                    if ( ! $group_path || null == $group_path) {
                        $group_path = "";
                    }
                }
            }
            if ($group_path) {
                return "<p class='group_path_info'>"
                       . htmlspecialchars($group_path) . "</p>";
            } else {
                return htmlspecialchars($group_path);
            }

        case 'o_':
            if ($id) {
                $group_path = $uum_util->getGroupPathString($id, ' > ');
                if ( ! $group_path || null == $group_path) {
                    $group_path = "";
                }
            }
            if ($group_path) {
                return "<p class='group_path_info'>"
                       . htmlspecialchars($group_path) . "</p>";
            } else {
                return htmlspecialchars($group_path);
            }
    }


    return htmlspecialchars($function_name) . ": \$eid is not valid";
}


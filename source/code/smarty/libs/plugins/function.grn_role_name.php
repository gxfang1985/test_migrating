<?php
/**
 * @name   grn_role_name
 *  組織名表示
 *
 * @date   2004/10/29
 * @author KAMBE,Shinichi
 * @date   11/17/2004
 * @author M.Oomori
 *
 * @param  string  rid         ロールID
 *
 */

function smarty_function_grn_role_name($params, &$smarty)
{
    //-- function name
    $function_name = 'grn_role_name';

    if (array_key_exists('rid', $params)) {
        $rid = $params['rid'];
    } else {
        $rid = null;
    }

    if (array_key_exists('name', $params) && $params['name']) {
        $role_name = $params['name'];
    } elseif (array_key_exists('current_name', $params)
              && $params['current_name']
    ) {
        $role_name = $params['current_name'];
    } else {
        $role_name = null;
    }

    if ($rid) {
        if ($rid != 'Everyone' && $rid != 'LoginUser' && is_null($role_name)) {
            $uum = cb_lwc_uum();
            $role = $uum->getStaticRole($rid);
            if ($role) {
                $role_name = $role->get('foreign_key');
            }
        } else {
            $role_name = $rid;
        }
    }

    if (is_null($role_name)) {
        $role_name = '';
    }

    return htmlspecialchars($role_name);
}


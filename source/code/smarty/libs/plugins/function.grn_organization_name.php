<?php

use grn\system\sandbox\GRN_Uum_Sandbox;

/**
 * @name   grn_organize_name 組織名表示
 * @date   2004/10/29
 * @author KAMBE,Shinichi
 * @date   2004/10/31
 * @author M.Oomori
 *
 * @param  string  organization_id         組織ID
 *
 * @return string
 */

function smarty_function_grn_organization_name($params, &$smarty)
{
    $function_name = "grn_organization_name";

    $organization_id = $params['organization_id'];
    if (is_null($organization_id)) {
        return htmlspecialchars($function_name) . ': $organization_id is null';
    }

    if ($organization_id == 0) {
        return cb_msg('grn.common', 'root_group');
    }

    if (cb_at($params, "is_sandbox_page") === true) {
        $uum = GRN_Uum_Sandbox::getInstance();
    } else {
        global $G_container_base;
        $uum = $G_container_base->getInstance('uum');
    }

    $the_organization = $uum->getGroup($organization_id);
    if ($the_organization == false) {
        return htmlspecialchars($function_name)
               . ': $organization_id is not valid';
    }
    $return_string = $the_organization->get('name');

    return htmlspecialchars($return_string);
}


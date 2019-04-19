<?php

function smarty_function_grn_workflow_member_name($params, &$smarty)
{
    $member_id = null;
    if (array_key_exists('id', $params)) {
        $member_id = $params['id'];
    }
    $type = null;
    if (array_key_exists('type', $params)) {
        $type = $params['type'];
    }
    $chief = false;
    if (array_key_exists('infos', $params)) {
        if (array_key_exists('col_member', $params['infos'])) {
            $member_id = $params['infos']['col_member'];
        }
        if (array_key_exists('type', $params['infos'])) {
            $type = $params['infos']['type'];
        }
        if (array_key_exists('col_chief', $params['infos'])) {
            $chief = $params['infos']['col_chief'];
        }
    }

    require_once($smarty->_get_plugin_filepath('function', 'grn_user_name'));
    require_once($smarty->_get_plugin_filepath('function',
        'grn_organize_name'));
    require_once($smarty->_get_plugin_filepath('function', 'grn_role_name'));
    require_once($smarty->_get_plugin_filepath('function', 'grn_image'));

    switch ($type) {
        case 'skip':
            $params['image'] = 'nouser20.gif';
            $prefix = smarty_function_grn_image($params, $smarty);

            return $prefix . cb_msg('grn.workflow', 'skip');
        case 'user':
            $params['uid'] = $member_id;

            return smarty_function_grn_user_name($params, $smarty);
        case 'group':
            $params['gid'] = $member_id;

            return smarty_function_grn_organize_name($params, $smarty);
        case 'applicant':
            $params['image'] = 'role20.gif';
            $prefix = smarty_function_grn_image($params, $smarty);

            return $prefix . cb_msg('grn.workflow', 'applicant');
        case 'dynamic_role':
            $params['image'] = 'role20.gif';
            $prefix = smarty_function_grn_image($params, $smarty);

            return $prefix . htmlspecialchars($member_id);
        case 'static_role':
            $params['image'] = 'role20.gif';
            $params['rid'] = $member_id;
            $prefix = smarty_function_grn_image($params, $smarty);
            $suffix = null;
            if ($chief) {
                $suffix = cb_msg('grn.workflow', 'chief');
            }

            return $prefix . smarty_function_grn_role_name($params, $smarty)
                   . $suffix;
        default:
            break;
    }
}



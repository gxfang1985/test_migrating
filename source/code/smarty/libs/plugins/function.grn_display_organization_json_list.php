<?php

function smarty_function_grn_display_organization_json_list($params, &$smarty)
{
    require_once $smarty->_get_plugin_filepath('modifier', 'escape');

    $group_list = @ $params['group_list'];
    if ( ! $group_list) {
        $group_list = [];
    }

    $ret = [];
    foreach ($group_list as $group) {
        $id = smarty_modifier_escape($group['id'], 'javascript');
        $name = smarty_modifier_escape(smarty_modifier_escape($group['name']),
            'javascript');

        $is_selected = isset($group['is_selected']) ? $group['is_selected']
            : null;
        $is_selected = smarty_modifier_escape($is_selected, 'javascript');

        $extra_param = isset($group['extra_param']) ? $group['extra_param']
            : null;
        $extra_param = smarty_modifier_escape($extra_param, 'javascript');

        $type = isset($group['type']) ? $group['type'] : null;

        $ret[]
            = sprintf('{"id":"%s", "name":"%s", "is_selected":"%s", "extra_param":"%s", "type":"%s"}',
            $id, $name, $is_selected, $extra_param, $type);
    }

    return implode(',', $ret);
}

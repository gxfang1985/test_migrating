<?php

function smarty_function_grn_display_facilitygroup_json_list($params, &$smarty)
{
    require_once $smarty->_get_plugin_filepath('modifier', 'escape');

    $fgroup_list = isset($params['fgroup_list']) ? $params['fgroup_list']
        : null;
    $selected_oid = isset($params['selected_oid']) ? $params['selected_oid']
        : null;
    if ( ! $fgroup_list) {
        $fgroup_list = [];
    }

    $ret = [];
    foreach ($fgroup_list as $fgroup) {
        $oid = smarty_modifier_escape($fgroup['oid'], 'javascript');
        $name = smarty_modifier_escape(smarty_modifier_escape($fgroup['name']),
            'javascript');
        if (array_key_exists('is_selected', $fgroup)) {
            $is_selected = smarty_modifier_escape($fgroup['is_selected'],
                'javascript');
        } else {
            $is_selected = $fgroup['oid'] == $selected_oid ? 1 : 0;
        }
        $extra_param = smarty_modifier_escape($fgroup['extra_param'],
            'javascript');
        $count = smarty_modifier_escape($fgroup['count'], 'javascript');

        $children = [];
        $tmp_node = [
            'fgroup_list'  => $fgroup['children'],
            'selected_oid' => $selected_oid
        ];
        $children[]
            = smarty_function_grn_display_facilitygroup_json_list($tmp_node,
            $smarty);

        $expanded = $fgroup['expanded'] ? 'true' : 'false';

        $children = implode(',', $children);

        $ret[]
            = sprintf('{"oid":"%s", "name":"%s", "is_selected":"%s", "extra_param":"%s", "count":"%s", "expanded":%s, "children":%s}',
            $oid, $name, $is_selected, $extra_param, $count, $expanded,
            $children);
    }

    return '[' . implode(',', $ret) . ']';
}


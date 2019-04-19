<?php
/**
 * @name   grn_mobile_group_select
 * @description
 *   show the all group tree
 *
 * @param  string  data                group tree data
 *
 *  e.g.)
 *   {grn_mobile_group_select data=Array}
 */

use grn\grn\Validate;

function _grn_mobile_group_tree_internal(
    $group_tree,
    $group_id,
    $smarty,
    $deep,
    $oid_key,
    $radio_name = '',
    $prefix_id = '',
    $prefix_before_value = ''
) {
    $name = $group_tree['name']; // Folder name
    $expanded = $group_tree['expanded']; // Whether folder is expanded.
    $parent = $group_tree['parent']; // Folder's parent id
    $children_count = $group_tree['count']; // Folder's children count.
    $padding_left = $deep * 8;

    $group_icon = '';
    if ($children_count > 0) {
        if ($expanded) {
            $group_icon = "mobile_folderlist_icon_arrowopen_grn";
        } else {
            $group_icon = "mobile_folderlist_icon_arrowclose_grn";
        }
    }

    $return_string = '<li id="' . $prefix_id . 'parent_child_'
                     . $prefix_before_value . $parent . '_'
                     . $prefix_before_value . $group_id
                     . '" data-icon="false" style="padding-left:'
                     . $padding_left . 'px !important;">';
    if (strlen($group_icon) > 0) {
        $return_string .= '<div id="' . $prefix_id . $prefix_before_value
                          . $group_id . '" style="margin-left:' . $padding_left
                          . 'px !important;" class="' . $group_icon
                          . ' mobile_folderlist_icon_grn mobile_folderlist_icon_size_grn"></div>';
    }
    $return_string .= '<a href="#" class="mobile_folderlist_list_text_grn">';
    $return_string .= '<span id="' . $prefix_id . 'deepth_' . $deep . '_'
                      . $group_id
                      . '" class="mobile_folderlist_text_overflow_grn">'
                      . htmlspecialchars($name) . '</span>';
    $return_string .= '</a>';
    $return_string .= '<div><span class="mobile_groupselect_icon_radiobuttonoff_grn"></span><span class="mobile_groupselect_radiobutton_grn"><input name="'
                      . $radio_name . '" type="radio" value="'
                      . $prefix_before_value . $group_id . '"></span></div>';
    $return_string .= "</li>";


    if (array_key_exists('children', $group_tree)) {
        $children = $group_tree['children'];
        $deep = $deep + 1;
        foreach ($children as $id => $sub_tree) {
            $return_string .= _grn_mobile_group_tree_internal($sub_tree, $id,
                $smarty, $deep, $oid_key, $radio_name, $prefix_id,
                $prefix_before_value);
        }
    }

    return $return_string;
}

function smarty_function_grn_mobile_group_select($params, &$smarty)
{
    require_once($smarty->_get_plugin_filepath('function', 'grn_pageurl'));

    //-- function name
    $function_name = 'grn_mobile_group_select';


    //-- parameters
    $tree_data = cb_at($params, 'data');
    $root = cb_at($tree_data, 'root'); // Tree data
    $oid_key = cb_at($tree_data, 'oid_key'); // Oid key name
    $radio_name = cb_at($params, 'radio_name'); // radio name
    $prefix_id = cb_at($params, 'prefix_id');
    $prefix_before_value = cb_at($params,
        'prefix_before_value'); // prefix before value. Ex: group id of user = '1', prefix = 'g' => value = 'g1'
    // max length of prefix before value is 1
    $user = cb_at($params, 'user'); // user group or not
    $facility = cb_at($params, 'facility'); // facility group or not
    $allow_all_facilities = cb_at($params, 'allow_all_facilities');

    if (Validate::isNull($oid_key)) {
        $oid_key = 'oid';
    }

    $login_user = cb_get_login_user();
    if ( ! $login_user) {
        return htmlspecialchars($function_name) . ': not logined';
    }

    $deep = 0;
    $return_string = '';
    if (Validate::isNotNull($root) && is_array($root)) {
        foreach ($root as $group_id => $group_sub_tree) {
            $return_string .= _grn_mobile_group_tree_internal($group_sub_tree,
                $group_id, $smarty, $deep, $oid_key, $radio_name, $prefix_id,
                $prefix_before_value);
        }
    }

    if ($facility) {
        $unCategorizedFacilities = [
            'name' => cb_msg('grn.grn', 'GRN_GRN-1137')
        ];
        $return_string .= _grn_mobile_group_tree_internal($unCategorizedFacilities,
            -2, $smarty, 0, $oid_key, $radio_name, $prefix_id, '');

        if ($allow_all_facilities) {
            $allFacilities = ['name' => cb_msg('grn.grn', 'GRN_GRN-1138')];
            $return_string .= _grn_mobile_group_tree_internal($allFacilities,
                -3, $smarty, 0, $oid_key, $radio_name, $prefix_id, '');
        }
    }
    if ($user) {
        $unAssignGroup = ['name' => cb_msg('grn.grn', 'GRN_GRN-1136')];
        $return_string .= _grn_mobile_group_tree_internal($unAssignGroup, -2,
            $smarty, 0, $oid_key, $radio_name, $prefix_id, '');
    }

    return $return_string;
}


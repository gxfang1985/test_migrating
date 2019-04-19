<?php
/**
 * @name   grn_mobile_folder_tree
 * @description
 *   show the all folder tree of mail application
 *
 * @param  string  data                folder tree data
 *
 *  e.g.)
 *   {grn_mobile_folder_tree data=Array}
 */

use grn\grn\Validate;

function _grn_mobile_folder_tree_internal(
    $folder_tree,
    $folder_id,
    $smarty,
    $deep,
    $oid_key,
    $link_url,
    $link_url_params
) {
    $name = $folder_tree['name']; // Folder name
    $unread_num = cb_at($folder_tree, 'unread', 0); // Folder unread number
    $expanded = $folder_tree['expanded']; // Whether folder is expanded.
    $parent = $folder_tree['parent']; // Folder's parent id
    $children_count = $folder_tree['count']; // Folder's children count.
    $url = cb_at($folder_tree, 'link_url'); // Folder link url.
    $folder_icon = cb_at($folder_tree,
        'folder_icon_class'); // Folder icon class.
    $padding_left = $deep * 8;

    if ( ! $url) {
        if ( ! is_array($link_url_params)) {
            $link_url_params = [];
        }
        $link_url_params[$oid_key] = $folder_id;
        $url
            = smarty_function_grn_pageurl(array_merge(['page' => $link_url],
            $link_url_params), $smarty); //Application general link.
    }

    if ($children_count > 0) {
        if ($expanded) {
            $folder_icon = "mobile_folderlist_icon_arrowopen_grn";
        } else {
            $folder_icon = "mobile_folderlist_icon_arrowclose_grn";
        }
    }
    if (is_null($folder_icon)) {
        $folder_icon = "";
    }
    $return_string = "<li id=\"parent_child_" . $parent . "_" . $folder_id
                     . "\" data-icon=\"false\" style=\"padding-left: "
                     . $padding_left . "px !important;\">";
    $return_string .= "<div id=\"" . $folder_id . "\" style=\"margin-left: "
                      . $padding_left . "px !important;\" class=\""
                      . $folder_icon
                      . " mobile_folderlist_icon_grn mobile_folderlist_icon_size_grn\"";
    if ($children_count == 0) {
        $return_string .= " onclick=\"location.href='" . $url . "'\"";
    }
    $return_string .= "></div>";
    $return_string .= "<a href=\"" . $url
                      . "\" class=\"mobile_folderlist_list_text_grn\">";
    $return_string .= "<span id=\"deepth_" . $deep . "_" . $folder_id
                      . "\" class=\"mobile_folderlist_text_overflow_grn\">"
                      . htmlspecialchars($name) . "</span>";
    if ($unread_num > 0) {
        $return_string .= "<span class=\"mobile_notify_sum_grn\">" . $unread_num
                          . "</span>";
    }
    $return_string .= "<span class=\"mobile_folderlist_icon_arraylist_grn\"></span>";
    $return_string .= "</a>";
    $return_string .= "</li>";


    if (array_key_exists('children', $folder_tree)) {
        $children = $folder_tree['children'];
        $deep = $deep + 1;
        foreach ($children as $id => $sub_tree) {
            $return_string .= _grn_mobile_folder_tree_internal($sub_tree, $id,
                $smarty, $deep, $oid_key, $link_url, $link_url_params);
        }
    }

    return $return_string;
}

function smarty_function_grn_mobile_folder_tree($params, &$smarty)
{
    require_once($smarty->_get_plugin_filepath('function', 'grn_pageurl'));

    //-- function name
    $function_name = 'grn_mobile_folder_tree';


    //-- parameters
    $tree_data = cb_at($params, 'data');

    $root = cb_at($tree_data, 'root'); // Tree data
    $oid_key = cb_at($tree_data, 'oid_key'); // Oid key name
    $link_url = cb_at($tree_data,
        'link_url'); // Application general link url
    $link_url_params = cb_at($tree_data,
        'link_url_params'); // Application general link parameters

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
        foreach ($root as $folder_id => $folder_sub_tree) {
            $return_string .= _grn_mobile_folder_tree_internal($folder_sub_tree,
                $folder_id, $smarty, $deep, $oid_key, $link_url,
                $link_url_params);
        }
    }

    return $return_string;
}


<?php
/**
 * @name   grn_memo_folder_tree
 * @description
 *   show the all folder tree of message application
 *   you can select 1 folder, and can specify url on link
 *
 * @date   12/30/2004
 * @author M.Oomori
 * @auther Eiji TAEN
 *
 * @param  string  selected_folder_id  the selected folder id
 * @param  string  var_name            the variable name which has folder id
 * @param  string  rest_params         parameters other than page, $var_name for links
 *
 *  eg.)
 *   {grn_message_folder_tree selected_folder_id=3 var_name='fid'}
 */

function _grn_memo_folder_tree_internal($node, & $result, $var_name, &$smarty)
{
    $focus = false;
    if (array_key_exists('selected', $node) && $node['selected']) {
        $focus = true;
    }

    $result .= smarty_function_grn_structure_link(
        [
            'page'    => 'memo/index',
            'caption' => $node['name'],
            'image'   => 'folder20.gif',
            'focus'   => $focus,
            $var_name => $node['id'],
        ],
        $smarty);

    if (array_key_exists('child_count', $node) && $node['child_count'] > 0) {
        $result .= "<div class=\"parent\">\n";

        foreach ($node['children'] as $id => $child) {
            $result .= "<div class=\"child\">\n";
            _grn_memo_folder_tree_internal($child, $result, $var_name, $smarty);
            $result .= "</div>";

        }
        $result .= "</div>";
    }
}

function smarty_function_grn_memo_folder_tree($params, &$smarty)
{
    require_once($smarty->_get_plugin_filepath('function',
        'grn_structure_link'));

    //-- function name
    $function_name = 'grn_memo_folder_tree';

    if ( ! array_key_exists('folders', $params)) {
        return htmlspecialchars($function_name) . ' : folders not found';
    }

    $folders = $params['folders'];

    $var_name = 'did';

    if (array_key_exists('var_name', $params)) {
        $var_name = $params['var_name'];
    }

    $result = null;

    if (is_array($folders)) {
        $result = "<div class=\"parent\">\n";
        foreach ($folders as $id => $root) {
            if ($id == 'selected') {
                continue;
            }

            _grn_memo_folder_tree_internal($root, $result, $var_name, $smarty);
        }
        $result .= "</div>";
    }

    return $result;
}


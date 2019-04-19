<?php

/**
 * @name   grn_ui_options_bulletin_category
 *  掲示板カテゴリ選択（OPTIONタグのみの出力）
 *
 * @param  string  name            SELECTタグのNAME属性
 *
 * @option object  categories      カテゴリリスト
 * @option boolean root_category   ルートカテゴリを出力するかどうか
 * @option boolean please_select   選択してくださいを表示するかどうか
 * @option string  selected_cid    選択済みのカテゴリID
 * @option string  omit_cid        出力しないカテゴリID
 *
 *  grn_ui_options_bulletin_category はSELECTタグを出力しない以外は grn_ui_select_bulletin_category と同等
 */
function smarty_function_grn_ui_options_bulletin_category($params, &$smarty)
{
    $categories = $params['categories'];
    $selected_cid = @ $params['selected_cid'];
    $omit_cid = @ $params['omit_cid'];
    $b_root_category = @ $params['root_category'];
    $b_root_category = ( ! is_null($b_root_category) && $b_root_category) ? true
        : false;
    $b_please_select = @ $params['please_select'];
    $b_please_select = ( ! is_null($b_please_select) && $b_please_select) ? true
        : false;

    return grn_ui_options_bulletin_category_html_code('　', $categories,
        $selected_cid, $omit_cid, $b_root_category, $b_please_select);
}

//  注意: 未使用につき、国際化(リソース切り出し)未対応
function grn_ui_options_bulletin_category_html_code(
    $prefix_text,
    & $categories,
    $selected_cid,
    $omit_cid,
    $b_root_category,
    $b_please_select
) {
    assert('is_array( $categories )');
    $str = '';

    if ($b_root_category) {
        $str .= "<option value=\"root\">" . cb_msg('grn.bulletin',
                'root_category') . "</option>\n";
    }

    if ($b_please_select) {
        $str .= "<option value=\"\">" . cb_msg('grn.bulletin',
                'select_category') . "</option>\n";
    }

    $counter = 0;
    $count = count($categories);
    foreach ($categories as $cid => $category) {
        $counter++;
        if ($counter == $count) {
            $temp_prefix = $prefix_text . '┗';
        } else {
            $temp_prefix = $prefix_text . '┣';
        }

        if ($cid == $omit_cid) {
            // 出力しないカテゴリ
            continue;
        }

        $category_name = htmlspecialchars($category['name']);
        $selected_area = ($cid == $selected_cid) ? ' selected' : '';
        $str .= "<option value=\"" . htmlspecialchars($cid) . "\""
                . htmlspecialchars($selected_area) . ">"
                . htmlspecialchars($temp_prefix)
                . "{$category_name}</option>\n";

        // サブカテゴリ
        if (array_key_exists('children', $category)) {
            $children =& $category['children'];
            if (is_array($children) && count($children)) {
                if ($counter == $count) {
                    $child_prefix_text = $prefix_text . '　　';
                } else {
                    $child_prefix_text = $prefix_text . '┃　';
                }

                $str .= grn_ui_options_bulletin_category_html_code($child_prefix_text,
                    $children, $selected_cid, $omit_cid, false, false);
            }
        }
    }

    return $str;
}


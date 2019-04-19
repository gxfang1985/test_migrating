<?php
/**
 *
 * @name grn_user_search_column_names
 *
 * @description ユーザー検索対象項目ラベル
 *
 * @option      string  delimiter  項目ごとの区切り文字
 * @option      boolean is_system  システム管理画面かどうか
 * @option      boolean include_role_search  ロール検索を含むかどうか
 *
 * @date        2007/08/07
 * @author      K.Yonekawa
 */

function smarty_function_grn_user_search_column_names($params, &$smarty)
{
    $function_name = 'grn_user_search_column_names';

    $delimiter = '/';
    if (array_key_exists('delimiter', $params) === true) {
        $delimiter = $params['delimiter'];
    }

    $is_system = false;
    if (array_key_exists('is_system', $params) === true) {
        $is_system = $params['is_system'];
    }

    $include_role_search = false;
    if (array_key_exists('include_role_search', $params) === true) {
        $include_role_search = $params['include_role_search'];
    }

    $show_group_role = cb_at($params, 'show_group_role', true);

    // デフォルトは　名前／ログイン名／よみ／E-mail／役職
    $column_names = [
        'display_name'  => cb_msg('grn.common', 'display_name_realname'),
        'foreign_key'   => cb_msg('grn.common', 'foreign_key_realname'),
        'sort_key'      => cb_msg('grn.common', 'sort_key_realname'),
        'email_address' => cb_msg('grn.common', 'email_address_realname'),
        'post'          => cb_msg('grn.common', 'post_realname'),
    ];

    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');

    $item_properties = $uum->getDefaultItemProperties();
    foreach (array_keys($column_names) as $name) {
        if (array_key_exists($name, $item_properties) === false) {
            unset($column_names[$name]);
            continue;
        }

        $column_properties = $item_properties[$name];
        // システム管理画面でない場合は「公開しない」設定だったら検索対象にならない
        if ( ! $is_system) {
            if ( ! array_key_exists('show', $column_properties)
                 || ! $column_properties['show']
            ) {
                unset($column_names[$name]);
                continue;
            }
        }

        // 「使用しない」設定だったら検索対象にならない
        if ( ! array_key_exists('use', $column_properties)
             || ! $column_properties['use']
        ) {
            unset($column_names[$name]);
        }
        // 「検索対象」でない場合、検索対象にならない
        if ( ! array_key_exists('search', $column_properties)
             || ! $column_properties['search']
        ) {
            unset($column_names[$name]);
        }
    }

    $extension_item_list = $uum->listItems();
    foreach (array_keys($extension_item_list) as $key) {
        $column =& $extension_item_list[$key];

        if ($column->get('use') && ($column->get('show') || $is_system)
            && $column->get('search')
            && ($column->get('type') != 'file')
        ) {
            $column_names[$column->get('id')]
                = htmlspecialchars($column->get('display_name'));
        }
        unset($column);
    }

    $column_names_string = implode(htmlspecialchars($delimiter), $column_names);
    if ($include_role_search && $show_group_role) {
        $column_names_string .= htmlspecialchars($delimiter)
                                . cb_msg('grn.common', 'role_foreign_key');;
    }

    return $column_names_string;
}



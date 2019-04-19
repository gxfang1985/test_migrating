<?php

/**
 * Show sender name.
 *
 * @name        grn_sender_name
 * @description show sender name
 *
 * @param array      $params
 * @param GRN_Smarty $smarty
 *
 * @option      string  name         user name
 * @option      string  icon         icon name。省略されると'spacer20'となるが、空文字を渡されたときは表示しない
 * @option      string  truncated    名前をtruncateする文字数
 * @option      bool no_image
 *
 * @return string
 */

function smarty_function_grn_sender_name($params, &$smarty)
{
    //-- the function name
    $function_name = 'grn_sender_name';

    if ( ! array_key_exists('name', $params)) {
        return htmlspecialchars($function_name) . ": missing name parameter";
    }

    $sender_name = $params['name'];
    if (is_null($sender_name)) {
        $sender_name = '';
    } elseif (array_key_exists('truncated', $params)) {
        $sender_name = mb_strimwidth($sender_name, 0, $params['truncated'],
            '...');
    }

    $no_image = cb_at($params, 'no_image', false);
    if ($no_image) {
        return sprintf('%s', htmlspecialchars($sender_name));
    }

    $icon = null;
    if (array_key_exists('icon', $params)) {
        $icon = $params['icon'];
    }

    if (is_null($icon)) {
        $icon = 'spacer20';
    }

    $icon = $icon . '.gif';
    $image_params = ['image' => $icon, 'alt' => $alt];
    $img_tag = '';
    $img_tag = smarty_function_grn_image($image_params, $smarty);

    return sprintf($img_tag . '%s', htmlspecialchars($sender_name));
}

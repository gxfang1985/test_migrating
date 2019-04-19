<?php

require_once('grn/calendar.csp');

/**
 * @name   grn_calendar_event
 *  タイトル
 *
 * @date   2005/01/06
 * @author KAMBE,Shinichi
 *
 * @param  string  type     イベントの種類
 * @param  string  data     内容
 * @param  string  icon     アイコン
 * @param  string  style     css_style
 *
 */

function smarty_function_grn_calendar_event($params, &$smarty)
{
    static $image_map = [
        GRN_CALENDAR_TYPE_PUBLICHOLIDAY => 'holiday20.gif',
        GRN_CALENDAR_TYPE_MEMORIALDAY   => 'anniversary20.gif',
        GRN_CALENDAR_TYPE_SYSTEM_MEMO   => '',
        GRN_CALENDAR_TYPE_USER_MEMO     => '',
        GRN_CALENDAR_TYPE_WORKDAY       => 'workday20.gif'
    ];
    $type = null;
    if (array_key_exists('type', $params)) {
        $type = $params['type'];
    }

    // 基本表示項目の場合
    if (array_key_exists($type, $image_map)) {
        $data = '';
        if (array_key_exists('data', $params)) {
            $data = $params['data'];
            $data = htmlspecialchars($data);
            $data = nl2br($data);
        }

        if (array_key_exists('icon', $params) && $params['icon']) {
            $icon = $params['icon'];
        } else {
            $icon = '';
            if (array_key_exists($type, $image_map)) {
                $icon = $image_map[$type];
            }
        }

        require_once($smarty->_get_plugin_filepath('function', 'grn_image'));
        $image_html = $icon ? smarty_function_grn_image(['image' => $icon],
            $smarty) : '';
        $view = $image_html . $data;
    } // 拡張表示項目の場合
    else {
        $extension_plugin = 'grn_calendar_extension_event_' . $type;
        require_once($smarty->_get_plugin_filepath('function',
            $extension_plugin));
        $smarty_func = 'smarty_function_' . $extension_plugin;
        $view = call_user_func_array($smarty_func, [$params, &$smarty]);
    }

    $style = '';
    if (cb_at($params, 'style') !== null) {
        $style = $params['style'] ? 'style="' . $params['style'] . '"' : '';
    }

    $class = '';
    if (cb_at($params, 'class') !== null) {
        $class = $params['class'];
    }

    return '<div ' . $style . ' class="normalEventElement ' . $class . '">'
           . $view . '</div>';
}


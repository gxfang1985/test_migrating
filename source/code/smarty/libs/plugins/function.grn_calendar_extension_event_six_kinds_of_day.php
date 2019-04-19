<?php

require_once('grn/calendar.csp');

/**
 * @name   grn_calendar_extension_event_six_kinds_of_day
 *  タイトル
 *
 * @date   2005/01/06
 * @author KAMBE,Shinichi
 *
 * @param  string  type     イベントの種類
 * @param  string  data     内容
 * @param  string  icon     アイコン
 *
 */

function smarty_function_grn_calendar_extension_event_six_kinds_of_day(
    $params,
    &$smarty
) {
    $type = null;
    if (array_key_exists('type', $params)) {
        $type = $params['type'];
    }

    if (array_key_exists('data', $params)) {
        $data = $params['data'];
    }

    $icon = false;
    if (array_key_exists('icon', $params) && $params['icon']) {
        $icon = $params['icon'];
    }

    require_once($smarty->_get_plugin_filepath('function', 'grn_image'));
    $image_html = $icon ? smarty_function_grn_image(['image' => $icon], $smarty)
        : '';

    return $image_html . htmlspecialchars($data);
}



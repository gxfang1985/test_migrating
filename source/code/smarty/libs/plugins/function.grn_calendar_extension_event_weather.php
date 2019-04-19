<?php

require_once('grn/calendar.csp');

/**
 * @name   grn_calendar_extension_event_weather
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

function smarty_function_grn_calendar_extension_event_weather($params, &$smarty)
{
    $type = null;
    if (array_key_exists('type', $params)) {
        $type = $params['type'];
    }

    $data = '';
    $alt = '';
    if (array_key_exists('data', $params)) {
        $data = $params['data'];
        $location_name = $data['location_name'];
        $info = $data['info'];

        // alt/title
        require_once('fw/i18n.csp');
        $alt = $info['weather'];

        $inhtml = "<nobr>" . htmlspecialchars($alt) . "<nobr>";

        $data_h = "<a href='" . $info['url'] . "' onMouseOver=\"tpon(event, '"
                  . $inhtml . "');\" onMouseOut='tpoff();' target='_blank'>";
        $data_t = htmlspecialchars($location_name) . '</a>';
    }

    $icon = false;
    if (array_key_exists('icon', $params) && $params['icon']) {
        $icon = $params['icon'];
    }

    require_once($smarty->_get_plugin_filepath('function', 'grn_image'));
    $image_html = $icon ? smarty_function_grn_image([
        'image' => $icon,
        'alt'   => ""
    ], $smarty) : '';

    return $data_h . $image_html . $data_t;
}



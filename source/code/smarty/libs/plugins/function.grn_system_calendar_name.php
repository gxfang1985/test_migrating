<?php

/**
 * @name   grn_system_calendar_name
 */
function smarty_function_grn_system_calendar_name($params, &$smarty)
{
    $function_name = 'grn_system_calendar_name';

    require_once('grn/calendar.csp');

    if ( ! array_key_exists('scid', $params)) {
        return htmlspecialchars($function_name) . ": missing name parameter";
    }
    $scid = $params['scid'];

    $cm = GRN_CalendarManager::getInstance();
    $calendar =& $cm->getSystemCalendar($scid);

    return htmlspecialchars($calendar->get('name'));
}



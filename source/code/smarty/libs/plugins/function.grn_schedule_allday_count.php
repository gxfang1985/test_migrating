<?php
require_once 'fw/date.csp';

/**
 * @name   grn_schedule_allday_count
 *
 */

function smarty_function_grn_schedule_allday_count($params, &$smarty)
{

    $i = 0;

    if (array_key_exists('calendar', $params)
        && is_array($params['calendar'])
    ) {
        $i += count($params['calendar']);
    }

    if (array_key_exists('allday', $params)) {
        foreach ($params['allday'] as $value) {
            if ( ! is_array($value) || ! array_key_exists('allday', $value)) {
                continue;
            }

            if ( ! array_key_exists('private', $value) || ! $value['private']) {
                $i = $i + 1;
            }
        }
    }

    if (array_key_exists('todos', $params) && is_array($params['todos'])) {
        $i += count($params['todos']);
    }

    if (array_key_exists('week', $params) && $params['week']) {
        $string = '<div style="width:99px;  overflow:hidden">';
    } else {
        $string
            = '<div style="width:680px; left:20px; top:25px; overflow:hidden">';
    }

    return $string;
}


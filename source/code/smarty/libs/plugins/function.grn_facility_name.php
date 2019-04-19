<?php

/**
 *
 * @name   grn_facility_name
 * @description show facility name from facility id with decoration
 *
 * @param  string  faid         facility id
 * @param  string  name        facility name
 */

function smarty_function_grn_facility_name($params, &$smarty)
{
    //-- the function name
    $function_name = 'grn_facility_name';

    $facility_name = '';
    $faid = array_key_exists('faid', $params) ? $params['faid']
        : false;
    $facility = null;
    $noimage = array_key_exists('noimage', $params)
        ? $params['noimage']
        : false;
    $referer_key = array_key_exists('referer_key', $params)
        ? $params['referer_key'] : false;
    $blank = array_key_exists('blank', $params) ? $params['blank']
        : false;
    $noLinkIfNotExist = cb_at($params, 'no_link_if_not_exist', false);

    if ($faid) {
        if (array_key_exists('current_name', $params)
            && $params['current_name']
        ) {
            $facility_name = $params['current_name'];
        } else {
            require_once('schedule/facility_system_logic.csp');
            $facility_logic = GRN_Facility_SystemLogic::getInstance();
            $facility =& $facility_logic->getFacilityInfo($faid);
        }
    }

    if ($facility_name === '') {
        if ($facility) {
            $facility_name = $facility['col_name'];
        } else {
            //assert( 'array_key_exists("name", $params)' );
            $facility_name = array_key_exists('name', $params) ? $params['name']
                : '';
        }
    }

    if (array_key_exists('truncated', $params)) {
        $facility_name = mb_strimwidth($facility_name, 0, $params['truncated'],
            '...');
    }

    //-- create return_string
    if ($noimage) {
        $image = '';
    } else {
        require_once($smarty->_get_plugin_filepath('function', 'grn_image'));
        $image = smarty_function_grn_image(['image' => 'facility20.gif'],
            $smarty);
    }

    if ($noLinkIfNotExist && ! $facility) {
        return $image . htmlspecialchars($facility_name);
    }

    $facility_info_string = cb_pageurl('schedule/facility_info',
        ['faid' => $faid, 'referer_key' => $referer_key]);
    if ($blank) {
        return '<a href="javascript:popupWin(\'' . $facility_info_string
               . '\',\'_blank\',\'\',\'\')">' . $image
               . htmlspecialchars($facility_name) . '</a>';
    } else {
        return '<a href="javascript:popupWin(\'' . $facility_info_string
               . '\',\'help\',500,480,0,0,0,1,0,1)">' . $image
               . htmlspecialchars($facility_name) . '</a>';
    }
}


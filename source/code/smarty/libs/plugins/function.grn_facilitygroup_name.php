<?php

/**
 * @name   grn_facilitygroup_name
 *  施設グループ名表示
 *
 * @param  string  fag_id         施設グループID
 *
 */

function smarty_function_grn_facilitygroup_name($params, &$smarty)
{
    $function_name = "grn_facilitygroup_name";

    $facilitygroup_id = $params['fgid'];
    if (is_null($facilitygroup_id)) {
        return htmlspecialchars($function_name) . ': $facilitygroup_id is null';
    }

    if ($facilitygroup_id == 0) {
        return cb_msg('grn.common', 'root_group');
    }
    require_once('schedule/facility_system_logic.csp');
    $fsl = GRN_Facility_SystemLogic::getInstance();
    $the_facilitygroup =& $fsl->getFacilityGroup($facilitygroup_id);

    if ($the_facilitygroup === false) {
        return htmlspecialchars($function_name)
               . ': $facilitygroup_id is not valid';
    }
    $return_string = $the_facilitygroup->get('name');

    return htmlspecialchars($return_string);
}


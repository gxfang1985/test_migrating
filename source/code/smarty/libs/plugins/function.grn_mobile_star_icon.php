<?php

function smarty_function_grn_mobile_star_icon($params, &$smarty)
{
    $function_name = 'grn_star_mobile_icon';

    if ( ! isset($params['module']) || strlen($params['module']) === 0) {
        return htmlspecialchars($function_name)
               . ': missing "module" parameter';
    }
    if ( ! isset($params['star_infos']) || ! is_array($params['star_infos'])) {
        return htmlspecialchars($function_name)
               . ': missing "star_infos" parameter';
    }
    if ( ! isset($params['unique_id']) || strlen($params['unique_id']) === 0) {
        return htmlspecialchars($function_name)
               . ': missing "unique_id" parameter';
    }
    if ( ! isset($params['on_class']) || strlen($params['on_class']) === 0) {
        $on_class = 'mobile-icon-starOn-grn';
    } else {
        $on_class = $params['on_class'];
    }
    if ( ! isset($params['off_class']) || strlen($params['off_class']) === 0) {
        $off_class = 'mobile-icon-starOff-grn';
    } else {
        $off_class = $params['off_class'];
    }
    $module_id = $params['module'];
    $star_infos = $params['star_infos'];
    $star_item = $params['unique_id'];
    unset($params['module'], $params['star_infos'], $params['unique_id'], $params['on_class'], $params['off_class']);

    $str = '<a class="';
    $star_on = false;
    if (array_key_exists($star_item, $star_infos)) {
        $str .= $star_infos[$star_item] == '1' ? $on_class : $off_class;
        $str .= '" ';
        $star_on = $star_infos[$star_item] == '1' ? true : false;
    } else {
        $str .= $off_class;
        $str .= '" ';
        $star_on = false;
    }
    $id_array = [htmlspecialchars($module_id)];
    foreach ($params as $key => $value) {
        if (strlen($value) == 0) {
            continue;
        }
        $tmp = $key . '_' . $value;
        $tmp = htmlspecialchars($tmp);
        $id_array[] = $tmp;
    }
    $str .= 'id="' . implode(':', $id_array) . '" ';

    $str .= 'onclick="obj_star_mobile.onClick(this);"';
    $str .= '></a>';

    return $str;
}


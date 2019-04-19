<?php
/**
 * @param $params
 * @param $smarty
 *
 * @return string
 */
function smarty_function_grn_star_icon($params, &$smarty)
{
    $function_name = 'grn_star_icon';

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
               . ': missing "star_item" parameter';
    }
    $module_id = $params['module'];
    $star_infos = $params['star_infos'];
    $star_item = $params['unique_id'];
    unset($params['module'], $params['star_infos'], $params['unique_id']);

    $height = cb_at($params, 'height');
    $width = cb_at($params, 'width');

    $no_style = false;
    if (array_key_exists('no_style', $params)) {
        $no_style = $params['no_style'];
        unset($params['no_style']);
    }
    $str = '<span' . ($no_style ? '' : ' style="display:inline;"')
           . ' class="star ' . ($no_style ? 'inline_block_grn ' : '');
    if (array_key_exists($star_item, $star_infos)) {
        $str .= $star_infos[$star_item] == '1' ? 'on' : 'off';
        $str .= '" ';
        $star_on = $star_infos[$star_item] == '1' ? true : false;
    } else {
        $str .= 'off';
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

    global $G_config_common;
    $app_path = $G_config_common->get('Global', 'app_path');
    $str .= ' app_path="' . $app_path . '/grn/image/cybozu/" ';
    require_once($smarty->_get_plugin_filepath('function', 'grn_image'));
    $star_image = $star_on ? 'star_on.png' : 'star_off.png';
    $str .= "onclick=\"obj_star_list._onClick(this);\"";
    $str .= '>' . smarty_function_grn_image([
            'image'  => $star_image,
            'height' => $height,
            'width'  => $width
        ], $smarty) . '</span>';

    return $str;
}

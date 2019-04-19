<?php

/**
 * @name   grn_include_portlet
 *  ポートレットのインクルード
 *
 * @date   2004/11/10
 * @author Yuichi,Nakamura
 * @option string  portlet        ポートレットデータ
 * @option string  display        表示タイプ（view:表示画面/set-system:システム設定画面/set-personal:システム設定画面/)
 *
 *  記述例
 *  <pre>{grn_portal_include_portlet portlet=$portlet display=view}</pre>
 */

function smarty_function_grn_portal_include_portlet($params, &$smarty)
{
    $function_name = "grn_include_portlet";

    // Check Necessary Parameter and Value
    if ( ! array_key_exists('portlet', $params)) {
        return htmlspecialchars($function_name) . ": missing portlet parameter";
    }

    if ($params['portlet'] === '' || is_null($params['portlet'])) {
        return htmlspecialchars($function_name) . ": missing portlet parameter";
    }
    if ( ! array_key_exists('display', $params)) {
        return htmlspecialchars($function_name) . ": missing display parameter";
    }

    if ($params['display'] === '' || is_null($params['display'])) {
        return htmlspecialchars($function_name) . ": missing display parameter";
    }

    // Get Parameters
    $portlet = $params['portlet'];
    $display = $params['display'];

    switch ($display) {
        case 'view':
            $file_name = realpath(cb_basedir() . '/code/doc_root/'
                                  . $portlet['view_template']);
            break;
        case 'set-system':
        case 'set-personal':
        case 'set-operation':
            $file_name = realpath(cb_basedir() . '/code/doc_root/'
                                  . $portlet['set_template']);
            break;
        default:
            $file_name = false;
            break;
    }
    require_once('portal/portlet_util.csp');
    if ( ! GRN_Portal_PortletUtil::isExecutableFile($file_name)) {
        return '';
    }

    // Include Portlet File
    include($file_name);
}


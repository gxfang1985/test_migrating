<?php

/**
 * @name   grn_report_cellular_appname
 * reportアプリケーション名を表示
 *
 * @param string no_icon    アイコン絵文字非表示
 * @param string no_hankaku アプリ名 非 半角カナ変換
 * @param string locale     ロケール(オプション)
 *
 *  記述例
 *  <pre>{grn_report_cellular_appname no_icon="1"}
 */
function smarty_function_grn_report_cellular_appname($params, &$smarty)
{
    // report/cellular function
    require_once('report/cellular.csp');
    if (__grn_report_is_cellular_application()) {
        require_once($smarty->_get_plugin_filepath('function',
            'grn_cellular_appname'));
        $params['app_id'] = 'report';

        return smarty_function_grn_cellular_appname($params, $smarty);
    }

    $function_name = "grn_report_cellular_appname";

    // necessary parameter and value

    $show_icon = true;

    if (array_key_exists('no_icon', $params) && $params['no_icon']) {
        $show_icon = false;
    }

    $hankaku = true;

    if (array_key_exists('no_hankaku', $params) && $params['no_hankaku']) {
        $hankaku = false;
    }

    $escape = true;

    if (array_key_exists('no_escape', $params) && $params['no_escape']) {
        $escape = false;
    }

    $app_id = 'report';
    $icon_name = 'pencil';
    static $app_array = [];
    if (array_key_exists($app_id, $app_array)) {
        $icon = '';
        if ($show_icon && strlen($app_array[$app_id]['icon'])) {
            require_once($smarty->_get_plugin_filepath('function',
                'grn_report_cellular_pictogram'));
            $icon
                = smarty_function_grn_report_cellular_pictogram(['key' => $app_array[$app_id]['icon']],
                $smarty);
        }
        $name = $app_array[$app_id]['name'];

        if ($hankaku) {
            $name = mb_convert_kana($name, "kv");
        }

        if ($escape) {
            $name = htmlspecialchars($name);
        }

        return $icon . $name;
    }

    require_once('grn/application.csp');
    $locator = GRN_ApplicationLocator::instance();
    $app = $locator->getInstance($app_id);
    $name = $app->getName();

    $icon = '';
    if (strlen($icon_name)) {
        require_once($smarty->_get_plugin_filepath('function',
            'grn_report_cellular_pictogram'));
        $icon
            = smarty_function_grn_report_cellular_pictogram(['key' => $icon_name],
            $smarty);
    }

    $app_array[$app_id] = [
        'icon' => $icon_name,
        'name' => $name,
    ];

    if ($hankaku) {
        $name = mb_convert_kana($name, "kv");
    }

    if ($escape) {
        $name = htmlspecialchars($name);
    }

    if ( ! $show_icon) {
        return $name;
    }

    return $icon . $name;
}


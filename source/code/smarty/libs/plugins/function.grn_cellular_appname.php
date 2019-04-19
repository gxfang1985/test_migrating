<?php

/**
 * @name   grn_appname
 * アプリケーション名を表示
 *
 * @param string app_id     アプリケーションID
 * @param string locale     ロケール(オプション)
 *
 *  記述例
 *  <pre>{grn_appname app_id="sample"}
 */
function smarty_function_grn_cellular_appname($params, &$smarty)
{
    $function_name = "grn_cellular_appname";

    // necessary parameter and value
    if ( ! array_key_exists('app_id', $params)) {
        return htmlspecialchars($function_name) . ": missing app_id parameter";
    }

    if ($params['app_id'] === '' || is_null($params['app_id'])) {
        return htmlspecialchars($function_name) . ": missing app_id parameter";
    }

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

    static $app_array = [];
    $app_id = $params['app_id'];
    $locale = @ $params['locale'];
    if (is_null($locale) && array_key_exists($app_id, $app_array)) {
        $icon = '';
        if ($show_icon && strlen($app_array[$app_id]['icon'])) {
            require_once($smarty->_get_plugin_filepath('function',
                'grn_cellular_pictogram'));
            $icon
                = smarty_function_grn_cellular_pictogram(['key' => $app_array[$app_id]['icon']],
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

    $cellular_app =& $locator->getInstance('cellular');
    $icon_name = '';
    if ($cellular_app) {
        $config = null;
        $component = $cellular_app->getComponent($app_id);

        if ( ! $component) {
            cb_throw_error(E_GRN_APPLICATION_NOT_AVAILABLE);
        }

        $icon_name = $component->getContent('icon', $config);
    }

    $icon = '';
    if (strlen($icon_name)) {
        require_once($smarty->_get_plugin_filepath('function',
            'grn_cellular_pictogram'));
        $icon = smarty_function_grn_cellular_pictogram(['key' => $icon_name],
            $smarty);
    }

    if (is_null($locale)) {
        $app_array[$app_id] = [
            'icon' => $icon_name,
            'name' => $name,
        ];
    }

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


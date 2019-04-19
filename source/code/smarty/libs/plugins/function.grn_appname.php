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
function smarty_function_grn_appname($params, &$smarty)
{
    $function_name = 'grn_appname';

    // necessary parameter and value
    if ( ! array_key_exists('app_id', $params)) {
        return htmlspecialchars($function_name) . ': missing app_id parameter';
    }

    if ($params['app_id'] === '' || is_null($params['app_id'])) {
        return htmlspecialchars($function_name) . ': missing app_id parameter';
    }

    static $name_array = [];

    $app_id = $params['app_id'];

    if (array_key_exists('locale', $params)) {
        $locale = $params['locale'];
    } else {
        $locale = null;
    }

    if (is_null($locale) && array_key_exists($app_id, $name_array)) {
        return $name_array[$app_id];
    }

    require_once('grn/application.csp');
    $locator = GRN_ApplicationLocator::instance();
    $name = $locator->getName($app_id, $locale);
    $name = htmlspecialchars($name);
    $name_array[$app_id] = $name;

    return $name;
}


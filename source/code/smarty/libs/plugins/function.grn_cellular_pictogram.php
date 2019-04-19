<?php

/**
 * @name   grn_cellular_pictogram
 * 絵文字を表示
 *
 * @param string key      key for pictogram
 * @param string carrier  carrier id, optional
 *
 *  記述例
 *  <pre>{grn_cellular_pictogram key="sample"}
 */
function smarty_function_grn_cellular_pictogram($params, &$smarty)
{
    $function_name = "grn_cellular_pictogram";

    // necessary parameter and value
    if ( ! array_key_exists('key', $params)) {
        return htmlspecialchars($function_name) . ": missing key parameter";
    }

    $carrier = @ $params['carrier'];

    $supported = ['docomo' => 1, 'vodafone' => 1, 'au' => 1, 'willcom' => 1];

    if ( ! array_key_exists('carrier', $params)) {
        static $_cellular_carrier = null;

        if (is_null($_cellular_carrier)) {
            $ua = $_SERVER['HTTP_USER_AGENT'];

            if (strpos($ua, 'DoCoMo') !== false) {
                //Docomo端末
                $_cellular_carrier = 'docomo';
            } elseif (strpos($ua, 'J-PHONE') !== false
                      || strpos($ua, 'Vodafone') !== false
                      || strpos($ua, 'SoftBank') !== false
            ) {
                //Vodafone端末
                $_cellular_carrier = 'vodafone';
            } elseif (strpos($ua, 'UP.Browser') !== false) {
                $_cellular_carrier = 'au';
            } elseif (strpos($ua, 'DDIPOCKET') !== false) {
                $_cellular_carrier = 'docomo';
            } else {
                $_cellular_carrier = false;
            }
        }

        $carrier = $_cellular_carrier;
    }

    // TENTATIVE
    // ブラウザデバッグ用コード
    if ( ! $carrier || ! array_key_exists($carrier, $supported)) {
        if ( ! $smarty->get_template_vars('is_debug')) {
            return '';
        }

        $carrier = 'docomo';
    }

    $key = $params['key'];

    require_once('fw/i18n.csp');

    if (is_array($key)) {
        if (array_key_exists('module', $key) && array_key_exists('key', $key)) {
            return cb_msg($key['module'] . $carrier, $key['key']);
        } else {
            return htmlspecialchars($function_name)
                   . ": missing resource parameter";
        }
    }

    $args = null;
    if ($carrier == 'willcom') {
        global $G_config_common;
        $config_grn = new CB_ConfigManager(cb_basedir() . '/garoon.ini',
            'Global');
        $is_debug = ($G_config_common->get('Global', 'debug')
                     & ERROR_TRACE_LOG_FLAG_213);
        if ( ! $config_grn || $is_debug) {
            $build_date = time();
        } else {
            $build_date = $config_grn->get('System', 'build_date');
        }
        $build_date .= '.text';
        $app_path = $G_config_common->get('Global', 'app_path');
        $image
            = "{$app_path}/grn/image/cybozu/cellular/{$key}.gif?{$build_date}";
        $args = ['image' => $image];
    }

    return cb_msg('grn.cellular.pictogram.' . $carrier, $key, $args);
}


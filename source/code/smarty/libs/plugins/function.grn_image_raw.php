<?php
require_once 'fw/ui.csp';
require_once 'grn/ui.csp';

/**
 * @name   grn_image_raw
 *
 *  IMG タグの出力（外部ファイル）
 *
 * @date   2005/1/13
 * @author K.Tokuta
 *
 * @param  string  image   イメージファイル名
 *
 * @option string  alt     IMGタグのALT属性
 *
 *  共通のタグオプション（border="0" 等）を出力する。<br>
 *  ブラウザ毎の対応を吸収
 *  <li>align=“absmiddle” border=“0” (for IE, NS6/7)
 *  <li>border=“0” (for NS4) <br>
 *  IMG タグの onClick イベントハンドラに関しては、
 *  Netscape 4.x が対応していないため、 grn_image においてもサポートしない。
 *  代わりに、grn_image_onclick にて実現する。<br>
 *  alt_module および alt_key を alt の代わりに国際化対応のために利用できる。<br>
 *
 */
function smarty_function_grn_image_raw($params, &$smarty)
{
    $function_name = "grn_image_raw";

    $skip_params = false;
    if (isset($params['skip_params']) && $params['skip_params']) {
        $skip_params = true;
    }

    if ( ! $skip_params) {
        $params = grn_ui_image_params($params, $function_name, $smarty);
    }

    $browser = cb_ui_get_browser();

    //URLに使用不可能な文字を除外
    $pattern = "/[^a-zA-Z0-9\-._~%:\/?#\[\]@!$&'()*+,;=]/";
    $image = preg_replace($pattern, "", $params['image']);

    global $G_config_common, $G_config_grn;
    $is_debug = ($G_config_common->get('Global', 'debug')
                 & ERROR_TRACE_LOG_FLAG_213);
    if ( ! $G_config_grn || $is_debug) {
        $build_date = time();
    } else {
        $build_date = $G_config_grn->get('System', 'build_date');
    }
    $build_date .= '.text';
    if (strpos($image, '?') === false) {
        $image .= '?' . $build_date;
    } else {
        $image .= '&' . $build_date;
    }

    $alt = null;
    if (isset($params['alt'])) {
        $alt = $params['alt'];
    }

    $name = null;
    if (isset($params['name'])) {
        $name = $params['name'];
    }

    $id = null;
    if (isset($params['id'])) {
        $id = $params['id'];
    }

    $class = null;
    if (isset($params['class'])) {
        $class = $params['class'];
    }

    $aria_label = null;
    if (isset($params['aria_label'])) {
        $aria_label = $params['aria_label'];
    }

    $noborder = null;
    if (isset($params['noborder'])) {
        $noborder = $params['noborder'];
    }

    $onclick = null;
    if (isset($params['onclick'])) {
        $onclick = $params['onclick'];
    }

    $onload = null;
    if (isset($params['onload'])) {
        $onload = $params['onload'];
    }

    $align = null;
    if (isset($params['align'])) {
        $align = $params['align'];
    }

    $height = null;
    if (isset($params['height'])) {
        $height = $params['height'];
    }

    $width = null;
    if (isset($params['width'])) {
        $width = $params['width'];
    }

    $str = "<img src=\"{$image}\"";

    if ($aria_label) {
        $str .= " aria-label=\"{$aria_label}\"";
    }

    if ( ! $noborder) {
        $str .= " border=\"0\"";
    }

    if ($onclick) {
        $str .= ' onclick="' . htmlspecialchars($onclick) . '"';
    }

    if ($onload) {
        $str .= ' onload="' . htmlspecialchars($onload) . '"';
    }

    if ($alt) {
        $str .= " alt=\"{$alt}\" title=\"{$alt}\"";
    } else {
        $str .= " alt=\"\"";
    }

    if ($name) {
        $str .= ' name="' . htmlspecialchars($name) . '"';
    }
    if ($id) {
        $str .= ' id="' . htmlspecialchars($id) . '"';
    }

    if ($class) {
        $str .= ' class="' . htmlspecialchars($class) . '"';
    }

    if ($height) {
        $str .= ' height="' . htmlspecialchars($height) . '"';
    }

    if ($width) {
        $str .= ' width="' . htmlspecialchars($width) . '"';
    }

    // 'align' option
    if ( ! is_null($align) && $align == 'bottom'
         && ($browser['type'] == 'msie'
             || ($browser['type'] == 'netscape'
                 && $browser['ver_major'] > 4))
    ) {
        $str .= " align=\"absbottom\"";
    } elseif ($browser['type'] == 'msie'
              || ($browser['type'] == 'netscape'
                  && $browser['ver_major'] > 4)
    ) {
        $str .= " align=\"absmiddle\"";
    }

    $str .= ">";

    return $str;
}


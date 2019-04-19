<?php

/**
 * @name   grn_charset
 *  キャラクタセット選択
 *
 * @param  string  name    INPUTタグのNAME属性
 *
 * @option string  default 初期値
 *
 * @date   2005/1/7
 * @author K.Tokuta
 *
 *  記述例
 *  <pre>{grn_charset name="charset" default="UTF-8"}
 */
function smarty_function_grn_charset($params, &$smarty)
{
    $function_name = "grn_charset";

    // necessary parameter and value
    $name = @ $params['name'];
    if (strlen($name) <= 0) {
        return htmlspecialchars($function_name) . ": name is necessary";
    }

    require_once('fw/i18n.csp');
    $i18n = CB_I18N::getInstance();
    $encodings = $i18n->getEncodingNames();
    global $G_config_common;

    if (strlen(@ $params['default']) > 0) {
        $default = $params['default'];
    } else {
        $default = $G_config_common->get('I18N', 'default_external_encoding');
    }

    $bom = false;
    if (array_key_exists('bom', $params)) {
        $bom = $params['bom'];
    }

    $fixed = $G_config_common->get('I18N', 'fix_external_encoding');

    if ($fixed) {
        $str = sprintf('<b>%s</b> ' . cb_msg('grn.common', 'fixed')
                       . '<input type="hidden" name="%s" value="%s">',
            htmlspecialchars($encodings[$default]), htmlspecialchars($name),
            htmlspecialchars($default));
    } else {
        $str = sprintf('<select class="mRight10" size="1" name="%s">',
            htmlspecialchars($name));
        foreach ($encodings as $key => $value) {
            $selected = ($key === $default) ? ' selected' : '';
            $str .= sprintf('<option value="%s"%s>%s</option>',
                htmlspecialchars($key), htmlspecialchars($selected),
                htmlspecialchars($value));
        }
        $str .= '</select>';

        if ($bom) {
            $bom_display_status = strcasecmp($default, "UTF-8") === 0 ? ''
                : 'display:none;';
            $str .= '<span class="checkbox_base_grn" style="'
                    . $bom_display_status
                    . '"><input type="checkbox" name="bom" id="bom"/><label for="bom" onmouseover="this.style.color=\'#ff0000\'" onmouseout="this.style.color=\'\'">'
                    . cb_msg('fw.common', 'utf-8-bom')
                    . '</label></span>'
                    . smarty_function_grn_load_javascript(['file' => 'grn/html/component/grn_charset.js'],
                    $smarty)
                    . '<script type="text/javascript" language="javascript">'
                    . ' grn.html.component.grn_charset.charsetSelectName = "'
                    . htmlspecialchars($name) . '";'
                    . '</script>';
        }
    }

    return $str;
}


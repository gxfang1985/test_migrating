<?php

/**
 * @name   grn_checkbox
 *  チェックボックス
 *
 * @author 2003/8/26 HATA,Shinya
 *
 * @param  string  name        INPUTタグのNAME属性
 * @param  string  id          INPUTタグのID属性
 * @param  string  value       チェック時の値（INPUTタグのVALUE属性）
 *
 * @option boolean checked     チェック済みかどうか
 * @option string  onclick     onclickイベントハンドラ
 * @option string  caption     キャプション
 * @option boolean disabled    禁止状態
 *
 *  caption_module および caption_key を caption の代わりに国際化対応のために利用できる。<br>
 *  同じINPUT名で複数のチェックボックスを作成する場合、
 *  例えば name="uid[]" と最後に [] を付ける必要がある。
 *
 *  記述例
 *  <pre>{grn_checkbox name='private' id='private_event' value='1' caption='非公開'}</pre>
 *  出力例
 *  <pre>&lt;input type="checkbox" name="private" id="private_event" value="1"&gt;
 *  &lt;label for="private_event" onMouseOver="this.style.color='#ff0000'"
 *  onMouseOut="this.style.color=''"&gt;非公開&lt;/label&gt;</pre>
 *
 * @date   2005/1/20
 * @author K.Tokuta
 *
 */
function smarty_function_grn_checkbox($params, &$smarty)
{
    $function_name = 'grn_checkbox';

    // necessary parameter and value
    if (strlen(@ $params['name']) > 0) {
        $name = $params['name'];
    } else {
        return htmlspecialchars($function_name) . ': missing name parameter';
    }

    if (strlen(@ $params['id']) > 0) {
        $id = $params['id'];
    } else {
        return htmlspecialchars($function_name) . ': missing id parameter';
    }

    if ( ! array_key_exists('value', $params)) {
        return htmlspecialchars($function_name) . ': missing value parameter';
    }
    if (strlen(@ $params['value']) > 0) {
        $value = htmlspecialchars($params['value']);
    } else {
        $value = '';
    }

    //input class
    if (strlen(@ $params['class']) > 0) {
        $class = $params['class'];
    } else {
        $class = '';
    }

    $onclick = '';
    if (isset($params['onclick']) && strlen($params['onclick']) > 0) {
        $onclick = ' onclick="' . htmlspecialchars($params['onclick']) . '"';
    }

    // checked
    $checked = isset($params['checked']) && $params['checked'] ? ' checked'
        : '';
    // disabled
    $disabled = isset($params['disabled']) && $params['disabled'] ? ' disabled'
        : '';

    $input_str
        = sprintf('<input type="checkbox" name="%s" id="%s" class="%s" value="%s"%s%s%s>',
        htmlspecialchars($name), htmlspecialchars($id), $class, $value,
        $onclick, htmlspecialchars($checked),
        htmlspecialchars($disabled));

    // label_option
    if (isset($params['disabled']) && $params['disabled']) {
        $label_option = ' class="form_disable"';
    } else {
        $label_option
            = ' onMouseOver="this.style.color=\'#ff0000\'" onMouseOut="this.style.color=\'\'"';
    }

    $label_str = sprintf('<label id="%s" for="%s"%s>',
        htmlspecialchars($params['id'] . '_label'),
        htmlspecialchars($params['id']), $label_option);

    //GTM-259 img
    $img = "";
    if (array_key_exists('image', $params)) {

        // require_once $smarty->_get_plugin_filepath('function', 'grn_image');
        //$img = "&nbsp;".smarty_function_grn_image($params, $smarty);
        $img = "<div class=" . $params[id] . "1>&nbsp;</div>";
    }
    // caption
    $caption_str = @ $params['caption'];
    if (strlen($caption_str) > 0) {
        $caption_str = htmlspecialchars($caption_str);
        $return_str = $input_str . $label_str . $img . $caption_str
                      . '</label>';
    } else {
        $return_str = $input_str;
    }

    // span cover checkbox_base_grn
    $span_cover = '';
    $close_span_cover = '';
    if (array_key_exists('span_cover', $params)) {
        $return_str = '<span class="checkbox_base_grn">' . $return_str
                      . '</span>';
    }

    return $return_str;
}


<?php

/**
 * @name   grn_radio
 *  ラジオボタン
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
 *
 *  記述例
 *  <pre>{grn_radio name='validation' id='validation_valid' value='valid' caption='有効'}</pre>
 *  出力例
 *  <pre>&lt;input type="radio" name="validation" id="validation_valid" value="valid"&gt;
 *  &lt;label for="validation_valid" onMouseOver="this.style.color='#ff0000'"
 *  onMouseOut="this.style.color=''"&gt;有効&lt;/label&gt;</pre>
 *
 * @date   2005/1/20
 * @author K.Tokuta
 *
 */
function smarty_function_grn_radio($params, &$smarty)
{
    $function_name = 'grn_radio';

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

    if (strlen(@ $params['onclick']) > 0) {
        $onclick = ' onclick="' . htmlspecialchars($params['onclick']) . '"';
    }

    // checked
    $checked = (@ $params['checked']) ? ' checked' : '';
    // disabled
    $disabled = (@ $params['disabled']) ? ' disabled' : '';

    $input_str
        = sprintf('<input type="radio" name="%s" id="%s" value="%s"%s%s%s>',
        htmlspecialchars($name), htmlspecialchars($id), $value, $onclick,
        htmlspecialchars($checked), htmlspecialchars($disabled));

    // label_option
    $class = '';
    if (array_key_exists('class', $params) && strlen($params['class']) > 0) {
        $class = $params['class'];
    }
    if (@ $params['disabled']) {
        if (strlen($class) > 0) {
            $label_option = ' class="form_disable ' . $class . '"';
        } else {
            $label_option = ' class="form_disable"';
        }
    } else {
        if (strlen($class) > 0) {
            $label_option = ' class="' . $class
                            . '" onMouseOver="this.style.color=\'#ff0000\'" onMouseOut="this.style.color=\'\'"';
        } else {
            $label_option
                = ' onMouseOver="this.style.color=\'#ff0000\'" onMouseOut="this.style.color=\'\'"';
        }
    }

    $label_str = '<label for="%s"%s>';
    if (array_key_exists('label_class', $params) && $params['label_class']) {
        $label_str = '<label class="' . $params['label_class']
                     . '" for="%s"%s>';
    }
    $label_str = sprintf($label_str,
        htmlspecialchars($params['id']), $label_option);

    // caption
    if (array_key_exists('caption', $params)) {
        $caption_str = htmlspecialchars($params['caption']);
    }

    //div cover
    $div_cover = '';
    $close_div_cover = '';
    if (array_key_exists('div_cover', $params) && $params['div_cover']) {
        $div_cover = '<div class="' . $params['div_cover'] . '">';
        $close_div_cover = '</div>';
    }
    // span cover radiobutton_base_grn
    $span_cover = '';
    $close_span_cover = '';
    if (array_key_exists('span_cover', $params)) {
        $span_cover = '<span class="radiobutton_base_grn">';
        $close_span_cover = '</span>';
    }

    $return_str = $div_cover . $span_cover . $input_str . $label_str
                  . $caption_str . '</label>' . $close_span_cover
                  . $close_div_cover;

    return $return_str;
}


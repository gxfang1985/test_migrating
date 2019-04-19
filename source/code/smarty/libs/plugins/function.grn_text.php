<?php
require_once 'fw/i18n.csp';

/**
 * @name   grn_text
 *  一行文字列
 *
 * @date   2003/8/26
 * @author HATA,Shinya
 *
 * @param  string  name                INPUTタグのname属性
 *
 * @option string  class               INPUTタグのclass属性
 * @option boolean necessary           必須入力かどうか
 * @option string  value               初期値（INPUTタグのvalue属性）
 * @option string  size                INPUTタグのSIZE属性
 * @option string  maxlength           INPUTタグのMAXLENGTH属性
 * @option string  title               ツールチップ（INPUTタグのTITLE属性）
 * @option boolean disabled_return_key リターンキーを無効にするかどうか
 * @option boolean disabled            禁止状態
 * @option boolean id                  idの指定
 * @option string  style               INPUTタグのstyle属性
 *
 *  maxlength='-1' とすると、最大入力文字数は無制限となる。<br>
 *  maxlength を指定しないと、'100' となる。<br>
 *  necessary=TRUE を指定すると、自動的に ' class="cb_text_ess"' となる。<br>
 *  disable_return_key=TRUE を指定すると、
 *  入力ボックスにフォーカスあるときにリターンキーを押下しても、
 *  フォーム内のあるボタンが押されたのと同様の処理が動作することはない。
 *
 *  記述例
 *  <pre>{grn_text name='subject' value='Welcome' necessary size='50' maxlength='100'
 *  title='subject' disable_return_key=true}</pre>
 *  出力例
 *  <pre>&lt;input type="text" class="cb_text_ess" name="subject" value="Welcome" size="50"
 *  maxlength="100" title="subject" onKeyPress="return event.keyCode != 13;"&gt;</pre>
 *
 * @date   2005/1/20
 * @author K.Tokuta
 *
 */
function smarty_function_grn_text($params, &$smarty)
{
    $function_name = 'grn_text';

    // necessary parameter and value
    if (strlen(@ $params['name']) > 0) {
        $name = $params['name'];
    } else {
        return htmlspecialchars($function_name) . ': missing name parameter';
    }

    // class
    $class_str = '';
    if (strlen(@ $params['class']) > 0) {
        $class_str = ' class="' . htmlspecialchars(@ $params['class']) . '"';
    }
    if ( ! $class_str && (@ $params['necessary'])) {
        $class_str = ' class="cb_text_ess"';
    }

    // style
    $style_str = '';
    if (strlen(@ $params['style']) > 0) {
        $style_str = ' style="' . htmlspecialchars(@ $params['style']) . '"';
    }

    // value
    $value_str = (strlen(@ $params['value']) > 0)
        ?
        ' value="' . htmlspecialchars(@ $params['value']) . '"'
        :
        '';

    // size
    $size_str = (strlen(@ $params['size']) > 0)
        ?
        ' size="' . htmlspecialchars(@ $params['size']) . '"'
        :
        '';

    // title
    $title_str = (strlen(@ $params['title']) > 0)
        ?
        ' title="' . htmlspecialchars($params['title']) . '"'
        :
        '';

    // disable_return_key
    $disable_return_key = (@ $params['disable_return_key'])
        ?
        ' onKeyPress="return event.keyCode != 13;"'
        :
        '';

    // disabled
    $disabled = (@ $params['disabled'])
        ?
        ' disabled'
        :
        '';

    // id
    $id_str = (strlen(@ $params['id']) > 0)
        ?
        ' id="' . htmlspecialchars($params['id']) . '"'
        :
        '';

    // onchange
    $onchange_str = (strlen(@ $params['onchange']) > 0)
        ?
        ' onChange="' . htmlspecialchars($params['onchange']) . '"'
        :
        '';

    // onfocus
    $onfocus_str = (strlen(@ $params['onfocus']) > 0)
        ?
        ' onFocus="' . htmlspecialchars($params['onfocus']) . '"'
        :
        '';

    // maxlength
    $maxlength_str = '';
    $maxlength = @ $params['maxlength'];
    if (is_null($maxlength) || $maxlength === '') {
        $maxlength_str = ' maxlength="100"';
    } elseif ($maxlength != '-1') {
        if (strlen($maxlength) > 0) {
            $maxlength_str = ' maxlength="' . htmlspecialchars($maxlength)
                             . '"';
        }
    }
    $code_element_str = '';
    if (isset($params['code'])) {
        $code_element_str = ' data-code="' . $params['code'] . '"';
    }
    $type_element_str = '';
    if (isset($params['type'])) {
        $type_element_str = ' data-type="' . $params['type'] . '"';
    }
    $return_str = sprintf('<input ' . $id_str
                          . ' type="text" name="%s"%s%s%s%s%s%s%s%s%s%s%s%s>',
        htmlspecialchars($name), $class_str, $size_str, $maxlength_str,
        $title_str,
        $value_str, $onchange_str, $onfocus_str, $disable_return_key,
        htmlspecialchars($disabled),
        $style_str, $code_element_str, $type_element_str);

    return $return_str;
}


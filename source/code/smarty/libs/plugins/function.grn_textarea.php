<?php
/**
 * @name grn_textarea
 *  複数行文字列
 *
 * @date    2003/8/26
 * @author  HATA,Shinya <hata@cybozu.co.jp>
 *
 * @param  string  name      TEXTAREAタグのNAME属性
 *
 * @option  string  class     TEXTAREAタグのCLASS属性
 * @option  string  value     初期値
 * @option  string  cols      入力欄の横幅
 * @option  string  rows      入力欄の縦幅
 * @option  string  title     ツールチップ（TEXTAREAタグのTITLE属性）
 * @option  boolean disabled  禁止状態
 * @option  string  id        TEXTAREAタグのID属性
 *
 *  記述例
 *  <pre>{grn_textarea name='data' value='Welcome' cols='70' rows='15' title='data'}</pre>
 *  出力例
 *  <pre>&lt;textarea name="data" cols="70" rows="15" title="subject"&gt; Welcome&lt;/textarea&gt;</pre>
 *
 * @date    2005/1/20
 * @author  K.Tokuta
 *
 */

function smarty_function_grn_textarea($params, &$smarty)
{
    $function_name = 'grn_textarea';
    $return_code = "\n";

    // necessary parameter and value
    if (strlen(@ $params['name']) > 0) {
        $name = $params['name'];
    } else {
        return htmlspecialchars($function_name) . ': missing name parameter';
    }

    // class
    $class_str = (strlen(@ $params['class']) > 0)
        ?
        htmlspecialchars($params['class']) . ' autoexpand'
        :
        'autoexpand';

    if (array_key_exists('flag_mail', $params)) {
        $class_str = $class_str . " mail-textareaSignature-grn";
    }
    // dummy class
    $dummy_class_str = (strlen(@ $params['class']) > 0)
        ?
        htmlspecialchars($params['class'])
        :
        '';

    // cols
    if ( ! (array_key_exists('no_cols', $params) && $params['no_cols'])) {
        if (@ $params['cols'] === '' || is_null(@ $params['cols'])) {
            $cols_str = ' cols="50"';
        } else {
            $cols_str = ' cols="' . htmlspecialchars(@ $params['cols']) . '"';
        }
    }

    // rows
    if ( ! (array_key_exists('no_rows', $params) && $params['no_rows'])) {
        if (@ $params['rows'] === '' || is_null(@ $params['rows'])) {
            $rows_str = ' rows="5"';
        } else {
            $rows_str = ' rows="' . htmlspecialchars(@ $params['rows']) . '"';
        }
    }

    // remove rows/cols attributes on schedule/simple_add
    if (array_key_exists('simple_add', $params)) {
        $rows_str = '';
        $cols_str = '';
    }

    // title
    $title_str = (strlen(@ $params['title']) > 0)
        ?
        ' title="' . htmlspecialchars($params['title']) . '"'
        :
        '';

    $placeholder = (strlen(@ $params['placeholder']) > 0)
        ?
        ' placeholder="' . htmlspecialchars($params['placeholder']) . '"'
        :
        '';

    // disabled
    $disabled = (@ $params['disabled'])
        ?
        ' disabled'
        :
        '';

    // value
    $value_str = (array_key_exists('value', $params))
        ?
        htmlspecialchars($params['value'])
        :
        '';

    // id
    $id_str = (strlen(@ $params['id']) > 0)
        ?
        htmlspecialchars($params['id'])
        :
        'textarea_id';

    // style 
    $style_str = (strlen(@ $params['style']) > 0)
        ?
        'style="' . htmlspecialchars($params['style']) . '"'
        :
        'style="white-space:pre-wrap"';
    $code_element_str = '';
    if (isset($params['code'])) {
        $code_element_str = ' data-code="' . $params['code'] . '"';
    }
    $type_element_str = '';
    if (isset($params['type'])) {
        $type_element_str = ' data-type="' . $params['type'] . '"';
    }

    // aria-label
    $aria_label_str = array_key_exists('aria_label', $params)
        ?
        ' aria-label="' . htmlspecialchars($params['aria_label']) . '"'
        :
        '';

    $return_str
        = sprintf('<textarea id="%s" name="%s" class="%s" wrap="virtual" role="form" %s %s%s%s%s%s %s%s%s>%s%s</textarea>',
        $id_str, htmlspecialchars($name), $class_str, $aria_label_str,
        $cols_str, $rows_str, $placeholder, $title_str,
        htmlspecialchars($disabled),
        $style_str, $code_element_str, $type_element_str,
        htmlspecialchars($return_code), $value_str);

    $return_str .= sprintf('<textarea style="white-space: pre-wrap; left:-9999px; position:absolute; top:0;" id="%s" class="%s" wrap="virtual" %s%s%s%s disabled>%s%s</textarea>',
        "dummy_textarea_" . $id_str, $dummy_class_str,
        $cols_str, $rows_str, $title_str, htmlspecialchars($disabled),
        htmlspecialchars($return_code), $value_str);

    if (array_key_exists('formsize_ajust_grn', $params) && $params['formsize_ajust_grn'] == true) {
        $return_str = '<div class="formsize_ajust_grn">' . $return_str . '</div>';
    }

    return $return_str;
}


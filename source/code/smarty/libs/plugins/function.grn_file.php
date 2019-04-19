<?php

/**
 * @name   grn_file
 *  ファイル選択
 *
 * @date   2003/8/26
 * @author HATA,Shinya
 *
 * @param  string  name        INPUTタグのname属性
 *
 * @option string  class       INPUTタグのclass属性
 * @option boolean necessary   必須入力かどうか
 * @option string  abssize     入力欄の横幅（補正なし）
 * @option string  size        入力欄の横幅
 * @option string  title       ツールチップ（INPUTタグのTITLE属性）
 * @option boolean disabled_return_key リターンキーを無効にするかどうか
 *
 *  necessary=TRUE を指定すると、自動的に ' class="cb_text_ess"' となる<br>
 *  disable_return_key=TRUE を指定すると
 *  入力ボックスにフォーカスあるときにリターンキーを押下しても、
 *  フォーム内のあるボタンが押されたのと同様の処理が動作することはない<br>
 *  INPUTタグのSIZE属性 は「参照」ボタンの幅を調整した上で出力される。
 *  ただし、abssize にて横幅を指定した場合は、補正されずに出力される。<br>
 *  absize と size では absize が優先される。
 *
 *  記述例
 *  <pre>{grn_file name="file" size="50" disable_return_key=true}</pre>
 *  出力例
 *  <pre>&lt;input type="file" name="file" size="39" onKeyPress="return event.keyCode != 13;"&gt;
 */

require_once 'fw/i18n.csp';

function smarty_function_grn_file($params, &$smarty)
{
    $function_name = "grn_file";

    // necessary parameter and value
    if ( ! array_key_exists('name', $params)) {
        return htmlspecialchars($function_name) . ": missing name parameter";
    }

    $multiple = false;
    if (array_key_exists('multiple', $params)) {
        $multiple = $params['multiple'];
    }

    $id = false;
    if (array_key_exists('id', $params)) {
        $id = $params['id'];
    }

    if ($params['name'] === '' || is_null($params['name'])) {
        return htmlspecialchars($function_name) . ": missing name parameter";
    }

    $str = '<input';
    $str .= " type=\"file\"";
    if (@ $params['class'] != '' && ! is_null(@ $params['class'])) {
        $class = " class=\"" . htmlspecialchars(@ $params['class']) . "\"";
    }
    if ( ! $class && @ $params['necessary']) {
        $str .= ' class="cb_text_ess"';
    }
    $str .= $class;
    if ($params['name'] === '' || is_null($params['name'])) {
        $str .= " name=\"\"";
    } else {
        $str .= " name=\"" . htmlspecialchars($params['name']) . "\"";
    }
    if (array_key_exists('abssize', $params)) {
        if ($params['abssize'] != '' && ! is_null($params['abssize'])) {
            $str .= " size=\"" . htmlspecialchars($params['abssize']) . "\"";
        }
    } elseif (array_key_exists('size', $params)) {
        if (($params['size'] - 11) != '' && ! is_null(($params['size'] - 11))) {
            $str .= " size=\"" . htmlspecialchars($params['size'] - 11) . "\"";
        }

    } else {
        $str .= " size=\"40\"";
    }
    if (array_key_exists('title', $params)) {
        $title = htmlspecialchars($params['title']);
    }

    if ($title != '' && ! is_null($title)) {
        $str .= " title=\"" . htmlspecialchars($title) . "\"";
    }
    if (@ $params['disable_return_key']) {
        $str .= ' onKeyPress="return event.keyCode != 13;"';
    }
    if ($id) {
        $str .= ' id="' . $id . '"';
    }
    if ($multiple) {
        $str .= ' multiple';
    }
    $str .= ">";

    return $str;
}


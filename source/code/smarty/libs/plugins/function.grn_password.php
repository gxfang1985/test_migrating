<?php
/**
 * @name grn_password
 *  パスワード
 *
 * @date   2003/8/26
 *
 * @param  string  name                INPUTタグのNAME属性
 * @param  string  purpose             入力の目的
 *
 * @option string  class               INPUTタグのCLASS属性
 * @option string  value               暗号化されたパスワード値
 * @option string  size                入力欄の横幅（INPUTタグのSIZE属性）
 * @option string  maxlength           最大入力文字数（INPUTタグのMAXLENGTH属性）
 * @option string  title               ツールチップ（INPUTタグのTITLE属性）
 * @option boolean disable_return_key  リターンキーを無視するかどうか
 * @option boolean disabled            禁止状態
 *
 *  maxlength='-1' とすると、最大入力文字数は無制限となる<br>
 *  maxlength を指定しないと、'64' となる<br>
 *  disable_return_key=TRUE を指定すると、
 *  入力ボックスにフォーカスあるときにリターンキーを押下しても、
 *  フォーム内のあるボタンが押されたのと同様の処理が動作することはない <br>
 *  purpose の取りうる値は以下の通り
 *  <li>'modify' ： パスワードの変更
 *  <li>'retype' ： パスワードの変更、および初期化時の確認入力用
 *  <li>'encrypt'： パスワードの変更（value値を直接指定する場合）
 *  <li>'init'   ： パスワードの初期化
 *  <li>'auth'   ： 認証 <br>
 *  value はPOP3等のアカウントのパスワードを設定する際に、
 *  暗号化したパスワード値をタグのvalueオプションに設定する際に用いる。
 *  purpose='encrypt' といっしょに用いる
 *
 *  記述例
 *  <pre>{grn_password name='passowrd' purpose='modify' size='50'}</pre>
 *  出力例
 *  <pre>&lt;input type="password" name="password" value="***************" size="50"
 *   maxlength="64"&gt;</pre>
 *
 * @date   2005/1/20
 * @author K.Tokuta
 *
 * @option boolean id                  idの指定
 * @date   2008/09/03
 * @author M.Matsumoto
 */

function smarty_function_grn_password($params, &$smarty)
{
    $function_name = 'grn_password';

    // necessary parameter and value
    if (array_key_exists('name', $params)) {
        $name = $params['name'];
    } else {
        return htmlspecialchars($function_name) . ': missing name parameter';
    }

    if (array_key_exists('purpose', $params)) {
        $purpose = $params['purpose'];
    } else {
        return htmlspecialchars($function_name) . ': missing purpose parameter';
    }

    // class
    $class_str = (strlen(@ $params['class']) > 0)
        ?
        ' class="' . htmlspecialchars($params['class']) . '"'
        :
        '';

    // size
    $size_str = (strlen(@ $params['size']) > 0)
        ?
        ' size="' . htmlspecialchars($params['size']) . '"'
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

    // maxlength
    $maxlength_str = '';
    $maxlength = @ $params['maxlength'];
    if (strlen($maxlength) == 0) {
        $maxlength_str = ' maxlength="64"';
    } elseif ($maxlength != '-1') {
        if (strlen($maxlength) > 0) {
            $maxlength_str .= ' maxlength="' . htmlspecialchars($maxlength)
                              . '"';
        } else {
            $maxlength_str .= ' maxlength=""';
        }
    }

    // purpose
    $purpose_str = '';
    switch ($purpose) {

        case 'modify':
            $purpose_str = ' value="***************"';
            break;

        case 'retype':
            $purpose_str = ' value="***************"';
            break;

        case 'encrypt':
            if ( ! array_key_exists('value', $params)) {
                return htmlspecialchars($function_name)
                       . ': missing value parameter';
            }
            if (strlen(@ $params['value']) > 0) {
                $purpose_str = ' value="' . htmlspecialchars($params['value'])
                               . '"';
            } else {
                $purpose_str = ' value=""';
            }
            break;

        case 'init':
            break;

        case 'auth':
            break;
    }

    $autocomplete_str = ' autocomplete="on"';
    $dummy_password_str = '';
    $dummy_password_ie_str = '';
    if (strcasecmp(@$params['autocomplete'], 'on') != 0) {
        $autocomplete_str = ' autocomplete="off"';
        // disable password autocomplete when blurred (for FF3)
        $dummy_password_str
            = '<span style="display:none"><input type="password" disabled="disabled"></span>';

        // another dummy password for IE bug (only happens over https)
        $browser = cb_ui_get_browser();
        if (cb_is_https() && $browser['type'] === 'msie') {
            $dummy_password_ie_str
                = '<span style="display:none"><input type="password" disabled="disabled"></span>';
        }
    }
    $return_str = sprintf('<input ' . $id_str
                          . ' type="password" name="%s" %s%s%s%s%s%s%s%s>',
        htmlspecialchars($name), $class_str, $size_str, $maxlength_str,
        $title_str,
        $purpose_str, $autocomplete_str, $disable_return_key,
        htmlspecialchars($disabled));

    return $dummy_password_str . $dummy_password_ie_str . $return_str;
}


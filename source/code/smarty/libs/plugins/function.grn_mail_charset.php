<?php

/**
 * @name   grn_mail_charset
 *  キャラクタセット選択（メール用）
 *
 * @param  string  name    INPUTタグのNAME属性
 *
 * @option string  default 初期値
 * @option mixed   hide_select_encoding_msg 「（選択してください）」を非表示にする
 * @option mixed   hide_auto_ancoding_msg   「（自動選択）」を非表示にする
 * @option mixed   disable_onchange          onchange イベントを無効にする
 * @option bool    force_locale             true only show charsets which current locale support, false show all charsets.
 *
 * @date   2005/04/12
 * @author A.Ikeda
 *
 *  記述例
 *  <pre>{grn_mail_charset name="charset" default="ASCII"}
 */
function smarty_function_grn_mail_charset($params, &$smarty)
{
    $function_name = "grn_mail_charset";

    // necessary parameter and value
    $name = @ $params['name'];
    if (strlen($name) <= 0) {
        return htmlspecialchars($function_name) . ": name is necessary";
    }

    if (strlen(@ $params['default']) > 0) {
        $default = $params['default'];
    }

    $three_pane = null;
    if (array_key_exists('3pane', $params)) {
        $three_pane = $params['3pane'];
        unset($params['3pane']);
    }

    require_once('mail/utility.csp');
    $encodings = [];
    $force_locale = @$params['force_locale'];
    // get only charset which locale support
    if ($force_locale) {
        require_once("fw/i18n.csp");
        $i18n = CB_I18n::getInstance();
        $current_locale = $i18n->getCurrentLanguage();
        global $G_config_common;
        $current_locale_charset = $G_config_common->get('Mail',
            'resolve_locale_' . $current_locale);
        if ($current_locale_charset) {
            $encodings = explode(' ', $current_locale_charset);
        }
    } else // get all charset
    {
        $encodings = GRN_Mail_Utility::getAvailableEncodings();
    }

    $encoding_names = [];
    if ( ! array_key_exists('hide_select_encoding_msg', $params)) {
        $encoding_names[] = cb_msg(GRN_MAIL_MODULE_ID, 'select_encoding');
    }
    if ( ! array_key_exists('hide_auto_encoding_msg', $params)) {
        $encoding_names['auto'] = cb_msg(GRN_MAIL_MODULE_ID, 'auto_encoding');
    }

    foreach ($encodings as $encoding) {
        $encoding_names[$encoding] = cb_msg('fw.encodings', $encoding);
    }

    $str = sprintf('<select size="1" name="%s"', htmlspecialchars($name));
    if ( ! array_key_exists('disable_onchange', $params)) {
        if ($three_pane) {
            $str .= ' onchange="if(this.selectedIndex == 0) return false;grn.page.mail.mail_list.changeCharset(\'change\',this.form.name);"';
        } else {
            $str .= ' onchange="if(this.selectedIndex == 0) return false; cmd.value=\'change\'; submit(this.form);"';
        }
    }
    $str .= ">\n";
//    $str = sprintf('<select size="1" name="%s" onchange="if(this.selectedIndex == 0) return false; cmd.value=\'change\'; submit(this.form);">', $name, $name);
    foreach ($encoding_names as $key => $value) {
        $selected = ($key === $default) ? ' selected' : '';
        $str .= sprintf('<option value="%s"%s>%s</option>',
                htmlspecialchars($key), htmlspecialchars($selected),
                htmlspecialchars($value)) . "\n";
    }
    $str .= '</select>';

    return $str;
}


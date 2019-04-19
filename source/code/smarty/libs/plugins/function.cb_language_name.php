<?php
/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function smarty_function_cb_language_name($params, &$smarty)
{
    require_once("fw/i18n.csp");
    require_once("fw/i18n/locale.csp");
    $i18n = CB_I18N::getInstance();

    if (array_key_exists("code", $params)) {
        $language_code = $params["code"];
    } elseif (array_key_exists("id", $params)) {
        $language_code = CB_LanguageManager::getLanguageCode($params["id"]);
    } else {
        cb_throw_error(); //TODO
    }

    return CB_LanguageManager::getLanguageName($language_code);
}


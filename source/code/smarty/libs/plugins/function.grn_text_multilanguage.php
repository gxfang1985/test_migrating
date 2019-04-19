<?php

/**
 * Show the text field which enable a user to put multilingual data.
 *
 * The following parameter is required.
 * element_name : The name of the element
 * form_name    : The name of the form.
 * error_message: The message passed to SmartyValiate
 *
 * The following parameters are optional
 * values    : the initial values of this field of each language. like this.
 *             array( 'ja' => '東京', 'en' => 'Tokyo' )
 * error_message: The message passed to SmartyValiate. If it is passed, the element will be validated.
 * form_name    : The name of the form. This parameter is required only when error_message is given
 *
 */
function smarty_function_grn_text_multilanguage($params, &$smarty)
{
    require_once("fw/i18n/locale.csp");
    $language_codes = CB_LanguageManager::getAvailableLanguages();
    array_unshift($language_codes, CB_I18N_DEFUALT_LANGUAGE_CODE);

    $resource = [
        "addLanguage"    => cb_msg("fw.ui", "add_language"),
        "deleteLanguage" => cb_msg("fw.ui", "delete_language"),
    ];

    $values = [];
    if (array_key_exists("values", $params) && is_array($params['values'])) {
        $values = $params['values'];
    }
    $element_name
        = _smarty_function_grn_text_multilanguage_getRequiredParam($params,
        "element_name");

    $form_name = array_key_exists("error_message", $params)
        ? _smarty_function_grn_text_multilanguage_getRequiredParam($params,
            "form_name") : false;
    $error_message = array_key_exists("error_message", $params)
        ? $params['error_message'] : false;
    $input_style = array_key_exists("input_style", $params)
        ? $params['input_style'] : null;

    $t = new GRN_Smarty();
    $t->assign("language_codes", $language_codes);
    $t->assign("resource", $resource);
    $t->assign("values", $values);
    $t->assign("element_name", $element_name);
    $t->assign("error_message", $error_message);
    $t->assign("form_name", $form_name);
    $t->assign("input_style", $input_style);

    $t->assign("is_smarty_validate", $form_name !== false);
    $t->assign("lang_choice", CB_LanguageManager::getAvailableLanguages());
    $t->assign("show_addition_button",
        count($values) <= count(CB_LanguageManager::getAvailableLanguages()));

    return $t->fetch("grn/text_multilanguage.tpl");
}

function _smarty_function_grn_text_multilanguage_getRequiredParam(
    $params,
    $name
) {
    $t = new GRN_Smarty();
    if (array_key_exists($name, $params) && is_string($params[$name])) {
        return $params[$name];
    }
    $t->trigger_error("grn_text_multilanguage: '{$name}' parameter is required.");
}

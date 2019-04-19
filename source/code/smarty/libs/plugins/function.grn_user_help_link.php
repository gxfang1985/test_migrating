<?php

function smarty_function_grn_user_help_link($params, $smarty)
{
    require_once("fw/i18n.csp");
    $i18n = CB_I18N::getInstance();
    $language = $i18n->getCurrentLanguage();

    require_once('fw/i18n/locale.csp');
    $available_language = CB_LanguageManager::getAvailableLanguagesForHelp();
    if ( ! in_array($language, $available_language)) {
        $language = 'en';
    }

    if (defined("ON_FOREST")) {
        require_once('fw/slash_util.csp');
        $region = CB_SlashUtil::getRegion();

        if ($region && $region === "CN") {
            $link
                = "http://r.cybozu.cn/g/garoon/cn/{$language}/g/user/index.html";
        } else {
            $link
                = "http://r.cybozu.com/g/garoon/jp/{$language}/g/user/index.html";
        }

        return $link;
    } else {
        global $G_config_common;
        $app_path = $G_config_common->get('Global', 'app_path');
        require_once("grn/ui.csp");

        return "{$app_path}/help/{$language}/g410/user/index.html" . "?"
               . grn_get_build_date();
    }
}

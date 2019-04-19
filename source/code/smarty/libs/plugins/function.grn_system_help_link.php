<?php

require_once("grn/ui.csp");
require_once('fw/i18n/locale.csp');

function smarty_function_grn_system_help_link($params, $smarty)
{
    require_once("fw/i18n.csp");
    $i18n = CB_I18N::getInstance();
    $language = $i18n->getCurrentLanguage();

    if (defined("ON_FOREST")) {
        require_once('fw/slash_util.csp');
        $region = CB_SlashUtil::getRegion();

        $link = 'http://r.cybozu.com/g/garoon/jp/en/g/index.html';
        if ($region && $region === "CN") {
            $link = 'http://r.cybozu.cn/g/garoon/cn/en/g/index.html';
        }

        if ($language === 'zh' || $language === 'ja') {
            $link = str_replace('en', $language, $link);
        }

        return $link;
    } else {
        global $G_config_common;
        $app_path = $G_config_common->get('Global', 'app_path');

        if ($language === 'ja') {
            return "{$app_path}/help/{$language}/g410/index.html" . "?" . grn_get_build_date();
        }

        $available_language = CB_LanguageManager::getAvailableLanguagesForHelp();
        if ( ! in_array($language, $available_language)) {
            $language = 'en';
        }

        return "https://r.cybozu.com/g/garoon/jp/{$language}/g410/guide/index.html";
    }
}

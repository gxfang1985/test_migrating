<?php

use grn\space\common\data\bean\DatetimeFormat;
use grn\space\common\utility\SpaceDatetimeUtility;

/**
 * Display the expiration date of space.
 *
 * @param $parameters
 * @param $smarty
 *
 * @return null|string
 */
function smarty_function_grn_space_display_expiration_date(
    $parameters,
    & $smarty
) {
    $login_user = cb_get_login_user();
    $login_id = $login_user->getOID();

    require_once("fw/i18n.csp");
    $i18n = \CB_I18N::getInstance();
    $language_code = $i18n->getCurrentLanguage();
    $timezone_name = $i18n->getCurrentTimezone();

    require_once("fw/i18n/locale.csp");
    $datetime_format = new DatetimeFormat();
    $datetime_format->setLongDateFormat(\CB_LocaleManager::getCurrentLongDateFormat($login_id));
    $datetime_format->setShortDateFormat(\CB_LocaleManager::getCurrentShortDateFormat($login_id));
    $datetime_format->setTimeFormat(\CB_LocaleManager::getCurrentTimeFormat($login_id));

    /** @var \grn\space\data\bean\Space $space */
    $space = $parameters['space'] ?? null;
    $dynamic_format = $parameters['dynamic_format'] ?? null;
    $html_result = null;

    if ($space == null) {
        return $html_result;
    }

    if ( ! $space->getExpirationDateTime()->getTimestamp()) {
        return $html_result;
    }
    if ($dynamic_format) {
        $format_type = SpaceDatetimeUtility::DISPLAY_TYPE_DYNAMIC_IS_NOW_TIME;
    } else {
        $format_type = $space->getIsExpirationDateSpecifiedTime()
            ? SpaceDatetimeUtility::DISPLAY_TYPE_LONGDATE_AND_TIME
            : SpaceDatetimeUtility::DISPLAY_TYPE_LONG_DATE;
    }
    SpaceDatetimeUtility::constructDisplayDatetimeOfSpace($space,
        $datetime_format, $format_type, $language_code, $timezone_name);
    $html_result = $space->getDisplayExpirationDateTime();

    return $html_result;
}

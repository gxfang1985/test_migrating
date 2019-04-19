<?php
require_once 'fw/date.csp';

/**
 * @name   grn_date_format
 * @description show date/time with specified format
 *
 * @date        2004/11
 * @author      M.Oomori
 *
 * @param  string  format  format id, if not specified, use 'DateTimeCompact'
 *
 * @option      mixed   date    date time ( CB_DateTime or CB_TimeStamp )
 *
 *  date には、int, string, CB_DateTime, CB_Date, CB_Time のデータ型が有効です。<br>
 *  string の場合、内容は整数値（タイムスタンプ値）、
 *  およびMySQLの日付時刻フォーマット（YYYY-MM-DD HH:MM:SS）が有効です。<br>
 *  $date が省略された場合、現在日時が使われます。
 */
function smarty_function_grn_date_format($params, &$smarty)
{
    $date = array_key_exists('date', $params) ? $params['date'] : null;
    $format_key = array_key_exists('format', $params) ? $params['format']
        : "DateTimeCompact";
    $language = array_key_exists('language', $params) ? $params['language']
        : null;
    $tzname = array_key_exists('tzname', $params) ? $params['tzname']
        : null;
    $user_id = array_key_exists('user', $params) ? $params['user'] : null;
    $page = array_key_exists('page', $params)
        ? strtolower($params['page']) : null;

    require_once("fw/date.csp");
    if ( ! is_null($page)) {
        ;
    }// && $page == 'personal_month')
    {
        $dateArr = cb_date_datetime2array($date, $language, $tzname);

        global $G_container_base;
        $uum = $G_container_base->getInstance("uum");
        $loginUser = $uum->getLoginUser();
        require_once("fw/i18n/locale.csp");
        if ($page == 'personal_month') {
            $date_format
                = CB_LocaleManager::getCurrentShortDateFormat($loginUser->getOID());

            $month_pos = strpos($date_format, "&&mon&&");
            if ($month_pos === false) {
                $month_pos = strpos($date_format, "&&monthfull&&");
            }
            if ($month_pos < strpos($date_format, "&&mday&&")) {
                return cb_msg('fw.date', "DateShortMini_MD", $dateArr);
            } else {
                return cb_msg('fw.date', "DateShortMini_DM", $dateArr);
            }
        } elseif ($page == 'mobile_schedule_groupview') {
            $format_key
                = CB_LocaleManager::getCurrentTimeFormat($loginUser->getOID());
        }
    }

    return cb_date_format($format_key, $date, $user_id, $tzname, $language);
}



<?php
require_once 'fw/date.csp';

/**
 * @name   cb_date_format
 *  国際化対応日付時刻表記
 *
 * @date   2003/12/15
 * @author HATA,Shinya
 *
 * @param  string  format  フォーマットID
 *
 * @option mixed   date    日時
 *
 *  date には、int, string, CB_DateTime, CB_Date, CB_Time のデータ型が有効です。<br>
 *  string の場合、内容は整数値（タイムスタンプ値）、
 *  およびMySQLの日付時刻フォーマット（YYYY-MM-DD HH:MM:SS）が有効です。<br>
 *  $date が省略された場合、現在日時が使われます。
 */
function smarty_function_cb_date_format($params, &$smarty)
{

    $date = array_key_exists('date', $params) ? $params['date'] : null;
    $format_key = array_key_exists('format', $params) ? $params['format']
        : "DateTimeCompact";
    $language = "ja";
    $tzname = array_key_exists('tzname', $params) ? $params['tzname']
        : null;
    $user_id = array_key_exists('user', $params) ? $params['user'] : null;

    require_once("fw/date.csp");

    return cb_date_format($format_key, $date, $user_id, $tzname, $language);
}



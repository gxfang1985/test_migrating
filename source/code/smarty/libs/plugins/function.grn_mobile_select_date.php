<?php
require_once 'fw/i18n.csp';
require_once 'fw/date.csp';
require_once 'grn/calendar.csp';

function smarty_function_grn_mobile_select_date($params, &$smarty)
{
    $function_name = "grn_mobile_select_date";
    require_once("grn/smarty.csp");
    $t = new GRN_Smarty();

    // id of select date element
    $id = cb_at($params, 'id', '');
    $t->assign('id', $id);

    // id of associate element
    $id_associate = cb_at($params, 'id_associate', '');
    $t->assign('id_associate', $id_associate);

    // icon only - display only icon calendar
    $icon_only = cb_at($params, 'icon_only', false);
    $t->assign('icon_only', $icon_only);

    // icon class - css class to display icon
    $icon_class = cb_at($params, 'icon_class', false);
    $t->assign('icon_class', $icon_class);

    $input_date = cb_at($params, 'date', null);
    $t->assign('date', $input_date);
    $date_array = explode('-', $input_date);

    $float_left = cb_at($params, 'float_left', null);
    $t->assign('float_left', $float_left);

    // string resource
    $year_unit = cb_msg('fw.ui', 'date_year_unit');
    $month_unit = cb_msg('fw.ui', 'date_month_unit');
    $day_unit = cb_msg('fw.ui', 'date_day_unit');
    $delimiter = cb_msg('fw.ui', 'date_delimiter');
    $date_order = cb_msg('fw.date', 'ui_date_order');

    // get wday name from message resource
    $wday_name = [];
    for ($i = 0; $i < 7; $i++) {
        $wday_name[$i] = cb_msg('fw.date', "WDayShort{$i}");
    }

    $login = cb_get_login_user();
    $user_language = CB_LocaleManager::getCurrentLanguage($login->getOID());
    $t->assign('locale', $user_language);

    if ( ! $icon_only) {
        $format_str = '';
        if ( ! is_null($input_date) && is_array($date_array)) {
            $cdate = new CB_Date();
            $cdate->year = isset($date_array[0]) ? $date_array[0] : '';
            $cdate->month = isset($date_array[1]) ? $date_array[1] : '';
            $cdate->day = isset($date_array[2]) ? $date_array[2] : '';

            $t->assign('day', $cdate->day);
            $t->assign('month', $cdate->month);
            $t->assign('year', $cdate->year);

            $cdate_ex = new CB_DateEx($cdate);
            $wday = $cdate_ex->getDayOfWeek();

            $space = htmlspecialchars(' ');
            if ($user_language == 'zh') {
                $space = '';
            }
            $len = strlen($date_order);
            for ($i = 0; $i < $len; $i++) {
                if ($i > 0) {
                    $format_str .= $delimiter;
                }

                switch ($date_order{$i}) {
                    case 'Y':
                        $format_str .= htmlspecialchars($cdate_ex->year)
                                       . $space . $year_unit . $space;
                        break;
                    case 'n':
                        $format_str .= cb_msg("fw.date",
                                "MonthShort" . intval($cdate_ex->month))
                                       . $space . $month_unit . $space;
                        break;
                    case 'j':
                        $format_str .= htmlspecialchars($cdate_ex->day) . $space
                                       . '(' . $wday_name[$wday] . ')' . $space;
                        break;
                }
            }
        }
        $t->assign('date_str', $format_str);
    }

    static $static_loaded_datepicker = false;
    $is_first_loaded_datepicker = false;
    if ( ! $static_loaded_datepicker) {
        $t->assign('year_unit', $year_unit);
        $t->assign('month_unit', $month_unit);
        $t->assign('day_unit', $day_unit);
        $t->assign('delimiter', $delimiter);
        $t->assign('date_order', $date_order);

        $month_name = [];
        for ($month = 1; $month < 13; $month++) {
            $month_name[] = cb_msg("fw.date", "MonthShort" . $month);
        }
        $t->assign('month_name', $month_name);
        $t->assign('str_month_name', implode(',', $month_name));

        $wday_name = [];
        for ($i = 0; $i < 7; $i++) {
            $wday_name[$i] = cb_msg('fw.date', "WDayShort{$i}");
        }
        $t->assign('wday_name', $wday_name);
        $t->assign('str_wday_name', implode(',', $wday_name));
        $static_loaded_datepicker = true;
        $is_first_loaded_datepicker = true;
    }
    $t->assign('is_first_loaded_datepicker', $is_first_loaded_datepicker);

    return $t->fetch('grn/mobile_date_select.tpl');
}

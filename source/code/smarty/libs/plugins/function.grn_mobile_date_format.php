<?php
require_once 'fw/i18n.csp';
require_once 'fw/date.csp';
require_once 'grn/calendar.csp';

function smarty_function_grn_mobile_date_format($params, &$smarty)
{
    $function_name = 'grn_mobile_date_format';
    $return_code = "\n";

    $input_date = array_key_exists('date', $params) ? $params['date'] : null;
    $date_array = explode('/', $input_date);

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

    $format_str = '';
    if ( ! is_null($input_date) && is_array($date_array)) {
        $cdate = new CB_Date();
        $cdate->year = isset($date_array[0]) ? $date_array[0] : '';
        $cdate->month = isset($date_array[1]) ? $date_array[1] : '';
        $cdate->day = isset($date_array[2]) ? $date_array[2] : '';
        $cdate_ex = new CB_DateEx($cdate);
        $wday = $cdate_ex->getDayOfWeek();

        $space = htmlspecialchars(' ');
        $len = strlen($date_order);
        for ($i = 0; $i < $len; $i++) {
            if ($i > 0) {
                $format_str .= $delimiter;
            }

            switch ($date_order{$i}) {
                case 'Y':
                    $format_str .= htmlspecialchars($cdate_ex->year) . $space
                                   . $year_unit . $space;
                    break;
                case 'n':
                    $format_str .= cb_msg("fw.date",
                            "MonthShort" . $cdate_ex->month) . $space
                                   . $month_unit . $space;
                    break;
                case 'j':
                    $format_str .= htmlspecialchars($cdate_ex->day) . $space
                                   . '(' . $wday_name[$wday] . ')' . $space;
                    break;
            }
        }
    }
    // js
    static $static_include_javascript = false;
    $script_str = '';
    if ( ! $static_include_javascript) {
        $script_str .= '<script lang="javascript" type="text/javascript">'
                       . htmlspecialchars($return_code);
        $script_str .= '<!--' . htmlspecialchars($return_code);
        $script_str .= 'var G = grn.page.space.mobile.todo.todo_date'
                       . htmlspecialchars($return_code);
        $script_str .= 'G.year_unit = \'' . $year_unit . '\''
                       . htmlspecialchars($return_code);
        $script_str .= 'G.month_unit = \'' . $month_unit . '\''
                       . htmlspecialchars($return_code);
        $script_str .= 'G.day_unit = \'' . $day_unit . '\''
                       . htmlspecialchars($return_code);
        $script_str .= 'G.delimiter = \'' . $delimiter . '\''
                       . htmlspecialchars($return_code);
        $script_str .= 'G.date_order = \'' . $date_order . '\''
                       . htmlspecialchars($return_code);

        $script_str .= 'G.month_name = new Array("' . cb_msg("fw.date",
                "MonthShort1") . '"';
        for ($month = 2; $month < 13; $month++) {
            $script_str .= ', "' . cb_msg("fw.date", "MonthShort" . $month)
                           . '"';
        }
        $script_str .= ');' . htmlspecialchars($return_code);

        $script_str .= 'G.wday_name = new Array("' . $wday_name[0] . '"';
        for ($i = 1; $i < 7; $i++) {
            $script_str .= ', "' . $wday_name[$i] . '"';
        }
        $script_str .= ');' . htmlspecialchars($return_code);
        $script_str
            .= <<<EOD

    G.dateFormat = function( date )
    {
        var $date_order = new String(G.date_order);
        var cdate_str = new String(date);
        var cdate_arr = cdate_str.split("/");

        if ( cdate_arr == undefined && cdate_arr != Array )
        {
            return null;
        }
        var cyear  = (cdate_arr[0] == undefined) ? null : cdate_arr[0];
        var cmonth = (cdate_arr[1] == undefined) ? null : cdate_arr[1];
        var cday   = (cdate_arr[2] == undefined) ? null : cdate_arr[2];

        if ( cyear && cmonth && cday )
        {
            var cdate = new Date(cyear, cmonth-1, cday);
        }
        else
        {
            var cdate = new Date();
        }
        
        var format_str = "";
        var space = ' ';
        var len = $date_order.length;
        for( var i = 0 ; i < len ; i++ )
        {
            if( i > 0 )
            {
                format_str += G.delimiter;
            }

            switch( $date_order.charAt(i) )
            {
                case 'Y':
                   format_str += cdate.getFullYear()+ space+ G.year_unit+ space;
                    break;
                case 'n':
                    format_str += G.month_name[cdate.getMonth()]+ space+ G.month_unit+ space;
                    break;
                case 'j':
                    format_str += cdate.getDate()+ space+ '('+ G.wday_name[cdate.getDay()]+ ')'+ space;
                    break;
            }
        }
        return format_str;
    }

EOD;

        $script_str .= '//-->' . htmlspecialchars($return_code);
        $script_str .= '</script>'
                       . htmlspecialchars($return_code);
        $static_include_javascript = true;
    }

    return $script_str . $format_str;
}


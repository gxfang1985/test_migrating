<?php
require_once 'fw/i18n.csp';
require_once 'fw/date.csp';
require_once 'grn/calendar.csp';

/**
 * @name   grn_select_date
 *  日付選択
 *
 * @date   2003/9/23
 * @author HATA,Shinya
 * @date   2004/10/20
 * @author M.Oomori
 * @date   2005/1/21
 * @author K.Tokuta
 * @date   2005/3/17
 * @author SHIMADA Kunihiko
 * @option string  form_name    grn_select_dateが含まれるformタグのname属性
 * @option string  prefix       SELECTタグのNAME属性に付加する接頭辞
 * @option string  onchange     onChangeイベント時に実行するJavaScript
 * @option CB_Date date         日付の初期値
 * @option int     timestamp    日付の初期値
 * @option int     start_year   開始年
 * @option int     end_year     終了年
 * @option boolean necessary    必須かどうか
 * @option boolean show_wday    必須でない場合でも曜日を表示
 * @option boolean no_calendar  カレンダー入力を利用しないかどうか
 * @option boolean disabled     禁止状態
 * @option string  onclick_calender
 * @option boolean support_calendar_disable_ui
 *
 *  necessary=FALSE を指定すると、<option value="">--</option> の部分が追加され　
 *  必ず無効な値が選択できるようになる。<br>
 *  {grn_select_date} を通じて入力されたフォーム値は fw/ui.csp で定義されている
 *  cb_ui_get_date() を通じて CB_Date 値に変換される。<br>
 *  例）$start_date = cb_ui_get_date('start_');<br>
 *  necessary=FALSE を指定しない場合、「日」は「年月」の選択状態に応じて　
 *  曜日を表示する。<br>
 *  年月日の表示順、および年月日の単位表示はロケールに依存する
 *  （例：2003年12月15(月)(ja)、12/15(Mon)/2003(en)、15(Mon)/12/2003(en_GB)）、
 *
 *  <b>注意：fw/cb_ui_select_date.js に関して</b><br>
 *  出力されるHTMLでは fw/cb_ui_select_date.js がインクルードされているが　
 *  ２度目以降の {cb_ui_select_date} ではインクルードされないように自動制御している、
 *  逆に、fw/cb_ui_select_date.js は {cb_ui_select_date} 以外からインクルードされる
 *  ことを想定していないため、直接HTMLにSCRIPTタグで fw/cb_ui_select_date.js ゑ
 *  インクルードする記述をした後、{cb_ui_select_date} を呼び出すと　
 *  重複して cb_ui_select_date.js をインクルードすることになるので注意が必要である、
 *
 *  記述例
 *  <pre>{grn_select_date form_name='form1' prefix='start_'}</pre>
 *  出力例
 *  <pre>
 *  &lt;script lang="javascript" type="text/javascript"&gt;
 *  &lt;--
 *  var wday_name = new Array("日", "月", "火", "水", "木", "金", "土");
 *  //--&gt;
 *  &lt;/script&gt;
 *  &lt;script lang="javascript" type="text/javascript" src="/cbfw/fw/cb_ui_select_date.js"&gt;&lt;/script&gt;
 *  &lt;select name="start_year"&gt;
 *  &lt;option value="2001"&gt;2001年&lt;option&gt;
 *  &lt;option value="2002"&gt;2002年&lt;option&gt;
 *   :
 *  &lt;option value="2010"&gt;2010年&lt;option&gt;
 *  &lt;/select&gt;&lt;select name="start_month"&gt;
 *  &lt;option value="1"&gt;1月&lt;option&gt;
 *  &lt;option value="2"&gt;2月&lt;option&gt;
 *   :
 *  &lt;option value="12"&gt;12月&lt;option&gt;
 *  &lt;/select&gt;&lt;select name="start_day"&gt;
 *  &lt;option value="1" class="cb_sunday"&gt;1(日)&lt;option&gt;
 *  &lt;option value="2"&gt;2(月)&lt;option&gt;
 *   :
 *  &lt;option value="30"&gt;30(月)&lt;option&gt;
 *  &lt;/select&gt;
 *  </pre>
 */
function smarty_function_grn_select_date($params, &$smarty)
{
    $function_name = 'grn_select_date';
    $return_code = "\n";

    global $G_config_common;
    $app_path = $G_config_common->get('Global', 'app_path');

    $prefix = array_key_exists('prefix', $params) ? $params['prefix'] : null;
    $form_name = array_key_exists('form_name', $params) ? $params['form_name']
        : null;

    $onChange = array_key_exists('onchange', $params)
        ? $params['onchange'] : null;
    $onClick = array_key_exists('onclick', $params) ? $params['onclick']
        : null;
    $onClickCalendar = array_key_exists('onclick_calendar', $params)
        ? $params['onclick_calendar'] : null;

    $use_calendar_disable_ui = array_key_exists('support_calendar_disable_ui',
        $params) ? $params['support_calendar_disable_ui'] : false;

    $date_order = null;
    if (array_key_exists('date_order', $params)) {
        $date_order = $params['date_order'];
    }
    if (0 == strlen($date_order)) {
        $date_order = cb_msg('fw.date', 'ui_date_order');
    }

    $is_debug = ($G_config_common->get('Global', 'debug')
                 & ERROR_TRACE_LOG_FLAG_213);
    $config_grn = new CB_ConfigManager(cb_basedir() . '/garoon.ini', 'Global');
    if ( ! $config_grn || $is_debug) {
        $build_date = time();
    } else {
        $build_date = $config_grn->get('System', 'build_date');
    }
    $build_date .= '.text';

    // necessary
    $necessary = true;
    if (array_key_exists('necessary', $params) && ! $params['necessary']) {
        $necessary = false;
    }

    // necessary
    $show_blank = false;
    if (array_key_exists('show_blank', $params)) {
        $show_blank = $params['show_blank'];
    }

    // default date/timestamp value
    $date = array_key_exists('date', $params) ? $params['date'] : null;
    if (is_null($date)) {
        $timestamp = array_key_exists('timestamp', $params)
            ? $params['timestamp'] : null;
        if (is_numeric($timestamp)) {
            $timestampex = new CB_TimeStampEx();
            $timestampex->unix_ts = intval($timestamp);
            $date = $timestampex->getDate();
        }
    } elseif ( ! is_object($date)
               || ! (is_a($date, 'CB_Date')
                     || is_a($date, 'CB_DateTime'))
    ) {
        $date = null;
    }

    $show_wday = false;
    if (array_key_exists('show_wday', $params)) {
        $show_wday = $params['show_wday'];
    }

    $timestampex = new CB_TimeStampEx();
    $current_date = $timestampex->getDate();

    if (is_null($date) && $necessary) {
        $date = $current_date;
    }

    $date_year = $current_date->year;

    if (_grn_select_date_validate_year($date)) {
        $date_year = $date->year;
    }

    // start/end year
    // GTM-1605 Pull down menu with 21 years
    $start_year = min(9999, max(1970, $current_date->year - 10));
    // Pull down menu with 21 years doesn't apply to popup calendar 
    if ($prefix == 'popup_') {
        $end_year = min(2037,
            max(1970, max($date_year, $current_date->year) + 7));
    } else {
        $end_year = min(2037, max(1970, $current_date->year + 10));
    }
    // end GTM-1605

    // start year
    $start_year = _grn_select_date_get_param_numeric($params, 'start_year',
        $start_year, 1970, 9999, $function_name, $smarty);
    // end year
    $end_year = _grn_select_date_get_param_numeric($params, 'end_year',
        $end_year, 1970, 2037, $function_name, $smarty);

    if ($end_year < $start_year) {
        return htmlspecialchars($function_name)
               . ": 'end_year' parameter is out of range ("
               . htmlspecialchars($start_year) . " - 9999)";
    }

    // string resource
    $year_unit = cb_msg('fw.ui', 'date_year_unit');
    $month_unit = cb_msg('fw.ui', 'date_month_unit');
    $day_unit = cb_msg('fw.ui', 'date_day_unit');
    if (array_key_exists('no_delimiter', $params) && $params['no_delimiter']) {
        $delimiter = '';
    } else {
        $delimiter = cb_msg('fw.ui', 'date_delimiter');
    }

    // get wday name from message resource
    $wday_name = [];
    for ($wday = 0; $wday < 7; $wday++) {
        $wday_name[$wday] = cb_msg('fw.date', "WDayShort{$wday}");
    }

    //
    // html code
    //

    $script_str = '';
    $select_str = '';
    $return_code = "\n";

    // disabled
    $disabled = (array_key_exists('disabled', $params) && $params['disabled'])
        ? true : false;

    $calendar_start = new CB_Date();
    $calendar_start->year = $start_year;
    $calendar_start->month = 1;
    $calendar_start->day = 1;

    $calendar_end = new CB_Date();
    $calendar_end->year = $end_year;
    $calendar_end->month = 1;
    $calendar_end->day = 1;

    // include select_date.js
    static $static_include_javascript = false;
    if ( ! $static_include_javascript) {
        $script_str .= '<script lang="javascript" type="text/javascript">'
                       . htmlspecialchars($return_code);
        $script_str .= '<!--' . htmlspecialchars($return_code);
        $script_str .= 'var wday_name = new Array("' . $wday_name[0] . '"';
        for ($wday = 1; $wday < 7; $wday++) {
            $script_str .= ', "' . $wday_name[$wday] . '"';
        }
        $script_str .= ');' . htmlspecialchars($return_code);
        $script_str .= 'var openIds = new Array(0);'
                       . htmlspecialchars($return_code);
        $script_str .= '//-->' . htmlspecialchars($return_code);
        $script_str .= '</script>' . htmlspecialchars($return_code);
        $script_str .= '<script lang="javascript" type="text/javascript" src="'
                       . htmlspecialchars($app_path)
                       . '/grn/html/select_date.js?' . $build_date
                       . '"></script>' . htmlspecialchars($return_code);
    }

    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $login = $uum->getLoginUser();

    // カレンダーサービスからカレンダーを取得（セレクトボックスに表示する年数分
    $calendar_service = GRN_CalendarService::getInstance();
    $calendars = $calendar_service->getDaysInfo($calendar_start,
        $calendar_end, $login, null, false);

    // JavaScript用に祝日と就業日の配列を作成
    require_once('grn/calendar.csp');
    $calendar_util = GRN_CalendarUtil::getInstance();
    $holiday_script_str .= 'var g_arrayHolidays = new Array();'
                           . htmlspecialchars($return_code);
    $workday_script_str .= 'var g_arrayWorkdays = new Array();'
                           . htmlspecialchars($return_code);
    $holiday_list = [];
    $count = 0;
    foreach ($calendars as $key => $calendar) {
        foreach ($calendars[$key] as $calendar_event) {
            if ($calendar_event['type'] == GRN_CALENDAR_TYPE_PUBLICHOLIDAY) {
                $holiday_script_str .= 'g_arrayHolidays['
                                       . htmlspecialchars($count) . '] = "'
                                       . htmlspecialchars($key) . '";'
                                       . htmlspecialchars($return_code);
            } elseif ($calendar_util->isWorkDay($calendar_event, $login)) {
                $workday_script_str .= 'g_arrayWorkdays['
                                       . htmlspecialchars($count) . '] = "'
                                       . htmlspecialchars($key) . '";'
                                       . htmlspecialchars($return_code);
            }
        }
        $count++;
    }

    if ( ! $static_include_javascript) {
        $static_include_javascript = true;

        $script_str .= "<script language=\"javascript\" type=\"text/javascript\"><!--"
                       . htmlspecialchars($return_code);
        $script_str .= $holiday_script_str . htmlspecialchars($return_code);
        $script_str .= $workday_script_str . htmlspecialchars($return_code);

        // 日付セット用JavaScript
        if (is_null($form_name)) {
            $script_str .= "function cb_ui_select_date_init_date_select(year, month, day, prefix)"
                           . htmlspecialchars($return_code);
            $script_str .= "{" . htmlspecialchars($return_code);
            $script_str .= "    var year_select = document.getElementById(prefix+\"year\");"
                           . htmlspecialchars($return_code);
            $script_str .= "    if(year_select == undefined) return false;"
                           . htmlspecialchars($return_code);
            $script_str .= "    var month_select = document.getElementById(prefix+\"month\");"
                           . htmlspecialchars($return_code);
            $script_str .= "    if(month_select == undefined) return false;"
                           . htmlspecialchars($return_code);
            $script_str .= "    var day_select = document.getElementById(prefix+\"day\");"
                           . htmlspecialchars($return_code);
            $script_str .= "    if(day_select == undefined) return false;"
                           . htmlspecialchars($return_code);
        } else {
            $script_str .= "function cb_ui_select_date_init_date_select( form_name, year, month, day, prefix)"
                           . htmlspecialchars($return_code);
            $script_str .= "{" . htmlspecialchars($return_code);
            $script_str .= "    var str_year_select = document.forms[form_name].elements[prefix+\"year\"];"
                           . htmlspecialchars($return_code);
            $script_str .= "    if(str_year_select == undefined) return false;"
                           . htmlspecialchars($return_code);
            $script_str .= "    var str_month_select = document.forms[form_name].elements[prefix+\"month\"];"
                           . htmlspecialchars($return_code);
            $script_str .= "    if(str_month_select == undefined) return false;"
                           . htmlspecialchars($return_code);
            $script_str .= "    var str_day_select = document.forms[form_name].elements[prefix+\"day\"];"
                           . htmlspecialchars($return_code);
            $script_str .= "    if(str_day_select == undefined) return false;"
                           . htmlspecialchars($return_code);
            $script_str .= "    var year_select = eval(str_year_select);"
                           . htmlspecialchars($return_code);
            $script_str .= "    var month_select = eval(str_month_select);"
                           . htmlspecialchars($return_code);
            $script_str .= "    var day_select = eval(str_day_select);"
                           . htmlspecialchars($return_code);
        }

        $msg = cb_msg('grn.common', 'select_date_year');
        $script_str
            .= <<<EOD

    var year_options = year_select.options;
    var month_options = month_select.options;
    var day_options = day_select.options;
    var select_year = 0;

    for(var i = 0 ; i <= year_options.length - 1 ; i++)
    {
        if(year_options[i].value == year)
        {
            year_options[i].selected = true;
            select_year = 1;
        }
    }

    if( ! select_year)
    {
        if(year_options[0].value > year)
        {
            var o = document.createElement( "OPTION" );
            year_options.add(o);
            for(var i = year_options.length - 1 ; i > 0 ; i --)
            {
                var dst = year_options[i];
                var src = year_options[i - 1];
                dst.value = src.value;
                dst.text = src.text;
                dst.selected = false;
            }
            year_options[0].value = year;
            year_options[0].text = year + '$msg';
            year_options[0].selected = true;
        }
        else
        {
            var o = document.createElement( "OPTION" );
            o.value = year;
            o.text = year + '$msg';
            o.selected = true;
            year_options.add( o );
        }
    }

    for(var i = 0 ; i <= month_options.length - 1 ; i++)
    {
        if(month_options[i].value == month)
        {
            month_options[i].selected = true;
        }
    }

EOD;

        if ($necessary || $show_wday) {
            $script_str
                .= <<<EOD

    var start_date = new Date(year, month - 1, 1);
    var wday = start_date.getDay();
    var last_day = cb_ui_select_date_get_last_day(year, month);
    var offset = 0;
    if( day_options.length > 0 && day_options[0].value < 1 )
    {
        offset = 1;
        day_options[0].className = "";
        day_options[0].text = "--$day_unit";
    }

    for(i = 0 ; i < last_day ; i ++)
    {
        day_option = i + 1;
        opt_idx = i + offset;

        if(opt_idx >= day_options.length)
        {
            cb_ui_select_date_add_option(day_options, day_option);
        }
        day_options[opt_idx].value = day_option;

        if(wday == 0)
        {
            day_options[opt_idx].className = "s_date_sunday";
        }
        else if(wday == 6)
        {
            day_options[opt_idx].className = "s_date_saturday";
        }
        else
        {
            day_options[opt_idx].className = "";
        }

        if(g_arrayHolidays != null && g_arrayHolidays.length > 0)
        {
            if(cb_ui_select_date_check_holiday(g_arrayHolidays, year, month, day_option))
            {
                day_options[opt_idx].className = "s_date_holiday";
            }
        }

        day_options[opt_idx].text = day_option + "(" + wday_name[wday] + ")";
        if(day_options[opt_idx].value == day)
        {
            day_options[opt_idx].selected = true;
        }

        wday ++;
        if(wday > 6)
        {
            wday = 0;
        }
    }
EOD;

        } else {
            $script_str
                .= <<<EOD

    var last_day = cb_ui_select_date_get_last_day(year, month) + 1;
    day_options[0].className = "";
    day_options[0].text = "--$day_unit";
    for(i = 1 ; i < last_day ; i ++)
    {
        day_option = i;

        if(i >= day_options.length)
        {
            cb_ui_select_date_add_option(day_options, day_option);
        }
        day_options[i].className = "";
        day_options[i].text = day_option + "$day_unit";
        if(day_options[i].value == day)
        {
            day_options[i].selected = true;
        }
    }

EOD;
        }

        $script_str
            .= <<<EOD

    while((last_day+offset) < day_options.length)
    {
        if(day_options.remove)
        {
            day_options.remove(day_options.length - 1);
        }
        else
        {
            day_options[day_options.length - 1] = null;
        }
    }

    if ( year == "1970" && month == "1" && day_options[offset].value == "1")
    {
        if(day_options.remove)
        {
            day_options.remove(offset);
            day_options.remove(offset);
        }
        else
        {
            day_options[offset] = null;
            day_options[offset] = null;
        }
    }
      
}

EOD;

        $script_str .= "var G_yearUnit = \"" . $year_unit . "\";"
                       . htmlspecialchars($return_code);
        // 他のiframe閉じてからカレンダーを開くJavaScript
        $script_str
            .= <<<EOD

function open_iframe (form_name, prefix, frame_src)
{
    if (form_name == null || form_name == "")
    {
        var select_year  = document.getElementById(prefix+"year");
        var select_month = document.getElementById(prefix+"month");
        var select_day   = document.getElementById(prefix+"day");
    }
    else
    {
        form = document.forms[form_name];
        var select_year  = form.elements[prefix+"year"];
        var select_month = form.elements[prefix+"month"];
        var select_day   = form.elements[prefix+"day"];
    }

    if(!select_year.disabled)
    {
        var year = select_year.options[select_year.selectedIndex].value;
        var month = select_month.options[select_month.selectedIndex].value;
        var day = select_day.options[select_day.selectedIndex].value;
        frame_src = frame_src + '&date=' + year + '-' + month + '-' + day;

        var id = form_name+prefix+"SetDateCal";
        for(i=0; i < openIds.length; i++)
        {
            if (openIds[i] != id)
            {
                e = document.getElementById(openIds[i]);
                if( e && e.style )
                {
                    if( e.style.display == "" )
                    {
                        e.style.display = "none";
                    }
                }
            }
        }
        var f = document.getElementById(id);
        if(f && f.src)
        {
            f.src = frame_src;
        }
        cb_ui_select_date_display_calendar(id);
        openIds = new Array(id);
        if( typeof parent.update_back_step == 'function' )
        {
            parent.update_back_step();
        }
    }
}
//-->
</script>
EOD;
    }


    $len = strlen($date_order);
    for ($i = 0; $i < $len; $i++) {
        if ($i > 0) {
            $select_str .= $delimiter;
        }

        switch ($date_order{$i}) {
            case 'Y':
                $select_str .= _grn_select_date_write_year($prefix, $necessary,
                    $start_year, $end_year, $date, $year_unit, $disabled,
                    $onChange, $show_wday, $show_blank, $onClick, $date_order,
                    $use_calendar_disable_ui);
                break;
            case 'n':
                $select_str .= _grn_select_date_write_month($prefix, $necessary,
                    $date, $month_unit, false, $disabled, $onChange, $show_wday,
                    $show_blank, $onClick, $date_order,
                    $use_calendar_disable_ui);
                break;
            case 'm':
                $select_str .= _grn_select_date_write_month($prefix, $necessary,
                    $date, $month_unit, true, $disabled, $onChange, $show_wday,
                    $show_blank, $onClick, $date_order,
                    $use_calendar_disable_ui);
                break;
            case 'j':
                $select_str .= _grn_select_date_write_day($prefix, $necessary,
                    $date, $current_date, $day_unit, false, $wday_name,
                    $disabled, $onChange, $show_wday, $show_blank, $onClick);
                break;
            case 'd':
                $select_str .= _grn_select_date_write_day($prefix, $necessary,
                    $date, $current_date, $day_unit, true, $wday_name,
                    $disabled, $onChange, $show_wday, $show_blank, $onClick);
                break;
        }
    }

    if ( ! is_null($form_name)) {
        $script_str_for_day .= "<script language=\"javascript\" type=\"text/javascript\"><!--"
                               . htmlspecialchars($return_code);
        $script_str_for_day
            .= <<<EOD

function reinit_day()
{
    var _prefix = "$prefix";
    var _form = document.forms["$form_name"];
    var _select_day = _form.elements[_prefix + "day"];
    if(_select_day != null)
    {
        var _day = _select_day.options[_select_day.selectedIndex].value;

        cb_ui_select_date_init_day(_form, _prefix);

        for(i = 0 ; i < _select_day.options.length ; i ++)
        {
            if(_select_day.options[i].value == _day) 
            {
                _select_day.options[i].selected = true;
            }
        }
    }
}

if (window.addEventListener)
{
    window.addEventListener('load', reinit_day, false);
}
else if (window.attachEvent)
{
    window.attachEvent('onload', reinit_day);
}

//-->
</script>
EOD;
    }

    // popup calendar
    $popup_calendar = (array_key_exists('no_calendar', $params)
                       && ! $params['no_calendar']) ? false : true;
    if ($popup_calendar) {
        if (_grn_select_date_isOperation($smarty)) {
            $page_url = cb_pageurl('grn/operation/popup_calendar');
        } elseif (_grn_select_date_isSystem($smarty)) {
            $page_url = cb_pageurl('grn/system/popup_calendar');
        } else {
            $page_url = cb_pageurl('grn/popup_calendar');
        }
        $page_url .= 'prefix=' . htmlspecialchars($prefix) . '&form_name='
                     . htmlspecialchars($form_name) . '&on_change='
                     . htmlspecialchars($onChange);

        if (strlen($onClickCalendar) > 0) {
            if ( ! preg_match('/;$/', $onClickCalendar)) {
                $onClickCalendar .= ";";
            }
        }

        $msg = cb_msg('grn.common', 'select_date_calendar_title');
        if (is_null($form_name)) {
            $calendar_str .= '<a name="" style="cursor:pointer;"><img src="'
                             . htmlspecialchars($app_path)
                             . '/grn/image/cybozu/calendar20.gif?' . $build_date
                             . '" border="0" align="absmiddle" style="cursor:hand;" onClick=\''
                             . htmlspecialchars($onClickCalendar)
                             . 'open_iframe("' . htmlspecialchars($form_name)
                             . '", "' . htmlspecialchars($prefix) . '", "'
                             . $page_url . '");\' title="' . $msg . '" ></a>'
                             . htmlspecialchars($return_code);
        } elseif ($use_calendar_disable_ui) {
            $calendar_str .= '<span><a name="calendar_w" style="cursor:pointer;"><img src="'
                             . htmlspecialchars($app_path)
                             . '/grn/image/cybozu/calendar20.gif?' . $build_date
                             . '" border="0" align="absmiddle" style="cursor:hand;" onClick=\''
                             . htmlspecialchars($onClickCalendar)
                             . 'open_iframe("' . htmlspecialchars($form_name)
                             . '", "' . htmlspecialchars($prefix) . '", "'
                             . $page_url . '");\' title="' . $msg
                             . '" ></a></span>';
        } else {
            $calendar_str .= '<a name="" style="cursor: pointer"><img src="'
                             . htmlspecialchars($app_path)
                             . '/grn/image/cybozu/calendar20.gif?' . $build_date
                             . '" border="0" align="absmiddle" style="cursor:hand;" onClick=\''
                             . htmlspecialchars($onClickCalendar)
                             . 'open_iframe("' . htmlspecialchars($form_name)
                             . '", "' . htmlspecialchars($prefix) . '", "'
                             . $page_url . '");\' title="' . $msg . '" ></a>'
                             . htmlspecialchars($return_code);
        }
        $calendar_str .= '<iframe id="' . htmlspecialchars($form_name)
                         . htmlspecialchars($prefix)
                         . 'SetDateCal" frameborder="no" scrolling="no" style="display:none; position:absolute; width:308px; height:17.5em;z-index:10;" src="'
                         . htmlspecialchars($app_path) . '/grn/html/space.html?'
                         . $build_date . '"></iframe>';
    }

    return $script_str . $select_str . $script_str_for_day . $calendar_str;
}

/**
 * パラメータ処理関数
 *
 * @param  array   params       パラメータ配列
 *
 * @option string  param_name   パラメータ同
 *
 * @param  integer default      デフォルト値
 * @param  integer min          最小値
 * @param  integer max          最大値
 * @param  string  func_name    Smarty関数同
 *
 * @option object smarty        SmartyObject
 * @return string  数値パラメータ
 */
function _grn_select_date_get_param_numeric(
    &$params,
    $param_name,
    $default,
    $min,
    $max,
    $func_name,
    &$smarty
) {
    $num = array_key_exists($param_name, $params) ? $params[$param_name] : null;
    $num = is_null($num) ? $default : $num;
    if ( ! is_numeric($num)) {
        $smarty->trigger_error("{$func_name}: '{$param_name}' parameter is not numeric");
    }
    $num = intval($num);
    if ($num < $min || $max < $num) {
        $smarty->trigger_error("{$func_name}: '{$param_name}' parameter is out of range ({$min} - {$max})");
    }

    return $num;
}

function _grn_select_date_validate_year($date)
{
    return ! is_null($date) && $date->year >= 1970 && $date->year <= 2037;
}

/**
 * 年セレクトの生成
 *
 * @param  string  prefix       セレクトボックスのprefix
 *
 * @option boolean necessary    選択を必須にするかどうか
 *
 * @param  integer start_year   開始年
 * @param  integer end_year     終了年
 * @param  CB_Date date         生成する日仗
 * @param  string  year_unit    表示用の単位(多言語対応)
 *
 * @option boolean disabled     禁止状慊
 * @option string  on_change    onChangeイベント時に実行するJavaScript
 * @option boolean use_calendar_disable_ui
 * @return string  年セレクトタグ
 */
function _grn_select_date_write_year(
    $prefix,
    $necessary,
    $start_year,
    $end_year,
    $date,
    $year_unit,
    $disabled,
    $on_change,
    $show_wday,
    $show_blank,
    $on_click = null,
    $date_order,
    $use_calendar_disable_ui = false
) {
    $return_code = "\n";
    $disabled = ($disabled) ? ' disabled' : '';
    $option_str = '';

    // GTM-1605 Pull down menu with 21 years
    $on_change_att_name = 'onChange';
    $select_date_init_date_calling = 'cb_ui_select_date_init_day(this.form, \''
                                     . htmlspecialchars($prefix) . '\');';
    $reset_range_year_calling
        = 'cb_ui_select_date_reset_year_range(this.form, \''
          . htmlspecialchars($prefix) . '\');';
    $on_change_calling = htmlspecialchars($on_change);

    $on_change_with_init_str = $on_change_att_name . '="'
                               . $select_date_init_date_calling
                               . $reset_range_year_calling
                               . $on_change_calling . '"';
    $on_change_without_init_str = $on_change_att_name . '="'
                                  . $reset_range_year_calling
                                  . $on_change_calling . '"';
    $on_change_only_onchange_handler_str = $on_change_att_name . '="'
                                           . $on_change_calling . '"';

    // build onchange event handler 
    // Pull down menu with 21 years doesn't apply to popup calendar 
    if ($prefix == 'popup_' && $start_year == 1970) {
        $onchange_str = $on_change_only_onchange_handler_str;
    } elseif ($necessary) {
        if (strstr($date_order, 'j')) {
            $onchange_str = $on_change_with_init_str;
        } else {
            $onchange_str = $on_change_without_init_str;
        }

    } elseif ($show_wday) {
        $onchange_str = $on_change_with_init_str;
    } else {
        $onchange_str = $on_change_without_init_str;
    }
    // end build onchange event handler
    // end GTM-1605 

    if ($show_blank || ! $necessary) {
        $option_str .= '<option value="">----' . $year_unit . '</option>'
                       . htmlspecialchars($return_code);
    }
    $onclick_str = ($on_click) ? ' onclick="' . htmlspecialchars($on_click)
                                 . '"' : '';

    $select_str = sprintf('<select id="%syear" name="%syear"%s%s%s>%s',
        htmlspecialchars($prefix), htmlspecialchars($prefix), $onchange_str,
        htmlspecialchars($disabled), $onclick_str,
        htmlspecialchars($return_code));

    if (_grn_select_date_validate_year($date) && $date->year < $start_year) {
        $option_str .= sprintf('<option value="%s" selected>%s%s</option>%s',
            htmlspecialchars($date->year), htmlspecialchars($date->year),
            $year_unit, htmlspecialchars($return_code));
    }

    for ($year = $start_year; $year <= $end_year; $year++) {
        $selected = ( ! is_null($date) && $year == $date->year) ? ' selected'
            : '';
        $option_str .= sprintf('<option value="%s"%s>%s%s</option>%s',
            htmlspecialchars($year), htmlspecialchars($selected),
            htmlspecialchars($year), $year_unit,
            htmlspecialchars($return_code));
    }

    if (_grn_select_date_validate_year($date) && $date->year > $end_year) {
        $option_str .= sprintf('<option value="%s" selected>%s%s</option>%s',
            htmlspecialchars($date->year), htmlspecialchars($date->year),
            $year_unit, htmlspecialchars($return_code));
    }

    if ($use_calendar_disable_ui) {
        $return_str = $select_str . $option_str . '</select>';
    } else {
        $return_str = $select_str . $option_str . '</select>'
                      . htmlspecialchars($return_code);
    }

    return $return_str;
}

/**
 * 月セレクトの生成
 *
 * @param  string  prefix       セレクトボックスのprefix
 *
 * @option boolean necessary    選択を必須にするかどうか
 *
 * @param  CB_Date date         生成する日仗
 * @param  string  month_unit   表示用の単位(多言語対応)
 *
 * @option boolean zero_padding 頭桁を0埋めするかどうか
 * @option boolean disabled     禁止状慊
 * @option string  on_change    onChangeイベント時に実行するJavaScript
 * @option boolean use_calendar_disable_ui
 * @return string  月セレクトタグ
 */
function _grn_select_date_write_month(
    $prefix,
    $necessary,
    $date,
    $month_unit,
    $zero_padding,
    $disabled,
    $on_change,
    $show_wday,
    $show_blank,
    $on_click = null,
    $date_order,
    $use_calendar_disable_ui = false
) {
    $return_code = "\n";
    $disabled = ($disabled) ? ' disabled' : '';
    $option_str = '';

    if ($necessary) {
        if (strstr($date_order, 'j')) {
            $onchange_str
                = ' onChange="cb_ui_select_date_init_day(this.form, \''
                  . htmlspecialchars($prefix) . '\');'
                  . htmlspecialchars($on_change) . '"';
        } else {
            $onchange_str = ' onChange="' . $on_change . '"';
        }

        if ($show_blank) {
            $option_str .= '<option value="">--' . $month_unit . '</option>'
                           . htmlspecialchars($return_code);
        }
    } else {
        if ($show_wday) {
            $onchange_str
                = ' onChange="cb_ui_select_date_init_day(this.form, \''
                  . htmlspecialchars($prefix) . '\');'
                  . htmlspecialchars($on_change) . '"';
        } else {
            $onchange_str = htmlspecialchars($on_change);
        }
        $option_str .= '<option value="">--' . $month_unit . '</option>'
                       . htmlspecialchars($return_code);
    }
    $onclick_str = ($on_click) ? ' onclick="' . htmlspecialchars($on_click)
                                 . '"' : '';

    $select_str = sprintf('<select id="%smonth" name="%smonth"%s%s%s>%s',
        htmlspecialchars($prefix), htmlspecialchars($prefix), $onchange_str,
        htmlspecialchars($disabled), $onclick_str,
        htmlspecialchars($return_code));


    for ($month = 1; $month <= 12; $month++) {
        $month_str = ($zero_padding && $month < 10) ? '0' . $month : $month;
        $selected = ( ! is_null($date) && $month == $date->month)
            ? ' selected' : '';
        $option_str .= sprintf('<option value="%s"%s>%s%s</option>%s',
            htmlspecialchars($month), htmlspecialchars($selected),
            cb_msg("fw.date", "MonthShort" . $month), $month_unit,
            htmlspecialchars($return_code));
    }

    if ($use_calendar_disable_ui) {
        $return_str = $select_str . $option_str . '</select>';
    } else {
        $return_str = $select_str . $option_str . '</select>'
                      . htmlspecialchars($return_code);
    }

    return $return_str;
}

/**
 * 日セレクトの生成
 *
 * @param  string  prefix       セレクトボックスのprefix
 *
 * @option boolean necessary    選択を必須にするかどうか
 *
 * @param  CB_Date date         生成する日仗
 * @param  CB_Date today        本日
 * @param  string  day_unit     表示用の単位(多言語対応)
 *
 * @option boolean zero_padding 頭桁を0埋めするかどうか
 *
 * @param  array   wday_name    曜日配列
 *
 * @option boolean disabled     禁止状慊
 * @option string  on_change    onChangeイベント時に実行するJavaScript
 * @return string  日セレクトタグ
 */
function _grn_select_date_write_day(
    $prefix,
    $necessary,
    $date,
    $today,
    $day_unit,
    $zero_padding,
    $wday_name,
    $disabled,
    $on_change,
    $show_wday,
    $show_blank,
    $on_click = null
) {
    $return_code = "\n";
    $disabled = ($disabled) ? ' disabled' : '';
    $on_change = ($on_change) ? ' onChange="' . htmlspecialchars($on_change)
                                . '"' : '';
    $on_click = ($on_click) ? ' onclick="' . htmlspecialchars($on_click)
                              . '"' : '';
    $select_str .= sprintf('<select id="%sday" name="%sday"%s%s%s>%s',
        htmlspecialchars($prefix), htmlspecialchars($prefix), $on_change,
        htmlspecialchars($disabled), $on_click, htmlspecialchars($return_code));

    // ログインユーザーを取得
    global $G_container_base;
    $uum = $G_container_base->getInstance('uum');
    $login = $uum->getLoginUser();

    if ($date != null) {
        $calendar_date = clone $date;
    } else {
        $calendar_date = $today;
    }

    if ($calendar_date->year < 1970 || $calendar_date->year > 2037) {
        $calendar_date->year = $today->year;
    }
    if ($calendar_date->month < 1 || $calendar_date->month > 12) {
        $calendar_date->month = $today->month;
    }
    if ($calendar_date->day < 1
        || $calendar_date->day > cb_get_end_of_monthday($calendar_date->year,
            $calendar_date->month)
    ) {
        $calendar_date->day = $today->day;
    }
    if ($calendar_date->day > cb_get_end_of_monthday($calendar_date->year,
            $calendar_date->month)
    ) {
        $calendar_date->day = cb_get_end_of_monthday($calendar_date->year,
            $calendar_date->month);
    }

    // カレンダーサービスからカレンダーを取得
    $calendar_service = GRN_CalendarService::getInstance();
    $calendars = $calendar_service->getDaysInfo(
        _grn_select_getFirstOfMonthDay($calendar_date),
        _grn_select_getLastOfMonthDay($calendar_date),
        $login);

    $date_ex = new CB_DateEx($calendar_date);
    $date_ex->day = 1;
    $last_day = $date_ex->getEndOfMonthDay();
    if ($last_day < $date->day) {
        $last_day = $date->day;
    }

    $day = 1;
    if ($date_ex->year == 1970 && $date_ex->month == 1) {
        $day = 3;
        $date_ex->moveDays(2);
    }

    require_once('schedule/view_util.csp');
    $view_util = GRN_Schedule_View_Util::getInstance();
    if ($necessary) {
        if ($show_blank) {
            $option_str .= sprintf('<option value="">--%s</option>%s',
                $day_unit, htmlspecialchars($return_code));
        }
        /*
                $start_date = mktime(0, 0, 0, $date->month, 1, $date->year);
                $start_date_array = getdate($start_date);
                $wday = $start_date_array['wday'];
        */
        $wday = $date_ex->getDayOfWeek();

        for (; $day <= $last_day; $day++) {
            $class_option = '';
            if ($wday == 0) {
                $class_option = ' class="s_date_sunday"';
            } elseif ($wday == 6) {
                $class_option = ' class="s_date_saturday"';
            }

            if ($view_util->isWorkday($date_ex, $calendars, $login)) {
                $class_option = '';
            } elseif (_grn_select_isHoliday($date_ex, $calendars)) {
                $class_option = ' class="s_date_holiday"';
            }

            $day_str = ($zero_padding && $day < 10) ? '0' . $day : $day;
            $selected = ( ! is_null($date) && $day == $date->day)
                ? ' selected' : '';
            $option_str .= sprintf('<option value="%s"%s%s>%s(%s)</option>%s',
                htmlspecialchars($day), $class_option,
                htmlspecialchars($selected), htmlspecialchars($day_str),
                $wday_name[$wday], htmlspecialchars($return_code));

            $wday++;
            if ($wday > 6) {
                $wday = 0;
            }
            $date_ex->moveDays(1);
        }
    } elseif ($show_wday) {
        $option_str .= sprintf('<option value="">--%s</option>%s', $day_unit,
            htmlspecialchars($return_code));

        $wday = $date_ex->getDayOfWeek();
        for (; $day <= $last_day; $day++) {
            $class_option = '';
            if ($wday == 0) {
                $class_option = ' class="s_date_sunday"';
            } elseif ($wday == 6) {
                $class_option = ' class="s_date_saturday"';
            }

            if ($view_util->isWorkday($date_ex, $calendars, $login)) {
                $class_option = '';
            } elseif (_grn_select_isHoliday($date_ex, $calendars)) {
                $class_option = ' class="s_date_holiday"';
            }

            $day_str = ($zero_padding && $day < 10) ? '0' . $day : $day;
            $selected = ( ! is_null($date) && $day == $date->day)
                ? ' selected' : '';
            $option_str .= sprintf('<option value="%s"%s%s>%s(%s)</option>%s',
                htmlspecialchars($day), $class_option,
                htmlspecialchars($selected), htmlspecialchars($day_str),
                $wday_name[$wday], htmlspecialchars($return_code));

            $wday++;
            if ($wday > 6) {
                $wday = 0;
            }
            $date_ex->moveDays(1);
        }
    } else {
        // necessary=falseの場合は非選択項目追加＆曜日非表示
        $option_str .= sprintf('<option value="">--%s</option>%s', $day_unit,
            htmlspecialchars($return_code));
        for (; $day <= $last_day; $day++) {
            $day_str = ($zero_padding && $day < 10) ? '0' . $day : $day;
            $selected = ( ! is_null($date) && $day == $date->day)
                ? ' selected' : '';
            $option_str .= sprintf('<option value="%s"%s>%s%s</option>%s',
                htmlspecialchars($day), htmlspecialchars($selected),
                htmlspecialchars($day_str), $day_unit,
                htmlspecialchars($return_code));
        }
    }
    $return_str .= $select_str . $option_str . '</select>';

    return $return_str;
}

/**
 * 月の初日を取得する
 *
 * @param  CB_Date $date　求める日仗
 *
 * @return CB_DateEx 月の初日
 */
function _grn_select_getFirstOfMonthDay($date)
{
    $dateex = new CB_DateEx($date);
    $dateex->day = 1;

    return $dateex;
}

/**
 * 月の最終日を取得すり
 *
 * @param  CB_Date $date　求める日仗
 *
 * @return CB_DateEx 月の最終日
 */
function _grn_select_getLastOfMonthDay($date)
{
    $dateex = new CB_DateEx($date);
    $dateex->day = $dateex->getEndOfMonthDay();

    return $dateex;
}

/**
 * 指定された日付が祝日かどうかをチェックする
 *
 * @param CB_Date $date
 * @param array   $calendars
 * retrun boolean
 */
function _grn_select_isHoliday($date, $calendars)
{
    if ( ! is_array($calendars) || count($calendars) == 0) {
        return false;
    }

    require_once('grn/calendar.csp');
    if (array_key_exists($date->format(), $calendars)) {
        foreach ($calendars[$date->format()] as $calendar) {
            if (is_array($calendar)
                && $calendar['type'] == GRN_CALENDAR_TYPE_PUBLICHOLIDAY
            ) {
                return true;
            }
        }
    }

    return false;
}

function _grn_select_date_isSystem(&$smarty)
{
    $page_info =& $smarty->get_template_vars('page_info');
    $all_pageinfo = $page_info['all'];
    if (preg_match('/system/', $all_pageinfo)) {
        return true;
    }

    return false;
}

function _grn_select_date_isOperation(&$smarty)
{
    $page_info =& $smarty->get_template_vars('page_info');
    $all_pageinfo = $page_info['all'];
    if (preg_match('/operation/', $all_pageinfo)) {
        return true;
    }

    return false;
}


var openIds = new Array(0);
var g_arrayHolidays = new Array();
var g_arrayWorkdays = new Array();

function grn_report_select_date_init_date_select( form_name, year, month, day, prefix)
{
    var str_year_select = document.forms[form_name].elements[prefix+"year"];
    var str_month_select = document.forms[form_name].elements[prefix+"month"];
    var str_day_select = document.forms[form_name].elements[prefix+"day"];
    var year_select = eval(str_year_select);
    var month_select = eval(str_month_select);
    var day_select = eval(str_day_select);

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
            year_options[0].text = year + date_year_unit;
            year_options[0].selected = true;
        }
        else
        {
            var o = document.createElement( "OPTION" );
            o.value = year;
            o.text = year + date_year_unit;
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

    var start_date = new Date(year, month - 1, 1);
    var wday = start_date.getDay();
    var last_day = grn_report_select_date_get_last_day(year, month);
    var offset = 0;
    while( day_options.length > 0 && day_options[offset].value == "" )
    {
        offset ++;
        day_options[offset].className = "";
        day_options[offset].text = "--" + date_day_unit;
    }
            
    for(i = 0 ; i < last_day ; i ++)
    {
        day_option = i + 1;

        opt_idx = i + offset;

        if(opt_idx >= day_options.length)
        {
            grn_report_select_date_add_option(day_options, day_option);
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
            if(grn_report_select_date_check_holiday(g_arrayHolidays, year, month, day_option))
            {
                day_options[opt_idx].className = "s_date_holiday";
            }
        }

        if(g_arrayWorkdays != null && g_arrayWorkdays.length > 0)
        {
            if(grn_report_select_date_check_workday(g_arrayWorkdays, year, month, day_option))
            {
                day_options[opt_idx].className = "";
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

function grn_report_open_iframe (form_name, prefix, frame_src)
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
        grn_report_select_date_display_calendar(id);
        openIds = new Array(id);
    }
}

function grn_report_select_date_init_day(form, prefix, no_year, no_wday, src)
{
    if (src.name != (prefix + "year") && src.name != (prefix + "month"))
    {
        return;
    }

    if (no_year)
    {
        var year = 2000;
    }
    else
    {
        var select_year = form.elements[prefix + "year"];
        var year = select_year.options[select_year.selectedIndex].value;
    }
    var select_month = form.elements[prefix + "month"];
    var month = select_month.options[select_month.selectedIndex].value;
    var select_day = form.elements[prefix + "day"];
    
    if( ! year || ! month )
    {
        return ;
    }
    
    var start_date = new Date(year, month - 1, 1);
    var wday = start_date.getDay();
    
    var options = select_day.options;
    var last_day = grn_report_select_date_get_last_day(year, month);
    var offset = 0;

    while( options.length > 0 && options[offset].value == "" )
    {
        offset ++;
    }

    for(i = 0 ; i < last_day ; i ++)
    {
        day = i + 1;

        opt_idx = i + offset;

        if(opt_idx >= options.length)
        {
            grn_report_select_date_add_option(options, day);
        }
        options[opt_idx].value = day;
        if (no_wday)
        {
            options[opt_idx].className = "";
        }
        else
        {
            if(wday == 0)
            {
                options[opt_idx].className = "s_date_sunday";
            }
            else if(wday == 6)
            {
                options[opt_idx].className = "s_date_saturday";
            }
            else
            {
                options[opt_idx].className = "";
            }
        }

        //---2005/1/27 add
        if(g_arrayHolidays != null && g_arrayHolidays.length > 0)
        {
            if(grn_report_select_date_check_holiday(g_arrayHolidays, year, month, day))
            {
                options[opt_idx].className = "s_date_holiday";
            }
        }

        if(g_arrayWorkdays != null && g_arrayWorkdays.length > 0)
        {
            if(grn_report_select_date_check_workday(g_arrayWorkdays, year, month, day))
            {
                options[opt_idx].className = "";
            }
        }

        if (no_wday)
        {
            options[opt_idx].text = day + date_day_unit;
        }
        else
        {
            options[opt_idx].text = day + "(" + wday_name[wday] + ")";
        }

        wday ++;
        if(wday > 6)
        {
            wday = 0;
        }
    }
    
    while((last_day+offset) < options.length)
    {
        if(options.remove)
        {
            options.remove(options.length - 1);
        }
        else
        {
            options[options.length - 1] = null;
        }
    }
    if ( year == "1970" && month == "1" && options[offset].value == "1")
    {
        if(options.remove)
        {
            options.remove(offset);
            options.remove(offset);
        }
        else
        {
            options[offset] = null;
            options[offset] = null;
        }
    }
    
    //---2005/1/31 add
    options[offset].selected = true;
}

var last_day = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
function grn_report_select_date_get_last_day(year, month)
{
    if(month != 2)
    {
        return last_day[month - 1];
    }

    if(year % 4 != 0)
    {
        return 28;
    }

    if(year % 100 == 0 && year % 400 != 0)
    {
        return 28;
    }

    return 29;
}

function grn_report_select_date_add_option(options, day)
{
    if(document.createElement)
    {
        var option = document.createElement("OPTION");
        option.value = day;
        if(document.all)
        {
            options.add(option);
        }
        else if(options.add)
        {
            options.add(option, day);
        }
        else
        {
            options[options.length] = option;
        }

        return option;
    }

    var len = options.length;
    options[len] = new Option("", day);
    return options[len];
}

function grn_report_select_date_display_calendar(id)
{
    var e = document.getElementById(id);
    if(e && e.style )
    {
        if( e.style.display == "none" )
        {
            e.style.display = "";
        }
        else
        {
            e.style.display = "none";
        }
    }
}

function grn_report_select_date_check_holiday(holidays, year, month, day)
{
    for(f = 0; f < holidays.length; f++)
    {
        if(month < 10)
        {
            month_str = "0"+month;
        }
        else
        {
            month_str = month;
        }

        if(day < 10)
        {
            date_str = "0"+day;
        }
        else
        {
            date_str = day;
        }

        if((year+"-"+month_str+"-"+date_str) == holidays[f])
        {
            return true;
        }
    }
    return false;
}

function grn_report_select_date_check_workday(workdays, year, month, day)
{
    for(f = 0; f < workdays.length; f++)
    {
        if(month < 10)
        {
            month_str = "0"+month;
        }
        else
        {
            month_str = month;
        }

        if(day < 10)
        {
            date_str = "0"+day;
        }
        else
        {
            date_str = day;
        }

        if((year+"-"+month_str+"-"+date_str) == workdays[f])
        {
            return true;
        }
    }
    return false;
}

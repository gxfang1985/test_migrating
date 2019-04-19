function cb_ui_select_date_init_day(form, prefix)
{
    var select_year = form.elements[prefix + "year"];
    var select_month = form.elements[prefix + "month"];
    var select_day = form.elements[prefix + "day"];
    
    var year = select_year.options[select_year.selectedIndex].value;
    var month = select_month.options[select_month.selectedIndex].value;

    if( ! year || ! month )
    {
        return ;
    }

    var start_date = new Date(year, month - 1, 1);
    var wday = start_date.getDay();
    
    var options = select_day.options;
    var last_day = cb_ui_select_date_get_last_day(year, month);
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
            cb_ui_select_date_add_option(options, day);
        }
        options[opt_idx].value = day;
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

        //---2005/1/27 add
        if(g_arrayHolidays != null && g_arrayHolidays.length > 0)
        {
            if(cb_ui_select_date_check_holiday(g_arrayHolidays, year, month, day))
            {
                options[opt_idx].className = "s_date_holiday";
            }
        }

        if(g_arrayWorkdays != null && g_arrayWorkdays.length > 0)
        {
            if(cb_ui_select_date_check_workday(g_arrayWorkdays, year, month, day))
            {
                options[opt_idx].className = "";
            }
        }
        options[opt_idx].text = day + "(" + wday_name[wday] + ")";

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

// GTM-1605 Pull down menu with 21 years
function cb_ui_select_date_reset_year_range(form, prefix)
{
    var selectYear = form.elements[prefix + "year"];
    var selectedYearOption = selectYear.options[selectYear.selectedIndex];
    var year = selectedYearOption.value;
    if(year == "") // <option>----</option>
    {
        return;
    }

    var yearUnit = "";
    if( typeof( G_yearUnit ) == "undefined" )
    {
        var fullTextYear = selectedYearOption.text;
        var yearNumberPosition = fullTextYear.indexOf( year );
        if( yearNumberPosition > -1 )
        {
            yearUnit = fullTextYear.substr( yearNumberPosition + year.length );
        }
    }
    else
    {
        yearUnit = G_yearUnit;
    }

    year = parseInt( year );
    if( isNaN( year ) || year > 2037 || year < 1970 )
    {
        year = new Date().getFullYear();
    }
    var maxNumberOptions = 21;
    var startYearValue = year - 10;

    if( startYearValue <= 1970 )
    {
        maxNumberOptions = 21 - ( 1970 - startYearValue );
        startYearValue = 1970;
    }

    var select_year_length = selectYear.length;

    // GRB-16851
    var o = null;
    for ( var i = 0 ; i < select_year_length; i++ )
    {
        if( selectYear.options[i].value == "" ) // <option>----</option>
        {
            o = document.createElement( "OPTION" );
            o.value = "";
            o.text = selectYear.options[i].text;
            break;
        }
    }

    selectYear.innerHTML = '';
    if( o != null )
    {
        selectYear.options.add(o);
    }
    //end GRB-16851
    
    var numberOptions = 0;
    for ( startYearValue; startYearValue < 2038; startYearValue++ )
    {
        if( numberOptions >= maxNumberOptions )
        {
            break;
        }

        var tempOption = document.createElement( "OPTION" );
        tempOption.value = startYearValue;
        tempOption.text = startYearValue + yearUnit;
        if( startYearValue == year )
        {
            tempOption.selected = true;
        }
        selectYear.add( tempOption );
        numberOptions ++;
    }
}

function cb_ui_select_date_change_enddate( form )
{
    var start_year  = form.elements["start_year"];
    var start_month = form.elements["start_month"];
    var start_day   = form.elements["start_day"];
    var end_year  = form.elements["end_year"];
    var end_month = form.elements["end_month"];
    var end_day   = form.elements["end_day"];
    var start_year_options = start_year.options;
    var end_year_options = end_year.options;
    var curr_start_year =  start_year_options[start_year.selectedIndex].value;
    var curr_end_year = end_year_options[end_year.selectedIndex].value;
    
    var sd = curr_start_year;
    sd *= 100;
    sd += start_month.selectedIndex;
    sd *= 100;
    sd += start_day.selectedIndex;
    var ed = curr_end_year;
    ed *= 100;
    ed += end_month.selectedIndex;
    ed *= 100;
    ed += end_day.selectedIndex;

    if ( sd > ed )
    {
        // GTM 1605
        end_year.innerHTML = '';
        for (var i = 0; i < start_year_options.length; i++) {
            var o = document.createElement( "OPTION" );
            o.value = start_year_options[i].value;
            o.text = start_year_options[i].text;
            end_year.options.add(o);
        }
        end_year.selectedIndex = start_year.selectedIndex;
        // end GTM 1605

        cb_ui_select_date_init_day(form, 'end_');

        if( end_month.selectedIndex != start_month.selectedIndex )
        {
            end_month.selectedIndex = start_month.selectedIndex;
            cb_ui_select_date_init_day(form, 'end_');
        }
        end_day.selectedIndex = start_day.selectedIndex;
    }
}
// end GTM-1605

var last_day = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
function cb_ui_select_date_get_last_day(year, month)
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

function cb_ui_select_date_add_option(options, day)
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

function cb_ui_select_date_display_calendar(id)
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

function cb_ui_select_date_check_holiday(holidays, year, month, day)
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

function cb_ui_select_date_check_workday(workdays, year, month, day)
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

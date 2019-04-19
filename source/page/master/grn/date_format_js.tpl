function {$function_name_prefix}date_params( target_date )
{literal}{

{/literal}
    var month_short_tpl = {$month_short_array|grn_noescape};
    var month_full_tpl = {$month_full_array|grn_noescape};
    var wday_short_tpl = {$wday_short_array|grn_noescape};
    var wday_full_tpl = {$wday_full_array|grn_noescape};
    var notation_tpl = {$notation_array|grn_noescape};
{literal}

    var four_digit_year = target_date.getYear();
    if( four_digit_year < 1900 )
    {
        four_digit_year += 1900;
    }


    return {
        "seconds": target_date.getSeconds().toString(),
        "minutes": target_date.getMinutes().toString(),
        "hours"  : target_date.getHours().toString(),
        "mday"   : target_date.getDate() < 10 ? "0" + target_date.getDate().toString() : target_date.getDate().toString(),
        "mon"    : target_date.getMonth()+1 < 10 ? "0" + (target_date.getMonth()+1).toString() : (target_date.getMonth()+1).toString(),
        "year"   : four_digit_year,
        "year00" : four_digit_year % 100,
        "minutes00" : target_date.getMinutes() < 10 ? "0" + target_date.getMinutes().toString() : target_date.getMinutes().toString(),
        "seconds00" : target_date.getSeconds() < 10 ? "0" + target_date.getSeconds().toString() : target_date.getSeconds().toString(),
        "wdayfull" : wday_full_tpl[ target_date.getDay() ],
        "wdayshort"  : wday_short_tpl[ target_date.getDay() ],
        "monthfull"  : month_full_tpl[ target_date.getMonth() ],
        "monthshort" : month_short_tpl[ target_date.getMonth() ],
        "notationshort" : target_date.getHours() < 12 ? "AM" : "PM",
        "notation" : target_date.getHours() < 12 ? notation_tpl["AM"] : notation_tpl["PM"],
        "hours": target_date.getHours() < 10 ? "0" + target_date.getHours().toString() : target_date.getHours().toString()
    };
}
{/literal}

function {$function_name_prefix}date_format_template( format_name )
{literal}{
    return {/literal}{$date_template_object|grn_noescape}{literal}[format_name];
}{/literal}

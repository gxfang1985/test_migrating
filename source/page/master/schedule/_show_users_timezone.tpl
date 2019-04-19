{literal}
<style type="text/css">
    .differ_tz_color{
        background-color:#FFDBDE;
    }
    .hide_event{
        display:none;
    }

</style>
{/literal}

{* Show or hide timezone color
$function_click : name of function show users timezone
*}

<script type="text/javascript" language="javascript">
{literal}
    function showUsersTimezone(check_id,schedule_id, page, save_settings)
    {
        var show_timezone = $(check_id);
        if( !show_timezone )
            return;
        var scheduleWrapper = $(schedule_id);
        var status = 0;

        if(show_timezone.checked)
        {
            // show like timezone
            scheduleWrapper.select("span.like_timezone").each(function(e){
                e.show();
            });
            // color differ timezone
            scheduleWrapper.select("span.differ_timezone").each(function(e){
                e.addClassName("differ_tz_color");
            });
            
            // hide title normal
            scheduleWrapper.select(".sh_title_normal").each(function(e){
                e.addClassName("hide_event");
            });
            // show title tz
            scheduleWrapper.select(".sh_title_tz").each(function(e){
                e.removeClassName("hide_event");
            });

            status = 1;
        }
        else
        {
            // hide like timezone
            scheduleWrapper.select("span.like_timezone").each(function(e){
                e.hide();
            });
            // remove color differ timezone
            scheduleWrapper.select("span.differ_timezone").each(function(e){
                e.removeClassName("differ_tz_color");
            });
            
            // show title normal
            scheduleWrapper.select(".sh_title_normal").each(function(e){
                e.removeClassName("hide_event");
            });
            // hide title tz
            scheduleWrapper.select(".sh_title_tz").each(function(e){
                e.addClassName("hide_event");
            });

            status = 0;
        }
        
        // save status
        if(save_settings)
        {
            new Ajax.Request(
                show_users_timezone_url,
                {
                    'method':'POST',
                    'parameters':'status='+status + '&page='+ page +
                        '&csrf_ticket={/literal}{$csrf_ticket}{literal}'
                }
            );
        }
    }
{/literal}
</script>

{*when onload*}
<script type="text/javascript" language="javascript">
    var show_users_timezone_url = "{grn_pageurl page='schedule/command_show_users_timezone'}";
    Event.observe( window, 'load', function(event){ldelim}
        {$function_click|grn_noescape}
        {rdelim});
</script>

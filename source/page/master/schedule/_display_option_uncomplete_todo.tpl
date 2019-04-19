{grn_load_javascript file="grn/html/schedule_display_options.js"}
{grn_load_javascript file="grn/html/schedule_display_options_manager.js"}
<script type="text/javascript" language="javascript">
{literal}
GRN_ScheduleDisplayOptions['{/literal}{$plid}{literal}'] 
               = GRN_ScheduleDisplayOptionFactory.create('{/literal}{$page_key}{literal}',
                                                         '{/literal}{$csrf_ticket}{literal}',
                                                         '{/literal}{$schedule_id}{literal}',
                                                         '{/literal}{$plid}{literal}');

GRN_ScheduleDisplayOptions['{/literal}{$plid}{literal}']
               .createDisplayOptionOfToDo( '{/literal}{grn_pageurl page='schedule/command_show_todos'}{literal}' );

Event.observe(window, 'load', function(){
    GRN_ScheduleDisplayOptions['{/literal}{$plid}{literal}'].init();
});
{/literal}
</script>

{grn_load_css file="grn/html/schedule_display_options.css"}
<div class="schedule_display_options">
  <div class="schedule_display_options_dialog_ch">
    {capture assign='grn_schedule_show_todos'}
        {cb_msg module='grn.schedule' key='show_todos' replace='true'}
    {/capture}
    {grn_checkbox name='show_todos'|cat:$plid id='show_todos'|cat:$plid value=1 caption=$grn_schedule_show_todos checked=$show_todos}
  </div>
</div>



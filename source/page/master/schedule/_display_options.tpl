{if $group_day}
    {capture assign='display_member_tz_url'}{grn_pageurl page='schedule/command_member_timezone'}{/capture}
    {assign var="onclickShowUsersTimezone" value="displayTimeZone('show_users_timezone"|cat:$plid|cat:"', '"|cat:$display_member_tz_url|cat:"', '"|cat:$csrf_ticket|cat:"', '');"}
    {assign var="showUsersTimezoneChecked" value=$member_tz}
{elseif $confirm}
    {capture assign='display_member_tz_url'}{grn_pageurl page='schedule/command_member_timezone'}{/capture}
    {assign var="onclickShowUsersTimezone" value="displayTimeZone('show_users_timezone"|cat:$plid|cat:"', '"|cat:$display_member_tz_url|cat:"', '"|cat:$csrf_ticket|cat:"','"|cat:$confirm|cat:"');"}
    {assign var="showUsersTimezoneChecked" value=$member_tz}
{else}
    {assign var="onclickShowUsersTimezone" value="showUsersTimezone('show_users_timezone"|cat:$plid|cat:"','"|cat:$schedule_id|cat:"','"|cat:$page_key|cat:"',true);"}
    {assign var="showUsersTimezoneChecked" value=$show_users_timezone}
{/if}

{grn_load_javascript file="grn/html/schedule_display_options_manager.js"}
{grn_load_javascript file="grn/html/schedule_display_options.js"}

<script type="text/javascript" language="javascript">
<!--
{literal}
GRN_ScheduleDisplayOptions['{/literal}{$plid}{literal}'] 
               = GRN_ScheduleDisplayOptionFactory.create('{/literal}{$page_key}{literal}',
                                                         '{/literal}{$csrf_ticket}{literal}',
                                                         '{/literal}{$schedule_id}{literal}',
                                                         '{/literal}{$plid}{literal}');

GRN_ScheduleDisplayOptions['{/literal}{$plid}{literal}']
               .createDisplayOptionOfToDo( '{/literal}{grn_pageurl page='schedule/command_show_todos'}{literal}' );
{/literal}
{if $expired_todo_option}
{literal}

  GRN_ScheduleDisplayOptions['{/literal}{$plid}{literal}']
                 .createDisplayOptionOfExpiredToDo( '{/literal}{grn_pageurl page='schedule/command_show_expired_todos'}{literal}' );
{/literal}
{/if}
{literal}

Event.observe(window, 'load', function(){
    GRN_ScheduleDisplayOptions['{/literal}{$plid}{literal}'].init();
});
{/literal}
//-->
</script>
{grn_load_css file="grn/html/schedule_display_options.css"}
<div class="schedule_display_options">
    <div class="scheduleDisplayOptionsLink-grn">
      <a id="schedule_display_options_switch{$plid}" href="javascript:void(0);">
         {cb_msg module='grn.schedule' key='display_options' replace='true'}
         <span id="schedule_display_options_down_allow{$plid}">
             {grn_image class="menu_arrow_grn" image='arrow_down_single_gray.gif'}
         </span>
         <span id="schedule_display_options_up_allow{$plid}" style="display:none;">
             {grn_image class="menu_arrow_grn" image='arrow_up_single_gray.gif'}
         </span>
      </a>
    </div>

    <div id="schedule_display_options_dialog{$plid}" class="schedule_display_options_dialog js_schedule_display_options_dropdown" style="display:none;">
      {if $show_full_title_option}
        <div class="schedule_display_options_dialog_ch">
          {capture assign='grn_schedule_show_full_title'}
             {cb_msg module='grn.schedule' key='show_full_title' replace='true'}
          {/capture}
          {grn_checkbox name='show_full_title'|cat:$plid id='show_full_title'|cat:$plid value=1 caption=$grn_schedule_show_full_title checked=$show_full_title onclick="showFullShortTitle('show_full_title"|cat:$plid|cat:"','"|cat:$schedule_id|cat:"','"|cat:$page_key|cat:"',false);"}
        </div>
      {/if}
      {if $apply_users_timezone}
        <div class="schedule_display_options_dialog_ch">
          {capture assign='grn_schedule_show_users_timezone'}
             {cb_msg module='grn.schedule' key='show_users_timezone' replace='true'}
          {/capture}
          {grn_checkbox name='show_users_timezone'|cat:$plid id='show_users_timezone'|cat:$plid value=1 caption=$grn_schedule_show_users_timezone checked=$showUsersTimezoneChecked onclick=$onclickShowUsersTimezone}
        </div>
      {/if}
      {if $show_todos_option}
        <div class="schedule_display_options_dialog_ch js_show_todos">
          {capture assign='grn_schedule_show_todos'}
              {cb_msg module='grn.schedule' key='show_todos' replace='true'}
          {/capture}
          {grn_checkbox name='show_todos'|cat:$plid id='show_todos'|cat:$plid value=1 caption=$grn_schedule_show_todos checked=$show_todos}
        </div>
      {/if}
      {if $expired_todo_option}
        <div class="schedule_display_options_dialog_ch js_show_expired_todos">
          {capture assign='grn_schedule_show_expired_todos'}
              {cb_msg module='grn.schedule' key='show_expired_todos' replace='true'}
          {/capture}
          {grn_checkbox name='show_expired_todos'|cat:$plid id='show_expired_todos'|cat:$plid value=1 caption=$grn_schedule_show_expired_todos checked=$show_expired_todos}
        </div>
      {/if}
    </div>
</div>

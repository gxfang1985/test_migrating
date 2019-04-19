{capture name="notime_event"}
 <tr>
  <td rowspan="2" class="personal_week_calendar_event_header"><br></td>
{foreach from=$schedule.schedule_event key=num item=schedule_event}
  <td class="{$schedule_event.date_type}" class="personal_week_calendar_date_cell">
   <font size="-1">
    <a href="{grn_pageurl page='schedule/personal_day' bdate=$schedule_event.date uid=$user_id gid=$group_id}">{grn_date_format date=$schedule_event.date format="DateShort_MDW"}</a>
   </font>
  </td>
{/foreach}
 </tr>
 <tr>
{if $schedule.schedule_event}
 {foreach from=$schedule.schedule_event key=num item=schedule_event}
  <td valign="top" class="personal_week_calendar_event_cell" onMouseOver="GRN_ScheduleSimpleAdd.mouseOverHandler(event, this)" onMouseOut="GRN_ScheduleSimpleAdd.mouseOutHandler(event, this)" rel="{grn_pageurl page='schedule/simple_add' uid=$schedule.user_id gid=$group_id referer_key=$referer_key bdate=$schedule_event.date set_hour=$time}" plid="{$plid}"{if $schedule.user_type == 'facility'} utype="facility"{/if}>

  {grn_schedule_allday_count calendar=$schedule_event.calendar allday=$schedule_event.event todos=$schedule_event.todos week=1}

  {foreach from=$schedule_event.calendar item=calendar}
   <div class="personal_week_calendar_event_item">{grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon}</div>
  {/foreach}

  {include file='schedule/todo.tpl' event=$schedule_event}
  {foreach from=$schedule_event.event item=event}
   {if $event.allday}{if ! $event.private}{if $event.absent === 1}<div class="schedule_absent">{/if}
<font size="-1"><div class="personalWeekEventTitleAllday normalEventElement{if $event.id eq $event_id} newevent-grn{/if}"><a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$schedule_event.date uid=$user.id gid=$group_id referer_key=$referer_key}">{/if}{$event.data|grn_noescape}{if $event.is_private}{grn_image image="image-common/privateMark_sub16.png"}{/if}{if $event.type == 'share_repeat' || $event.type == 'repeat'}{grn_image image="repeat16.gif"}{/if}{if $event.report}{grn_image image="report16.gif"}{/if}{if ! $event.private}</a></div></font>{if $event.absent === 1}</div>{/if}
   {/if}{/if}
  {/foreach}
  <br></div></td>
 {/foreach}
{/if}
 </tr>
{if $schedule.banner_event}
{grn_schedule_weekbanner
banner_events = $schedule.banner_event
page          = 'schedule/view'
week_type     = 'personal'
setdate       = $week_start
enddate       = $week_end
banner_class  = 's_banner2'
blank_class   = 'br_banner2'
banner_image  = 'banner16.gif'
report_image  = 'report16.gif'
uid           = $user.id
gid           = $group_id
referer_key=$referer_key
}
{/if}
{/capture}

{capture name="time_event"}
 <table class="personal_week_calendar_body">

{section name=time_bar loop=$schedule_params.end_hour start=$schedule_params.set_hour}
 {assign var='time' value=$smarty.section.time_bar.iteration+$schedule_params.set_hour-1}
 {if $time < 12 }
  {assign var='bgcolor' value='m'}
 {elseif $time < 18 }
  {assign var='bgcolor' value='e'}
 {else}
  {assign var='bgcolor' value='a'}
 {/if}
  <tr>
   <td class="personal_week_calendar_time_cell {$bgcolor}">{$time}</td>
 {foreach from=$schedule.schedule_event key=num item=schedule_event}
   <td class="personal_week_calendar_data_cell" nowrap onMouseOver="GRN_ScheduleSimpleAdd.mouseOverHandler(event, this)" onMouseOut="GRN_ScheduleSimpleAdd.mouseOutHandler(event, this)" rel="{grn_pageurl page='schedule/simple_add' uid=$schedule.user_id gid=$group_id referer_key=$referer_key bdate=$schedule_event.date set_hour=$time}" plid="{$plid}"{if $schedule.user_type == 'facility'} utype="facility"{/if}><br></td>
 {/foreach}
  </tr>
{/section}
 </table>
{grn_schedule_showevent
data=$schedule.schedule_event
bdate=$schedule_event.date
uid=$schedule.user_id
gid=$group_id
set_hour=$schedule_params.set_hour
end_hour=$schedule_params.end_hour
page='schedule/view'
left=20
week=1
referer_key=$referer_key
aeid = $event_id
}
{/capture}
{ldelim}
"notime_event":"{$smarty.capture.notime_event|replace:'"':'\"'|replace:"\n":''|replace:"\r":''}",
"time_event":"{$smarty.capture.time_event|escape:javascript}"
{rdelim}
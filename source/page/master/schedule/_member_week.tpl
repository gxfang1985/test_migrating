<table class="calendar" width="100%" cellspacing="0" cellpadding="0">
 <colgroup>
  <col width="14%">
  <col width="12%">
  <col width="12%">
  <col width="12%">
  <col width="12%">
  <col width="12%">
  <col width="12%">
  <col width="12%">
 </colgroup>
 <tr>
  <td style="border-right:1px solid #666666;border-top:1px solid #666666;"><br></td>
  {foreach from=$schedule.schedule_event item=item}
  <td class="{$item.date_type}" align="center" style="border-right:1px solid #666666;border-top:1px solid #666666;padding:2px;font-size:80%;" nowrap>
   &nbsp;{grn_schedule_date_header date=$item.date format="DateShort_MDW"}
  </td>
  {/foreach}
 </tr>
 <tr>
  <td valign="top" class="calendar_rb">
   <table width="100%" cellspacing="0" cellpadding="2">
    <tr>
     <td>
 {if $schedule.facility_id}
  {grn_link image='facility20.gif' page='schedule/facility_info' faid=$user.facility_id caption=$schedule.facility_title referer_key=$referer_key}&nbsp;<br>&nbsp;<br>
  {$schedule.facility_memo|grn_noescape}
 {else}
  {grn_schedule_member_name id=$schedule.id referer_key=$referer_key}&nbsp;<br>&nbsp;<br>
 {/if}<br>
     </td>
    </tr>
   </table>
  </td>

 {foreach from=$schedule.schedule_event item=schedule_event}
  <td valign="top" style="border-right:1px solid #666666;border-bottom:1px solid #cccccc;border-top:1px solid #666666;">
   <table width="100%" cellspacing="0" cellpadding="0">
   {foreach from=$schedule_event.calendar item=calendar}
    <tr>
     <td style="font-size:90%;padding:2px;">{grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon}</td>
    </tr>
   {/foreach}
   {strip}
   {foreach from=$schedule_event.event item=event}
    <tr>
     <td class="{$event.type}" style="font-size:90%;padding:2px;">
        <div class="listTime">{$event.time_schedule|grn_noescape}</div>
        <div class="{if $event.allday}groupWeekEventTitleAllday{else}groupWeekEventTitle{/if}">
        {if ! $event.private}
            {if $event.conflict}
                {capture name='grn_schedule_GRN_SCH_914'}
                    {cb_msg module='grn.schedule' key='GRN_SCH-914' replace='true'}
                {/capture}{grn_image image="attention16.gif" alt=$smarty.capture.grn_schedule_GRN_SCH_914}{/if}{/if}
            {if ! $event.private && $event.attendance_check_show}
                {capture name='grn_schedule_GRN_SCH_1036'}{cb_msg module='grn.schedule' key='GRN_SCH-1036' replace='true'}{/capture}
                {grn_image alt=$smarty.capture.grn_schedule_GRN_SCH_1036 class="unanswered_icon_base_grn" image="image-app-schedule/event_unanswered16.png"}
            {/if}
            {if $event.event_menu_color neq '' && $event.event_menu_color neq '0'}
                <span class="event_color{$event.event_menu_color}_grn">
                {$event.event_menu|grn_noescape}</span>
                {$event.event_detail|grn_noescape}
            {else}
                {$event.data|grn_noescape}
                {/if}
        
        {if $event.is_private}{grn_image image="image-common/privateMark_sub16.png"}{/if}{if $event.type == 'share_repeat' || $event.type == 'repeat'}{grn_image image="repeat16.gif"}{/if}
        </div>
     </td>
    </tr>
   {/foreach}
   {/strip}
    <tr>
     <td>&nbsp;</td>
    </tr>
   </table>
    {/foreach}
  </td>
 </tr>
   {grn_schedule_weekbanner banner_events=$schedule.banner_event page='schedule/view' week_type=group setdate=$week_start enddate=$week_end banner_class='s_banner' blank_class='br_banner' banner_image='banner16.gif' uid=$schedule.id gid=$group_id deny_link=true}
</table>

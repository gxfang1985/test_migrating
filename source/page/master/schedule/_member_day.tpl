  <table class="day_table group_day_calendar">
    <tr class="day_table_time_login">
  <td class="view_calendar_timebar1"><br></td>
  <td class="view_calendar_timebar2"><br></td>
     {grn_schedule_time_header set_hour=$schedule_params.set_hour end_hour=$schedule_params.end_hour unit=$schedule_params.unit class_morning='m' class_evening='e' class_night='a' uid=$schedule.user_id facility_id=$schedule.facility_id timezone=$schedule.timezone bdate=$bdate}
    </tr>
    <tr class="day_table_time_login">
  <td class="view_calendar_timebar_sec1">{grn_image image='spacer1.gif'}</td>
  <td class="view_calendar_timebar_sec2">{grn_image image='spacer1.gif'}</td>
     {grn_schedule_time_header2 set_hour=$schedule_params.set_hour end_hour=$schedule_params.end_hour unit=$schedule_params.unit class_morning='m' class_evening='e' class_night='a' uid=$schedule.user_id timezone=$schedule.timezone bdate=$bdate}
    </tr>
    <tr>
  <td class="view_calendar_user">
 {if $schedule.facility_id}
  {grn_link image='facility20.gif' page='schedule/facility_info' faid=$schedule.facility_id caption=$schedule.facility_title referer_key=$referer_key}&nbsp;<br>
  {if ! $disable_link}
   {grn_link image='cal_pmon20.gif' page='schedule/personal_month' bdate=$bdate uid=$schedule.user_id gid=$group_id caption=''}<br>
  {else}
   <br>
  {/if}
  {$schedule.facility_memo|grn_noescape}
 {else}
  {grn_schedule_member_name id=$schedule.user_id referer_key=$referer_key}<br>
  {if ! $disable_link}
   {grn_link image='cal_pmon20.gif' page='schedule/personal_month' bdate=$bdate uid=$schedule.user_id gid=$group_id caption=''}
  {else}
   <br>
  {/if}
  {assign var='uid' value=$schedule.user_id}
 {/if}
     </td>
  <td class="view_calendar_event_cell">
 {if $schedule.schedule_event.calendar}
  {foreach from=$schedule.schedule_event.calendar item=calendar}
   <div class="view_calendar_event_item">{grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon}</div>
  {/foreach}
 {/if}
 {if $schedule.schedule_event.event}
  {foreach from=$schedule.schedule_event.event item=event}
      {if $event.allday}
          {if ! $disable_link}
              {if ! $event.private}
                  <div class="normalEventElement">
                  {grn_image image="allday.gif"}
                    {if $event.attendance_check_show}
                      {capture name='grn_schedule_GRN_SCH_1036'}{cb_msg module='grn.schedule' key='GRN_SCH-1036' replace='true'}{/capture}
                      {grn_image alt=$smarty.capture.grn_schedule_GRN_SCH_1036 class="unanswered_icon_base_grn" image="image-app-schedule/event_unanswered16.png"}
                    {/if}
                  <a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$bdate uid=$user.id gid=$group_id referer_key=$referer_key}">{/if}
              {if $event.event_menu_color neq '' && $event.event_menu_color neq '0'}
                  <span class="event_color{$event.event_menu_color}_grn">
                      {$event.event_menu|grn_noescape}
                      </span>
                  {$event.event_detail|grn_noescape}
              {else}
                  {$event.data|grn_noescape}

              {/if}
              {if $event.is_private}
                  {grn_image image="image-common/privateMark_sub16.png"}

              {/if}
              {if $event.type == 'share_repeat' || $event.type == 'repeat'}
                  {grn_image image="repeat16.gif"}

              {/if}
              {if $event.report}
                  {grn_image image="report16.gif"}

              {/if}
              {if ! $event.private}</a>
                  </div>
              {/if}
          {else}
              <div class="normalEventElement">
                  {grn_image image="allday.gif"}
                  {if $event.attendance_check_show}
                      {capture name='grn_schedule_GRN_SCH_1036'}{cb_msg module='grn.schedule' key='GRN_SCH-1036' replace='true'}{/capture}
                      {grn_image alt=$smarty.capture.grn_schedule_GRN_SCH_1036 class="unanswered_icon_base_grn" image="image-app-schedule/event_unanswered16.png"}
                  {/if}
                  {if $event.event_menu_color neq '' && $event.event_menu_color neq '0'}
                      <span class="event_color{$event.event_menu_color}_grn">
                        {$event.event_menu|grn_noescape}
                    </span>
                      {$event.event_detail|grn_noescape}
                  {else}
                      {$event.data|grn_noescape}

                  {/if}
                  {if $event.is_private}{grn_image image="image-common/privateMark_sub16.png"}{/if}{if $event.type == 'share_repeat' || $event.type == 'repeat'}{grn_image image='repeat16.gif'}{/if}
              </div>
          {/if}
          {assign var='alldays' value=true}
      {/if}
  {/foreach}
 {/if}
 {if $schedule.banner_event}
  {foreach from=$schedule.banner_event item=banner_event}
    {if ! $disable_link}
      <a href="{grn_pageurl page='schedule/view' event=$banner_event.id bdate=$bdate uid=$schedule.user_id gid=$group_id referer_key=$referer_key}">{grn_image image='banner16.gif'}
        {if $banner_event.event_menu_color neq '' && $banner_event.event_menu_color neq '0'}<span class="event_color{$banner_event.event_menu_color}_grn">{$banner_event.event_menu|grn_noescape}</span>{$banner_event.event_detail|grn_noescape}{else}{$banner_event.data|grn_noescape}{/if}
      </a><br>
    {else}
      {grn_image image='banner16.gif'}
              {if $banner_event.event_menu_color neq '' && $banner_event.event_menu_color neq '0'}<span class="event_color{$banner_event.event_menu_color}_grn">{$banner_event.event_menu|grn_noescape}</span>{$banner_event.event_detail|grn_noescape}{else}{$banner_event.data|grn_noescape}{/if}
      <br>
    {/if}
  {/foreach}
    {assign var='alldays' value=true}
 {/if}
 {if ! $alldays}
  &nbsp;
 {/if}
     </td>
 {if $schedule.schedule_event.event}
  {grn_schedule_group_day
  data=$schedule.schedule_event.event
  bdate=$schedule.schedule_event.date
  uid=$schedule.user_id
  gid=$group_id
  unit=$schedule_params.unit
  set_hour=$schedule_params.set_hour
  end_hour=$schedule_params.end_hour
  page='schedule/view' 
  col_span=$schedule_params.col_span
  access=$schedule.access
  disable_link=$disable_link
  view_conflict=$view_conflict
  referer_key=$referer_key 
  facility_id= $schedule.facility_id
  timezone=$schedule.timezone 
  quick_add=FALSE}
 {else}
  {if ! $disable_link}
     <td class="view_calendar_banner_item" colspan="{$schedule_params.col_span}" align="center">{if $schedule.access.add}<a href="{grn_pageurl page='schedule/add' bdate=$schedule.schedule_event.date uid=$schedule.user_id gid=$group_id}">{capture name='grn_schedule_GRN_SCH_26'}{cb_msg module='grn.schedule' key='GRN_SCH-26' replace='true'}{/capture}{grn_image image='write20.gif' alt=$smarty.capture.grn_schedule_GRN_SCH_26}</a>{/if}</td>
  {else}
   <td class="view_calendar_banner_item" colspan="{$schedule_params.col_span}" align="center">&nbsp;</td>
  {/if}
 {/if}
    </tr>
   </table>

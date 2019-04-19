{if $portlet.settings.font_size == "large"}
 {assign var="font_size" value='font-size:140%;'}
{elseif $portlet.settings.font_size == "normal"}
 {assign var="font_size" value=''}
{elseif $portlet.settings.font_size == "small"}
 {assign var="font_size" value='font-size:70%;'}
{/if}

{foreach from=$schedule.week key=week_key item=week}
<tr id="um_{$plid}_{$week.trid}" style="display:none;">
    {strip}
 {foreach from=$week.schedule_event item=week_event}
   <td valign="top" class="{if $today === $week_event.date}s_today{else}{$week_event.date_type}{/if} personal_month_calendar_cell normalEvent"{if $schedule.access.add && !$do_not_have_using_privilege} rel="{grn_pageurl page='schedule/simple_add' bdate=$week_event.date uid=$schedule.user_id gid=$group_id referer_key=$referer_key}"onmouseover="GRN_ScheduleSimpleAdd.mouseOverHandler(event, this);" onmouseout="GRN_ScheduleSimpleAdd.mouseOutHandler(event, this);" plid="{$plid}"{if $schedule.user_type == 'facility'} utype="facility"{/if}{/if}>
    <div class="personalMonthDate-grn">
      <a href="{grn_pageurl page='schedule/personal_day' bdate=$week_event.date uid=$schedule.user_id gid=$group_id}">{grn_date_format date=$week_event.date format="DateShortMini_MD" page="personal_month"}</a>
    </div>
    {if $schedule.access.add}
    <div class="addEvent">
      <a href="{grn_pageurl page='schedule/add' bdate=$week_event.date uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" onclick="cy_um_rd(this);">{capture name='grn_schedule_GRN_SCH_534'}{cb_msg module='grn.schedule' key='GRN_SCH-534' replace='true'}{/capture}<div class="iconWrite-grn" title="{$smarty.capture.grn_schedule_GRN_SCH_534}"></div></a>
    </div>
    {/if}
    <div class="js_customization_schedule_date_{$week_event.date}" data-date="{$week_event.date}"></div>
    <div class="personalMonthInfo">
    {foreach from=$week_event.calendar item=calendar}
      {grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon}
    {/foreach}
    </div>
    {include file='schedule/todo_month.tpl' event=$week_event }
    {foreach from=$week_event.event item=event}
      <div class="{if $event.type != 'share_temporary' && $event.type != 'temporary'}{$event.type}{/if} normalEventElement personalMonth_calendar_item{if $event.id eq $event_id} newevent-grn{/if}">
        {capture name="star"}{strip}
        {if !$event.allday}<div class="listTime">{if ! $event.private}<a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$week_event.date uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" onclick="cy_um_rd(this);">{/if}{$event.time_schedule|grn_noescape}{if ! $event.private}</a>{/if}</div>{/if}
            <div class="personalMonthEventTitle{if $event.allday}Allday{/if}">
         {if ! $event.private}

                    {if $event.type == "share_temporary" || $event.type == "temporary"}<span class="{$event.type}">{/if}
               <a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$week_event.date uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" onclick="cy_um_rd(this);">
                   {if $event.conflict}
                       <span class="attention">{capture name='grn_schedule_GRN_SCH_914'}{cb_msg module='grn.schedule' key='GRN_SCH-914' replace='true'}{/capture}{grn_image image="attention16.gif" alt=$smarty.capture.grn_schedule_GRN_SCH_914}</span>
                   {/if}
                   {*GTM-1625*}
                   {if $event.attendance_check_show}
                       {capture name='grn_schedule_GRN_SCH_1036'}{cb_msg module='grn.schedule' key='GRN_SCH-1036' replace='true'}{/capture}
                       {grn_image alt=$smarty.capture.grn_schedule_GRN_SCH_1036 class="unanswered_icon_base_grn" image="image-app-schedule/event_unanswered16.png"}
                   {/if}
              {/if}
                   {*GTM-103*}
                   {if !$event.private && $event.event_menu neq '' && $event.event_menu_color neq '' && $event.event_menu_color neq '0'}
                       {if !$event.facility_name_after}
                           {$event.event_facility_name}
                           <span class="event_color{$event.event_menu_color}_grn">
                                {$event.event_menu|grn_noescape}
                           </span>
                           {$event.event_detail|grn_noescape}
                       {else}
                            <span class="event_color{$event.event_menu_color}_grn">
                                {$event.event_menu|grn_noescape}
                           </span>
                           {$event.event_detail|grn_noescape}
                           {$event.event_facility_name|grn_noescape}
                       {/if}
                       {$event.creator_name|grn_noescape}
                       {$event.faci_items|grn_noescape}

                   {else}
                       {$event.data|grn_noescape}
                   {/if}
                   {*End GTM-103*}
          {if $event.is_private}{grn_image image="image-common/privateMark_sub16.png"}{/if}
          {if $event.type == 'share_repeat' || $event.type == 'repeat'}{grn_image image="repeat16.gif"}{/if}
          {if $event.report}{grn_image image="report16.gif"}{/if}
         {if ! $event.private}</a>{if $event.type == "share_temporary" || $event.type == "temporary"}</span>{/if}{/if}</div>
        {/strip}{/capture}
        {$smarty.capture.star|grn_noescape}
      </div>
    {/foreach}
    </td>
 {/foreach}
    {/strip}
   </tr>
 {grn_schedule_weekbanner banner_events=$week.banner_event page='schedule/view' setdate=$week.week_start enddate=$week.week_end banner_class='s_banner' blank_class='br_banner' banner_image='banner16.gif' uid=$schedule.user_id gid=$group_id referer_key=$referer_key trid=$week.trid display_flag='false' plid=$plid onclick="cy_um_rd(this);"}
{/foreach}

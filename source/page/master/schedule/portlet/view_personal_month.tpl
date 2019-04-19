{if $portlet.settings.font_size == "large"}
 {assign var="font_size" value='font-size:140%;'}
{elseif $portlet.settings.font_size == "normal"}
 {assign var="font_size" value=''}
{elseif $portlet.settings.font_size == "small"}
 {assign var="font_size" value='font-size:70%;'}
{/if}

{assign var=plid value=$portlet.plid}
{if $is_first_portlet}
<script language="JavaScript" type="text/javascript">
var cy_schedule_um_mon_name = new Array("{cb_msg module='grn.fw' key='MonthFull1' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull2' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull3' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull4' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull5' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull6' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull7' replace='true'}","{cb_msg module='grn.fw' key='MonthFull8' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull9' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull10' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull11' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull12' replace='true'}");
var cy_schedule_um_dateformat_short = "{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-243' replace='true'}";
var cy_schedule_um_dateformat_long = "{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-244' replace='true'}";
var cy_schedule_um_dateformat_tilda = "{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-245' replace='true'}";
</script>
{grn_load_javascript file="grn/html/schedule_um.js"}
{/if}
<script language="JavaScript" type="text/javascript">
<!--
{foreach from=$javascript_value_list key=name item=value}
var {$name} = {$value};
{/foreach}
var cy_schedule_um_week_buffer = new Object();
{foreach from=$cy_schedule_um_week_buffer key=name item=value}
cy_schedule_um_week_buffer['{$name}'] = '{$value}';
{/foreach}

var cy_schedule_um_ajax_url = '{grn_pageurl page='schedule/portlet/ajax_view_personal_month'}uid={$user_id|escape}&gid={$group_id|escape}&plid={$portlet.plid|escape}&referer_key={$referer_key|escape}';
var um_property = new CyScheduleUmProperty(cy_schedule_um_baseline_id, cy_schedule_um_week_display, cy_schedule_um_week_buffer, cy_schedule_um_ajax_url, {$portlet.plid}, false);

{if $is_first_ajax_portlet}
var plid_array = new Array();
{/if}
plid_array[{$portlet.plid}] = um_property;

if(typeof do_not_have_using_privilege == 'undefined')
{ldelim}
    do_not_have_using_privilege = new Array();
{rdelim}
do_not_have_using_privilege[{$portlet.plid}] = {$do_not_have_using_privilege};
//-->
</script>
<div style="{$font_size}">
<form name="personal_month{$portlet.plid}" method="post" action="{grn_pageurl page='schedule/personal_month'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
                <a href="{grn_pageurl page='schedule/personal_month'}">{$page_title}</a>
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_schedule_month_grn">
<div class="personalMonthPortletUpper-grn">
 <table class="top_day_navi personal_month_portlet">
 <tr>
 <td width="40%" nowrap class="v-align-middle">
  {if $schedule.user_type == 'organize'}
  {grn_schedule_member_name id=$schedule.user_id nolink=TURE noimage=TURE referer_key=$referer_key}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-32' replace='true'}
  {elseif $schedule.user_type == 'facility'}
  {grn_schedule_member_name id=$schedule.user_id nolink=TURE noimage=TURE referer_key=$referer_key}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-33' replace='true'}
  {else}
  {grn_schedule_member_name id=$schedule.user_id nolink=TURE noimage=TURE referer_key=$referer_key}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-34' replace='true'}
  {/if}
 </td>
 <td width="20%" align="center" nowrap class="v-align-middle">
  <div id="schedule_um_{$portlet.plid}_date_title" class="bold">{grn_date_format date=$bdate format="DateFull_YM"}</div>
 </td>
 <td width="40%" align="right" nowrap class="v-align-middle">
{strip}
<div class="moveButtonBlock-grn">
  <span class="moveButtonBaseDisable-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-781' replace='true'}">
    <a href="javascript:void(0);" id="onloadAble0" name="onloadAble" class="scheduleMove" onclick="if(check_disable(this))CyScheduleUm.ctrl('month_prev',{$portlet.plid});return false;" {if $user_agent.app == 'ie'}ondblclick="CyScheduleUm.ctrl('month_prev',{$portlet.plid});return false;"{/if} title="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-36' replace='true'}"><span class="moveButtonArrowLeftDisable-grn"></span></a>
  </span>
  <span class="moveButtonBaseDisable-grn">
    <a href="javascript:void(0);" id="onloadAble2" name="onloadAble" class="scheduleMove" onclick="if(check_disable(this))location.href='{grn_pageurl page=$page_info.all bdate=$date uid=$user_id gid=$group_id pid=$pid}';return false;"> {cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-37' replace='true'} </a>
  </span>
  <span class="moveButtonBaseDisable-grn" title="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-38' replace='true'}">
    <a href="javascript:void(0);" id="onloadAble4" name="onloadAble" class="scheduleMove" onclick="if(check_disable(this))CyScheduleUm.ctrl('month_next',{$portlet.plid});return false;" {if $user_agent.app == 'ie'}ondblclick="CyScheduleUm.ctrl('month_next',{$portlet.plid});return false;"{/if}><span class="moveButtonArrowRightDisable-grn"></span></a>
  </span>
</div>
{include file="schedule/_show_full_short_title.tpl" function_click="showFullShortTitle('show_full_titleportlet_personal_month`$portlet.plid`','view_personal_month_calendar`$portlet.plid`','portlet_personal_month',true);" schedule_id="view_personal_month_calendar`$portlet.plid`"}
{include file='schedule/_display_options.tpl' page_key="portlet_personal_month" schedule_id="view_personal_month_calendar`$portlet.plid`" plid="portlet_personal_month`$portlet.plid`" show_full_title_option=true show_todos_option=true}
{/strip}
 </td>
 </tr>
 </table>
</div>
  <table id="view_personal_month_calendar{$portlet.plid}" class="calendar personal_month_calendar_cell_inner {if !$show_full_title}hideEventTitle tableFixed{/if} js_customization_schedule_view_type_MONTH">
   <tbody>
    <tr>
     <td colspan="7" class="personal_month_calendar_navi_top">
      <table class="move_week_area">
       <tbody>
        <tr>
         <td>
          <div class="move_week" onclick="CyScheduleUm.ctrl('week_prev',{$portlet.plid});return false;" {if $user_agent.app == 'ie'}ondblclick="CyScheduleUm.ctrl('week_prev',{$portlet.plid});return false;"{/if}>
           <div class="move_week_in"><a href="#"><img src="{$app_path}/grn/image/cybozu/image-common/arrowUp.png?{$build_date}"border="0">{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-45' replace='true'}</a>
           </div>
          </div>
         </td>
         <td>
          <div class="move_week" onclick="CyScheduleUm.ctrl('week_next',{$portlet.plid});return false;" {if $user_agent.app == 'ie'}ondblclick="CyScheduleUm.ctrl('week_next',{$portlet.plid});return false;"{/if}>
           <div class="move_week_in"><a href="#">{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-46' replace='true'}<img src="{$app_path}/grn/image/cybozu/image-common/arrowDown.png?{$build_date}" border="0"></a>
           </div>
          </div>
         </td>
        </tr>
       </tbody>
      </table>
     </td>
    </tr>
    <tr>
        {if $cy_schedule_um_startwday == 0}
            <td class="personalMonthDayWeek-grn s_date_sunday_even">{cb_msg module='grn.fw' key='WDayShort0' replace='true'}</td>
        {/if}
        <td class="personalMonthDayWeek-grn">{cb_msg module='grn.fw' key='WDayShort1' replace='true'}</td>
        <td class="personalMonthDayWeek-grn">{cb_msg module='grn.fw' key='WDayShort2' replace='true'}</td>
        <td class="personalMonthDayWeek-grn">{cb_msg module='grn.fw' key='WDayShort3' replace='true'}</td>
        <td class="personalMonthDayWeek-grn">{cb_msg module='grn.fw' key='WDayShort4' replace='true'}</td>
        <td class="personalMonthDayWeek-grn">{cb_msg module='grn.fw' key='WDayShort5' replace='true'}</td>
        <td class="personalMonthDayWeek-grn s_date_saturday_even">{cb_msg module='grn.fw' key='WDayShort6' replace='true'}</td>
        {if $cy_schedule_um_startwday == 1}
            <td class="personalMonthDayWeek-grn s_date_sunday_even">{cb_msg module='grn.fw' key='WDayShort0' replace='true'}</td>
        {/if}
    </tr>
   </tbody>
   <tbody id="um_{$portlet.plid}_body" class="js_customization_schedule_user_id_{$user_id}">
{foreach from=$schedule.week key=week_key item=week}
 {if $week_key < $cy_schedule_um_buffer_count || $week_key >= ($cy_schedule_um_buffer_count + $javascript_value_list.cy_schedule_um_week_display) }
  {assign var='display_flag' value='false'}
 {else}
  {assign var='display_flag' value='true'}
 {/if}
   <tr id="um_{$portlet.plid}_{$week.trid}" {if $display_flag == 'false' }style="display:none;"{/if}>
 {foreach from=$week.schedule_event item=week_event}
   <td valign="top" class="{if $today === $week_event.date}s_today{else}{$week_event.date_type}{/if} personal_month_calendar_cell normalEvent" {if $schedule.access.add}rel="{grn_pageurl page='schedule/simple_add' bdate=$week_event.date uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" plid="{$portlet.plid}"{if $schedule.user_type == 'facility'} utype="facility"{/if}{/if}>
   <div class="personalMonthDate-grn">
    <a href="{grn_pageurl page='schedule/personal_day' bdate=$week_event.date uid=$schedule.user_id gid=$group_id}">{grn_date_format date=$week_event.date format="DateShortMini_MD" page="personal_month"}</a>
   </div>
   {if $schedule.access.add}
     <div class="addEvent">
       <a href="{grn_pageurl page='schedule/add' bdate=$week_event.date uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" onclick="cy_um_rd(this,{$plid});">{capture name='grn_schedule_portlet_GRN_SCH_PO_48'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-48' replace='true'}{/capture}<div class="iconWrite-grn" title="{$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_48}"></div></a>
     </div>
   {/if}
   <div class="js_customization_schedule_date_{$week_event.date}" data-date="{$week_event.date}"></div>
   <div class="personalMonthInfo">
   {foreach from=$week_event.calendar item=calendar}
     {grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon}
   {/foreach}
   </div>
   <div class="schedule_todo"{if !$show_todos} style="display:none;"{/if}>
     {include file='schedule/todo_month.tpl' event=$week_event}
   </div>
   {foreach from=$week_event.event item=event}
     <div class="{if $event.type != 'share_temporary' && $event.type != 'temporary'}{$event.type}{/if} normalEventElement personalMonth_calendar_item">
      {capture name="star"}{strip}
        {if $event.time_schedule neq ''}<div class="listTime">{if ! $event.private}<a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$week_event.date uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" onclick="cy_um_rd(this,{$plid});">{/if}{$event.time_schedule|grn_noescape}{if ! $event.private}</a>{/if}</div>{/if}
          <div class="personalMonthEventTitle{if $event.allday}Allday{/if}">
          {if ! $event.private}
          {if $event.type == "share_temporary" || $event.type == "temporary"}
          <span class="{$event.type}">
          {/if}
          <a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$week_event.date uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" onclick="cy_um_rd(this,{$plid});">{/if}
              {if $event.conflict}
                  <span class="attention">
                  {capture name='grn_schedule_GRN_SCH_914'}{cb_msg module='grn.schedule' key='GRN_SCH-914' replace='true'}{/capture}
                      {grn_image image="attention16.gif" alt=$smarty.capture.grn_schedule_GRN_SCH_914}
                </span>
              {/if}
              {if ! $event.private && $event.attendance_check_show}
                  {capture name='grn_schedule_GRN_SCH_1036'}{cb_msg module='grn.schedule' key='GRN_SCH-1036' replace='true'}{/capture}
                  {grn_image alt=$smarty.capture.grn_schedule_GRN_SCH_1036 class="unanswered_icon_base_grn" image="image-app-schedule/event_unanswered16.png"}
              {/if}
              <!--GTM-103-->
              {if ! $event.private && $event.event_menu neq '' && $event.event_menu_color neq '' && $event.event_menu_color neq '0'}
                  {if !$event.facility_name_after}
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
              <!--End GTM-103-->
          {if $event.is_private}
            {grn_image image="image-common/privateMark_sub16.png"}
          {/if}
          {if $event.type == 'share_repeat' || $event.type == 'repeat'}
            {grn_image image="repeat16.gif"}
          {/if}
          {if $event.report}{grn_image image="report16.gif"}{/if}
          {if ! $event.private}</a>{if $event.type == "share_temporary" || $event.type == "temporary"}</span>{/if}{/if}</div>
       {/strip}{/capture}
       {$smarty.capture.star|grn_noescape}
     </div>
   {/foreach}
    </td>
 {/foreach}
   </tr>
 {grn_schedule_weekbanner banner_events=$week.banner_event page='schedule/view' setdate=$week.week_start enddate=$week.week_end banner_class='s_banner' blank_class='br_banner' banner_image='banner16.gif' uid=$schedule.user_id gid=$group_id referer_key=$referer_key plid=$portlet.plid trid=$week.trid display_flag=$display_flag onclick="cy_um_rd(this,$plid);"}
{/foreach}
   </tbody>
   <tbody>
    <tr>
     <td colspan="7" class="personal_month_calendar_navi_bottom">
      <table class="move_week_area">
       <tbody>
        <tr>
         <td>
          <div class="move_week" onclick="CyScheduleUm.ctrl('week_prev',{$portlet.plid});return false;" {if $user_agent.app == 'ie'}ondblclick="CyScheduleUm.ctrl('week_prev',{$portlet.plid});return false;"{/if}>
           <div class="move_week_in"><a href="#"><img src="{$app_path}/grn/image/cybozu/image-common/arrowUp.png?{$build_date}"border="0">{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-49' replace='true'}</a>
           </div>
          </div>
         </td>
         <td>
          <div class="move_week" onclick="CyScheduleUm.ctrl('week_next',{$portlet.plid});return false;" {if $user_agent.app == 'ie'}ondblclick="CyScheduleUm.ctrl('week_next',{$portlet.plid});return false;"{/if}>
           <div class="move_week_in"><a href="#">{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-50' replace='true'}<img src="{$app_path}/grn/image/cybozu/image-common/arrowDown.png?{$build_date}" border="0"></a>
           </div>
          </div>
         </td>
        </tr>
       </tbody>
      </table>
     </td>
    </tr>
   </tbody>
  </table>

  <div class="none">&nbsp;</div>
  <table>
   <colgroup>
{foreach from=$month_count item=month}
    <col width="6%">
{/foreach}
   </colgroup>
  </table>
<input type="hidden" name="gid" value="{$group_id}">
<input type="hidden" name="bdate" value="{$bdate}">
</form>
{if $is_first_ajax_loading_item}
<div id="loading" class="loading" style="display:none;position:absolute;">{grn_image image="spinner.gif"}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-51' replace='true'}</div>
{/if}
{if $is_first_ajax_portlet}
{include file="schedule/portlet/_sync_event_list.tpl"}
{/if}
</div> <!--end of portal_frame -->
{grn_load_javascript file="fw/yui/build/dragdrop/dragdrop-min.js"}
{grn_load_javascript file="fw/yui/build/selector/selector-min.js"}
{grn_load_javascript file="grn/html/schedule.js"}
{include file="grn/error_handler.tpl"}
</div>

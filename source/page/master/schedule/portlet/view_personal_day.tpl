{if $portlet.settings.font_size == "large"}
 {assign var="font_size" value='font-size:140%;'}
{elseif $portlet.settings.font_size == "normal"}
 {assign var="font_size" value=''}
{elseif $portlet.settings.font_size == "small"}
 {assign var="font_size" value='font-size:70%;'}
 {assign var="icon_view" value='class = small'}
{/if}
{grn_load_javascript file="fw/jquery/jquery-ui-1.12.1.custom.min.js"}

{assign var='form_name' value=$smarty.template|basename}
<!--GRN2-2286-->
<script type="text/javascript" language="javascript">
    var command_show_hide_absent_schedule_url = "{grn_pageurl page='schedule/command_show_hide_absent_schedule'}";
</script>
{literal}
<script language="javascript" type="text/javascript">
Event.observe(window, 'load', function() {
    //show_hide_absent_schedule_portlet_personal_day('show_absent_schedule_portlet_personal_day','','portlet_personal_day',0)
   });

function DisplayElement_portlet_personal_day(rootElement, valueCheck)
{
    var scheduleWrapper = $$(rootElement)[0];
    var absentSchedule = scheduleWrapper.select('div.schedule_absent');
    if(!valueCheck)
    {
      //scheduleWrapper.removeClassName('hideScheduleAbsent');
      absentSchedule.each(function(e){
                e.stopObserving("mouseover");
                e.stopObserving("mouseout");
                e.childElements().each(function(e1){
                    e1.show();
                });
                e.className = 'schedule_absent_hide';
            });
    }
    else
    {
        //scheduleWrapper.addClassName('hideScheduleAbsent');
        absentSchedule.each(function(e){
                e.childElements().each(function(e1){
                    e1.hide();
                })
                
                e.className = 'schedule_absent_show_personal_day_portlet';
                e.observe("mouseover", function(event){
                    e.childElements().each(function(e1){
                    e1.show();
                    })
                    e.className = 'schedule_absent_hide';
                });
                e.observe("mouseout", function(event){
                    e.childElements().each(function(e1){
                    e1.hide();
                    });
                    e.className = 'schedule_absent_show_personal_day_portlet';
                });
       });
    }
}

function show_hide_absent_schedule_portlet_personal_day(id,tag_name,screen,flag)
{
      valueCheck = $(id);
    if(screen == 'portlet_personal_day')
  {
      if( valueCheck.checked)
      {
        DisplayElement_portlet_personal_day('table.v_day_navi',false);
        DisplayElement_portlet_personal_day('table.v_day_table',false);
        DisplayElement_portlet_personal_day('table.top_day_navi',false);
        status = 1;
      }
      else
      {
        DisplayElement_portlet_personal_day('table.v_day_navi',true);
        DisplayElement_portlet_personal_day('table.v_day_table',true);
        DisplayElement_portlet_personal_day('table.top_day_navi',true);
        status = 0;
      }

      if(flag == 1)
      {
        new Ajax.Request(
                    command_show_hide_absent_schedule_url,
                    {
                        'method':'POST',
                        'parameters':'status='+status + '&page=portlet_personal_day' +
                            '&csrf_ticket={/literal}{$csrf_ticket}{literal}'
                    }
                );
       }
  }
}
{/literal}
{if $is_first_ajax_portlet}
var plid_array = new Array();
{/if}
plid_array[{$portlet.plid}] = {ldelim}"name":"view_personal_day", "ajax_path":"{grn_pageurl page='schedule/portlet/ajax_view_personal_day'}", 'uid':"{$schedule.user_id}", "gid":"{$group_id}","date_type":"{$schedule.date_type}", "bdate":"{$schedule.date}","referer_key":"{$referer_key}"{rdelim};
</script>
{if $prepare_data}
{include file="schedule/_prepare_data.tpl"}
{/if}
{if $is_first_ajax_portlet}
{include file="schedule/portlet/_sync_event_list.tpl"}
{/if}
<!--GRN2-2286-->
<script language="JavaScript">
<!--
function v_day_add_{$portlet.plid}(s_hour,e_hour)
{literal}
{
{/literal}
    location.href = "{grn_pageurl page='schedule/add'}&bdate={$schedule.date}&uid={$schedule.user_id}&gid={$group_id}&referer_key={$referer_key}&set_hour="+s_hour+"&end_hour="+e_hour;
{literal}
}
{/literal}
bdate = "{$schedule.date}";
day_event = {$data_event_json|grn_noescape};
date_type = "{$schedule.date_type}";
unit = '{$schedule_params.unit}';
is_personal_day = true;
if(typeof do_not_have_using_privilege == 'undefined')
{ldelim}
    do_not_have_using_privilege = new Array();
    {rdelim}
do_not_have_using_privilege[{$portlet.plid}] = {$do_not_have_using_privilege};
if(typeof list_data_event == 'undefined')
{ldelim}
    list_data_event = new Array();
{rdelim}
list_data_event[{$portlet.plid}] = new Array();
if(typeof list_params == 'undefined')
{ldelim}
    list_params = new Array();
{rdelim}
list_params[{$portlet.plid}] = {ldelim}
    options: {ldelim}
                data        : day_event.schedule_event,
                bdate       : bdate,
                uid         : "{$schedule.user_id}",
                gid         : "{$group_id}",
                referer_key : "{$referer_key}",
                page        : 'schedule/view',
                week        : 0,
                unit        : unit,
                begin_day   : parseInt("{$schedule_params.set_hour}"),
                end_day     : parseInt("{$schedule_params.end_hour}"),
                plid        : {$portlet.plid}
    {rdelim},
    options_allday: {ldelim}
                data        : day_event.allday_event,
                bdate       : bdate,
                uid         : "{$schedule.user_id}",
                gid         : "{$group_id}",
                referer_key : "{$referer_key}"
    {rdelim},
    options_banner: {ldelim}
                data        : day_event.banner_event,
                date        : bdate,
                is_porlet   : 1,
                uid         : "{$schedule.user_id}",
                gid         : "{$group_id}",
                referer_key : "{$referer_key}"
    {rdelim},
    begin_day : parseInt("{$schedule_params.set_hour}"),
    end_day   : parseInt("{$schedule_params.end_hour}"),
    container_timesheet: '#time_event_'+{$portlet.plid},
    container_normal: '#'+date_type+'_'+{$portlet.plid},
    container_allday: '#personal_day_event_notime_'+{$portlet.plid},
    container_banner: '#banner_event_'+{$portlet.plid},
    container_list_event: '#personal_calendar_list_'+{$portlet.plid},
    ajax: false,
    do_not_have_using_privilege: {$do_not_have_using_privilege},
    plid: {$portlet.plid}
{rdelim};
{literal}
jQuery(document).ready(function(){
    list_data_event[{/literal}{$portlet.plid}{literal}][bdate] = new Array();
    display_personal_day_UI(list_params[{/literal}{$portlet.plid}{literal}]);
});
{/literal}
//-->
</script>
<!-- -->
<div id="view_personal_day_main{$portlet.plid}">
    <table class="top_title">{strip}
        <tbody>
        <tr>
            <td>
                <span class="portlet_title_grn">
                    <a href="{grn_pageurl page='schedule/personal_day' uid=$schedule.user_id gid=selected}">{$page_title}</a>
                </span>
            </td>
        </tr>
        </tbody>
    </table>{/strip}
    <div class="portal_frame portal_frame_schedule_day_grn js_customization_schedule_view_type_DAY">
        <div class="personalDayPortletUpper-grn">
            <table class="v_day_navi" cellspacing="0" cellpadding="0" style="{$font_size}">{strip}
                <tr>
                    <td colspan="2" nowrap>
                        {if $schedule.user_type == 'organize'}
                        {grn_schedule_member_name id=$schedule.user_id nolink=TURE noimage=TURE referer_key=$referer_key}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-155' replace='true'}
                        {elseif $schedule.user_type == 'facility'}
                        {grn_schedule_member_name id=$schedule.user_id nolink=TURE noimage=TURE referer_key=$referer_key}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-156' replace='true'}
                        {else}
                        {grn_schedule_member_name id=$schedule.user_id nolink=TURE noimage=TURE referer_key=$referer_key}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-157' replace='true'}
                        {/if}
                        {capture name='grn_schedule_portlet_GRN_SCH_PO_159'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-159' replace='true'}{/capture}{grn_link class='mLeft5' no_image_class='true' image='cal_pweek20.gif' page='schedule/personal_week' bdate=$schedule.date uid=$schedule.user_id gid=selected caption='' alt=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_159}
                        {capture name='grn_schedule_portlet_GRN_SCH_PO_158'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-158' replace='true'}{/capture}{grn_link class='mLeft5' no_image_class='true' image='cal_pmon20.gif' page='schedule/personal_month' bdate=$schedule.date uid=$schedule.user_id gid=$group_id caption='' alt=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_158}
                        <br>
                    </td>
                </tr>
                <tr>
                    <td width="50%" class="v-allign-middle" nowrap>
                        <div class="bold">{grn_date_format date=$schedule.date format="DateFull_YMDW"}</div>
                    </td>
                    <td width="50%" class="v-allign-middle" align="right" nowrap>
                        <div class="moveButtonBlock-grn">
                            <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-161' replace='true'}">
                                <a href="{grn_pageurl page=$page_info.all bdate=$bdate_prevweek uid=$schedule.user_id gid=$group_id pid=$pid}">
                                    <span class="moveButtonArrowLeftTwo-grn"></span>
                                </a>
                            </span>
                            <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-163' replace='true'}">
                                <a href="{grn_pageurl page=$page_info.all bdate=$bdate_prevday uid=$schedule.user_id gid=$group_id pid=$pid}">
                                    <span class="moveButtonArrowLeft-grn"></span>
                                </a>
                            </span>
                            <span class="moveButtonBase-grn" title="">
                                <a href="{grn_pageurl page=$page_info.all bdate=$date uid=$schedule.user_id gid=$group_id pid=$pid}">
                                    {cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-164' replace='true'}
                                </a>
                            </span>
                            <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-165' replace='true'}">
                                <a href="{grn_pageurl page=$page_info.all bdate=$bdate_nextday uid=$schedule.user_id gid=$group_id pid=$pid}">
                                    <span class="moveButtonArrowRight-grn"></span>
                                </a>
                            </span>
                            <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-167' replace='true'}">
                                <a href="{grn_pageurl page=$page_info.all bdate=$bdate_nextweek uid=$schedule.user_id gid=$group_id pid=$pid}">
                                    <span class="moveButtonArrowRightTwo-grn"></span>
                                </a>
                            </span>
                        </div>
                        {include file='schedule/_display_options.tpl' page_key='portlet_personal_day' schedule_id='view_personal_day_main'|cat:$portlet.plid plid=$portlet.plid personal_page='true' expired_todo_option='true' show_todos_option='true'}
                    </td>
                </tr>
                <tr>
                    <td colspan="2" class="v_day_calendar js_customization_schedule_user_id_{$user_id}">
                        <div class="js_customization_schedule_date_{$schedule.date}"></div>
                    {if $schedule.calendar}
                        <div class="view_personal_day_calendar_events">
                        {foreach from=$schedule.calendar item=calendar}
                            {grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon}
                        {/foreach}
                        </div>
                    {/if}
                    </td>
                </tr>
                <tr id="notime_event{$portlet.plid}">
                    <td colspan="2" class="allday" rel="{grn_pageurl page='schedule/simple_add' bdate=$schedule.date uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" plid="{$portlet.plid}"{if $schedule.user_type eq 'facility'} utype="facility"{/if}>
                        <ul class="v_day_ul">
                            {if $today === $schedule.date && $login_id === $user_id }
                                {include file="schedule/expired_todo.tpl" }
                            {/if}
                            <div id="personal_day_event_notime_{$portlet.plid}" class="personal_day_event_notime">
                                {include file='schedule/todo.tpl' event=$schedule}
                            </div>
                        </ul>
                    </td>
                </tr>
            </table>{/strip}
        </div>
        <table cellpadding="0" cellspacing="0" class="personal_day_calendar_banner_cell" id="banner_event_{$portlet.plid}">{strip}
        </table> {/strip}
        <div class="showtime personal_day_calendar_base" id="time_event_{$portlet.plid}">
            <div id="personal_calendar_list_{$portlet.plid}" class="personal_calendar_list">
                <table cellpadding="0" cellspacing="0" style="width:100%;">
                    <tr>
                        <td>
                            <div id="{$schedule.date_type}_{$portlet.plid}" class="personal_day_event_list last_date" style="width:100%;">
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <table class="top_day_navi" width="100%" cellspacing="0" cellpadding="4" style="{$font_size}">{strip}
            <tr>
                <td class="v_day_border01">
                    {if $schedule.next.open eq 'on'}
                        <span class="bold">
                            {capture name='grn_schedule_portlet_GRN_SCH_PO_170'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-170' replace='true'}{/capture}
                            {capture name='grn_schedule_portlet_GRN_SCH_PO_171'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-171' replace='true'}{/capture}
                            {grn_link image='minus13.gif' page='schedule/portlet/command_view_personal_day' pid=$pid bdate=$schedule.date uid=$schedule.user_id gid=$group_id ne='off' csrf_ticket=$csrf_ticket title=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_170 caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_171}
                            <br>
                        </span>
                        <div class="v_day_next">
                            {if $schedule.next.calendar}
                                {foreach from=$schedule.next.calendar item=calendar}
                                    <div class="v_day_calendar">{grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon}</div>
                                {/foreach}
                            {/if}
                            {include file="schedule/todo.tpl" event=$schedule.next }
                            <ul class="v_day_ul">
                                {foreach from=$schedule.next.allday_event item=event}
                                    <li>
                                        {if ! $event.private}
                                        <a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$bdate_nextday uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" title="{$event.data|grn_noescape}">
                                        {/if}
                                            {*GTM-1625*}
                                            {if $event.attendance_check_show}
                                                {capture name='grn_schedule_GRN_SCH_1036'}{cb_msg module='grn.schedule' key='GRN_SCH-1036' replace='true'}{/capture}
                                                {grn_image alt=$smarty.capture.grn_schedule_GRN_SCH_1036 class="unanswered_icon_base_grn" image="image-app-schedule/event_unanswered16.png"}
                                            {/if}
                                        <!--GTM-103-->
                                        {if $event.event_menu neq '' && $event.event_menu_color neq ''}
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
                                                {$event.event_facility_name}
                                            {/if}
                                        {else}
                                            {$event.data|grn_noescape}
                                        {/if}<!--End GTM-103-->
                                        {if $event.is_private}
                                            {grn_image image="image-common/privateMark_sub16.png"}
                                        {/if}
                                        {if $event.type == 'share_repeat' || $event.type == 'repeat'}
                                            {grn_image image='repeat16.gif'}
                                        {/if}
                                        {if $event.report}
                                            {grn_image image="report16.gif"}
                                        {/if}
                                        {if ! $event.private}
                                        </a>
                                        {/if}
                                    </li>
                                {/foreach}
                            </ul>
                            {foreach from=$schedule.next.banner_event item=event}
                                <a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$bdate uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" title="{$event.data|grn_noescape}">{grn_image image='banner16.gif'}
                                    <!--GTM-103-->
                                    {if $event.event_menu neq '' && $event.event_menu_color neq ''}
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
                                            {$event.event_facility_name}
                                        {/if}
                                    {else}
                                        {$event.data|grn_noescape}
                                    {/if}
                                    <!--End GTM-103-->
                                    {if $event.is_private}{grn_image image="image-common/privateMark_sub16.png"}{/if}
                                    {if $event.report}{grn_image image="report16.gif"}{/if}
                                </a>
                                <br>
                            {/foreach}
                            {foreach from=$schedule.next.event item=event}
                                <div  class="{$event.type}">
                                    {if $event.conflict}
                                        <span class="attention">
                                            {capture name='grn_schedule_GRN_SCH_914'}{cb_msg module='grn.schedule' key='GRN_SCH-914' replace='true'}{/capture}
                                            {grn_image image="attention16.gif" alt=$smarty.capture.grn_schedule_GRN_SCH_914}
                                        </span>
                                    {/if}
                                    {*GTM-1625*}
                                    {if ! $event.private}
                                        {if $event.attendance_check_show}
                                            {capture name='grn_schedule_GRN_SCH_1036'}{cb_msg module='grn.schedule' key='GRN_SCH-1036' replace='true'}{/capture}
                                            {grn_image alt=$smarty.capture.grn_schedule_GRN_SCH_1036 class="unanswered_icon_base_grn" image="image-app-schedule/event_unanswered16.png"}
                                        {/if}
                                        <a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$bdate_nextday uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" title="{$event.data|grn_noescape}">
                                    {/if}

                                    {*GTM-103, GTM-1625*}
                                    {if ! $event.private && $event.event_menu neq '' && $event.event_menu_color neq '' && $event.event_menu_color neq '0'}
                                        {if !$event.facility_name_after}
                                            {$event.time_infor}
                                            {$event.event_facility_name|grn_noescape}
                                            <span class="event_color{$event.event_menu_color}_grn">
                                                {$event.facility_name_after}
                                                {$event.event_menu|grn_noescape}
                                            </span>
                                            {$event.event_detail|grn_noescape}
                                        {else}
                                            {$event.time_infor}
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
                                        {grn_image image='repeat16.gif'}
                                    {/if}
                                    {if $event.report}
                                        {grn_image image="report16.gif"}
                                    {/if}
                                    {if ! $event.private}
                                    </a>
                                    {/if}
                                </div>
                            {/foreach}
                        </div>
                    {else}
                        <span class="bold">
                            {capture name='grn_schedule_portlet_GRN_SCH_PO_173'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-173' replace='true'}{/capture}
                            {capture name='grn_schedule_portlet_GRN_SCH_PO_174'}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-174' replace='true'}{/capture}
                            {grn_link image='plus13.gif' page='schedule/portlet/command_view_personal_day' pid=$pid bdate=$schedule.date uid=$schedule.user_id gid=$group_id ne='on' csrf_ticket=$csrf_ticket title=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_173 caption=$smarty.capture.grn_schedule_portlet_GRN_SCH_PO_174}
                            <br>
                            <div style="text-indent:16px">
                                {cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-175' replace='true'}
                            </div>
                        </span>
                    {/if}
                </td>
            </tr>
        </table>{/strip}
    </div> <!--end of portal_frame -->
</div>
{grn_load_javascript file="fw/yui/build/dragdrop/dragdrop-min.js"}
{grn_load_javascript file="fw/yui/build/selector/selector-min.js"}
{grn_load_javascript file="fw/yui/build/connection/connection-min.js"}
{grn_load_javascript file="grn/html/schedule.js"}
{grn_load_javascript file="grn/html/schedule_display_event.js"}
{include file="grn/error_handler.tpl"}

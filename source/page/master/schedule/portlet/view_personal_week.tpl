{grn_load_javascript file="fw/jquery/jquery-ui-1.12.1.custom.min.js"}
{grn_load_javascript file="fw/yui/build/dragdrop/dragdrop-min.js"}
{grn_load_javascript file="fw/yui/build/selector/selector-min.js"}
{grn_load_javascript file="fw/yui/build/connection/connection-min.js"}
{grn_load_javascript file="grn/html/schedule.js"}
{grn_load_javascript file="grn/html/schedule_display_event.js"}
{if $portlet.settings.font_size == "large"}
 {assign var="font_size" value='font-size:140%;'}
{elseif $portlet.settings.font_size == "normal"}
 {assign var="font_size" value=''}
{elseif $portlet.settings.font_size == "small"}
 {assign var="font_size" value='font-size:70%;'}
{/if}
<form id="view_personal_week{$portlet.plid}" name="personal_week{$portlet.ppid}" method="post" action="{grn_pageurl page='schedule/personal_week'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="top_title">{strip}
    <tbody>
     <tr>
        <td>
            <span class="portlet_title_grn">
                <a href="{grn_pageurl page='schedule/personal_week' uid=$user_id gid=selected}">{$page_title}</a>
            </span>
        </td>
     </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_schedule_week_grn">
<div class="personalWeekPortletUpper-grn">
 <table class="top_day_navi" cellspacing="0" cellpadding="0">
 <tr>
 <td width="40%" nowrap class="v-allign-middle">
  {if $schedule.user_type == 'organize'}
  {grn_schedule_member_name id=$schedule.user_id nolink=TURE noimage=TURE referer_key=$referer_key}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-111' replace='true'}
  {elseif $schedule.user_type == 'facility'}
  {grn_schedule_member_name id=$schedule.user_id nolink=TURE noimage=TURE referer_key=$referer_key}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-112' replace='true'}
  {else}
  {grn_schedule_member_name id=$schedule.user_id nolink=TURE noimage=TURE referer_key=$referer_key}{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-113' replace='true'}
  {/if}
 </td>
 <td width="20%" align="center" nowrap class="v-allign-middle">
  <div class="bold">{grn_date_format date=$bdate format="DateFull_YMDW"}</div>
 </td>
 <td width="40%" align="right" nowrap class="v-allign-middle">
  <div class="moveButtonBlock-grn">
  {strip}
    <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-115' replace='true'}">
        <a href="javascript:void(0);" onclick="location.href='{grn_pageurl page=$page_info.all bdate=$bdate_prevweek uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid}';return false;">
            <span class="moveButtonArrowLeftTwo-grn"></span>
        </a>
    </span>
    <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-117' replace='true'}">
        <a href="javascript:void(0);" onclick="location.href='{grn_pageurl page=$page_info.all bdate=$bdate_prevday uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid}';return false;">
            <span class="moveButtonArrowLeft-grn"></span>
        </a>
    </span>
    <span class="moveButtonBase-grn" title="">
        <a href="javascript:void(0);" onclick="location.href='{grn_pageurl page=$page_info.all bdate=$date uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid}';return false;"> {cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-118' replace='true'} </a>
    </span>
    <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-119' replace='true'}">
        <a href="javascript:void(0);" onclick="location.href='{grn_pageurl page=$page_info.all bdate=$bdate_nextday uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid}';return false;">
            <span class="moveButtonArrowRight-grn"></span>
        </a>
    </span>
    <span class="moveButtonBase-grn" title="{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-121' replace='true'}">
        <a href="javascript:void(0);" onclick="location.href='{grn_pageurl page=$page_info.all bdate=$bdate_nextweek uid=$user_id gid=$group_id event=$event_id event_date=$event_date pid=$pid}';return false;">
            <span class="moveButtonArrowRightTwo-grn"></span>
        </a>
    </span>
  {/strip}
  </div>
  {include file='schedule/_display_options.tpl' page_key='portlet_personal_week' schedule_id='view_personal_week'|cat:$portlet.plid plid=$portlet.plid show_todos_option='true'}
 </td>
 </tr>
 </table>
</div>
 
<script type="text/javascript" language="javascript">
    var command_show_hide_absent_schedule_url = "{grn_pageurl page='schedule/command_show_hide_absent_schedule'}";
</script>
{literal}
<script language="JavaScript" type="text/javascript">
<!--
function ov_{/literal}{$portlet.plid}{literal}(e) { e.className='personal_week_calendar_data_cell personal_calendar_cell_on'; }
function ot_{/literal}{$portlet.plid}{literal}(e) { e.className='personal_week_calendar_data_cell'; }
function ov_event_{/literal}{$portlet.plid}{literal}(e) { e.className='personal_week_calendar_event_cell personal_calendar_cell_on'; }
function ot_event_{/literal}{$portlet.plid}{literal}(e) { e.className='personal_week_calendar_event_cell'; }
function co_{/literal}{$portlet.plid}{literal}(ev,wd)
{
    if(ev&&ev.srcElement)
    {
        var e=ev.srcElement;
    }
    else if(ev&&ev.target)
    {
        var e=ev.target;
    }
    if(e&&e.tagName=="A")return;location.href="{/literal}{grn_pageurl page='schedule/add'}&uid={$schedule.user_id}&gid={$group_id}&referer_key={$referer_key}{literal}&bdate="+wd;
}
function ct_{/literal}{$portlet.plid}{literal}(ev,wd,t)
{
    if(ev&&ev.srcElement)
    {
        var e=ev.srcElement;
    }
    else if(ev&&ev.target)
    {
        var e=ev.target;
    }
    if(e&&e.tagName=="A")return;location.href="{/literal}{grn_pageurl page='schedule/add'}&uid={$schedule.user_id}&gid={$group_id}&referer_key={$referer_key}{literal}&bdate="+wd+"&set_hour="+t;
}
var zIndexMax = 7;
function ove(e) { e.style.zIndex=zIndexMax; zIndexMax++; }
{/literal}
{if $is_first_ajax_portlet}
    var plid_array = new Array();
{/if}
plid_array[{$portlet.plid}] = {ldelim}"name":"view_personal_week", "ajax_path":"{grn_pageurl page='schedule/portlet/ajax_view_personal_week'}", "uid":"{$schedule.user_id}", "gid":"{$group_id}", "bdate":"{$bdate}", "referer_key":"{$referer_key}"{rdelim};

week_event = {$data_event_json|grn_noescape};
data_event = week_event.schedule_event;
unit = '{$schedule_params.unit}';
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
    data                    : data_event,
    uid                     : "{$schedule.user_id}",
    gid                     : "{$group_id}",
    referer_key             : "{$referer_key}",
    unit                    : unit,
    banner_events           : week_event.banner_event,
    begin_day               : parseInt("{$schedule_params.set_hour}"),
    end_day                 : parseInt("{$schedule_params.end_hour}"),
    container_timesheet     : '#time_event_'+{$portlet.plid},
    container_banner        : '#personal_week_list_event_notime_'+{$portlet.plid},
    container_list_event    : '#personal_calendar_list_'+{$portlet.plid},
    ajax                    : false,
    do_not_have_using_privilege: {$do_not_have_using_privilege},
    plid                    : {$portlet.plid}
{rdelim};
{literal}
jQuery(document).ready(function(){
    display_personal_week_UI(list_params[{/literal}{$portlet.plid}{literal}]);
});
//-->
</script>
{/literal}
{if $prepare_data}
{include file="schedule/_prepare_data.tpl"}
{/if}
{if $is_first_ajax_portlet}
{include file="schedule/portlet/_sync_event_list.tpl"}
{/if}
<div class="personal_week_calendar_base_header">
 <div class="personal_week_calendar_header">
 <table id="personal_week_list_event_notime_{$portlet.plid}" class="personal_week_list_event_notime js_customization_schedule_view_type_WEEK" cellpadding="0" cellspacing="0">
    <tr>
        {foreach from=$schedule.schedule_event key=num item=schedule_event}
            <td class="{$schedule_event.date_type} personal_week_calendar_date_cell">
                <font size="-1">
                    <a href="{grn_pageurl page='schedule/personal_day' bdate=$schedule_event.date uid=$user_id gid=$group_id search_text=$search_text}">{grn_date_format date=$schedule_event.date format="DateShort_MDW"}</a>
                </font>
            </td>
        {/foreach}
    </tr>
     <tr class="js_customization_schedule_user_id_{$user_id}">
        {if $schedule.schedule_event}
            {foreach from=$schedule.schedule_event key=num item=schedule_event}
                <td class="personal_week_calendar_event_cell" rel="{grn_pageurl page='schedule/simple_add' uid=$schedule.user_id gid=$group_id referer_key=$referer_key bdate=$schedule_event.date set_hour=$time}" plid="{$portlet.plid}"{if $schedule.user_type == 'facility'} utype="facility"{/if}>
                    <div class="js_customization_schedule_date_{$schedule_event.date}"></div>
                    {foreach from=$schedule_event.calendar item=calendar}
                        <div class="personal_week_calendar_event_item">
                            {grn_calendar_event type=$calendar.type data=$calendar.data icon=$calendar.icon}
                        </div>
                    {/foreach}
                    <div id="personal_week_event_notime_{$schedule_event.date_type}_{$schedule_event.date}_{$portlet.plid}" class="personal_week_event_notime">
                    {include file='schedule/todo.tpl' event=$schedule_event}
                    </div>
                </td>
            {/foreach}
        {/if}
    </tr>
  </table>
 </div>
</div>
<div class="showtime personal_week_calendar_base" id="time_event_{$portlet.plid}">
 <div id="personal_calendar_list_{$portlet.plid}" class="personal_calendar_list">
 <table cellpadding="0" cellspacing="0" class="personal_week_list_event">
    <tr>
        {foreach from=$schedule.schedule_event name=week_list key=num item=schedule_event}
        <td class="personal_week_calendar_date{if $smarty.foreach.week_list.first} firstColumn{/if}{if $smarty.foreach.week_list.last} lastColumn{/if}">
            <div id="{$schedule_event.date_type}_{$schedule_event.date}_{$portlet.plid}" class="personal_day_event_list{if $smarty.foreach.week_list.last} last_date{/if}" style="{if $browser.type eq 'firefox' and $browser.ver_major lt 30}width:14.2857%{else}width:100%{/if};">
            </div>
        </td>
        {/foreach}
    </tr>
 </table>
 </div>
</div>

<div class="none">&nbsp;</div>
<input type="hidden" name="gid" value="{$group_id}">
<input type="hidden" name="bdate" value="{$bdate}">
</form>
{include file="grn/error_handler.tpl"}
</div> <!--end of portal_frame -->

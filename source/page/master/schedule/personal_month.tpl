{include file='grn/head.tpl'}
{include file='grn/header_no_siteposition.tpl'}
{include file='schedule/_title_search.tpl' group_id=$view_tab_group_id}
<script language="JavaScript" type="text/javascript">
var cy_schedule_um_mon_name = new Array("{cb_msg module='grn.fw' key='MonthFull1' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull2' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull3' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull4' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull5' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull6' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull7' replace='true'}","{cb_msg module='grn.fw' key='MonthFull8' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull9' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull10' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull11' replace='true'}", "{cb_msg module='grn.fw' key='MonthFull12' replace='true'}");
var cy_schedule_um_dateformat_short = "{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-243' replace='true'}";
var cy_schedule_um_dateformat_long = "{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-244' replace='true'}";
var cy_schedule_um_dateformat_tilda = "{cb_msg module='grn.schedule.portlet' key='GRN_SCH_PO-245' replace='true'}";
</script>
<!--GRN2-2286-->
<script type="text/javascript" language="javascript">
    var command_show_hide_absent_schedule_url = "{grn_pageurl page='schedule/command_show_hide_absent_schedule'}";
</script>
<!--GRN2-2286-->

<script language="JavaScript" type="text/javascript">
<!--
{literal}
// For bookmark
var hash_array = location.hash.split('bdate=');
var href_query_array = location.href.split('?');
if (hash_array.length > 1 && href_query_array.length > 1 && hash_array[1].match(/^[0-9]{4}-[0-9]{2}-[0-9]{2}$/)) {
    var url_params = new Hash(location.href.toQueryParams());
    url_params.set( 'bdate', hash_array[1] );
    
    var hash_param = '';
    if (hash_array[0].length > 1) {
        hash_param = hash_array[0];
    }
    
    location.href = href_query_array[0] + '?' + url_params.toQueryString() + hash_param;
}
{/literal}
//-->
</script>
{if $user_agent.app == 'ie'}
    <div style="display:none; position:absolute; top:0px; left:0px;">
        <iframe id="history_iframe" src="{cb_pageurl page='grn/space'}" style="display:none;"></iframe>
    </div>
{/if}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/schedule_um.js"}
{if $use_star}{grn_load_javascript file="grn/html/star.js"}{/if}

<script language="JavaScript" type="text/javascript">
<!--
{foreach from=$javascript_value_list key=name item=value}
    var {$name} = {$value};
{/foreach}
var cy_schedule_um_week_buffer = new Object();
{foreach from=$cy_schedule_um_week_buffer key=name item=value}
    cy_schedule_um_week_buffer['{$name}'] = '{$value}';
{/foreach}

var cy_schedule_um_ajax_url = '{grn_pageurl page='schedule/ajax_personal_month'}uid={$user_id|escape}&gid={$group_id|escape}&referer_key={$referer_key|escape}';
var cy_schedule_um_startwday = '{$cy_schedule_um_startwday}';
var um_property = new CyScheduleUmProperty(cy_schedule_um_baseline_id, cy_schedule_um_week_display, cy_schedule_um_week_buffer, cy_schedule_um_ajax_url, '', true, cy_schedule_um_startwday);

var plid_array = new Array();
plid_array[0] = um_property; 


{literal}
function syncEventList()
{
    var eid = arguments.length == 2 ? arguments[1] : '';
    CyScheduleUm.ctrl('refresh', 0, eid);
}

<!--GRN2-2286-->
 Event.observe(window, 'load', function() {
    //show_hide_absent_schedule_personal_month('show_absent_schedule_personal_month','table.calendar','personal_month',0)
   });
   
function DisplayElement_personal_month(rootElement, valueCheck)
{
    var scheduleWrapper = $$(rootElement)[0];
    var absentSchedule = scheduleWrapper.select('tr.schedule_absent');
    var banner = scheduleWrapper.select('div.schedule_absent');
    if(!valueCheck)
    {
        absentSchedule.each(function(e){
            e.stopObserving("mouseover");
            e.stopObserving("mouseout");
            e.show();
            if(e.nextSibling){
                e.nextSibling.remove();
            }
            });
            
        banner.each(function(e){
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
        absentSchedule.each(function(e){
            e.hide();
            var table = e.parentNode.parentNode;
            var row = $(table.insertRow(1));
            var cell = row.insertCell(0);
            cell.colspan = 2;
            cell.innerHTML = '&nbsp;&nbsp;&nbsp;';
            row.className = 'hidden_event';
            row.observe("mouseover", function(event){
                row.hide();
                row.previousSibling.show();
            });
            
            row.previousSibling.observe("mouseout", function(event){
                row.previousSibling.hide();
                row.show();
            });
        });
        
        banner.each(function(e){
                e.childElements().each(function(e1){
                    e1.hide();
                })
                e.className = 'schedule_absent_show';
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
                    e.className = 'schedule_absent_show';
                });
       });
    }
}

function show_hide_absent_schedule_personal_month(id,tag_name,screen,flag)
{
   valueCheck = $(id);
  if(screen == 'personal_month')
  {
      if( valueCheck.checked)
      {
        DisplayElement_personal_month(tag_name,false);
        status = 1;
      }
      else
      {
        DisplayElement_personal_month(tag_name,true);
        status = 0;
      }
      
      if(flag == 1)
      {
        new Ajax.Request(
                    command_show_hide_absent_schedule_url,
                    {
                        'method':'POST',
                        'parameters':'status='+status + '&page=personal_month' +
                            '&csrf_ticket={/literal}{$csrf_ticket}{literal}'
                    }
                );
       }
  }
}
<!--GRN2-2286-->

{/literal}
//-->
</script>

<div class="mainarea">
<div class="mainareaSchedule-grn">
<div id="view">
    {include file="schedule/_tab_menu.tpl" ajax_flag=true enable_print=true enable_ical_export=$isEnableIcalExport}
    <!--GRN2-2286--><!--<div align="right">{capture assign='grn_schedule_show_absent_schedule'}{cb_msg module='grn.schedule' key='show_absent_schedule'}{/capture}{grn_checkbox name='show_absent_schedule_personal_month' id='show_absent_schedule_personal_month' value=1 caption=$grn_schedule_show_absent_schedule checked=$show_absent_schedule onclick="show_hide_absent_schedule_personal_month('show_absent_schedule_personal_month','table.calendar','personal_month',1)"}&nbsp;</div>--><!--GRN2-2286--> 
    {include file="schedule/_month_navi.tpl"}
    {include file="schedule/_schedule_navi_calendar_month.tpl" location='schedule/personal_month'}

    <table id="personal_month_calendar" class="personal_month_calendar {if !$show_full_title}hideEventTitle tableFixed{/if} js_customization_schedule_view_type_MONTH">

        <tbody>
            <tr>
                <td colspan="7" class="personal_month_calendar_navi_top">
                    <table class="move_week_area">
                        <tbody>
                            <tr>
                                <td>
                                    <div class="move_week" onclick="CyScheduleUm.ctrl('week_prev',0);return false;" {if $user_agent.app == 'ie'}ondblclick="CyScheduleUm.ctrl('week_prev',0);return false;"{/if}>
                                        <div class="move_week_in"><a href="#"><img src="{$app_path}/grn/image/cybozu/image-common/arrowUp.png?{$build_date}"border="0">{cb_msg module='grn.schedule' key='GRN_SCH-6' replace='true'}</a>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="move_week" onclick="CyScheduleUm.ctrl('week_next',0);return false;" {if $user_agent.app == 'ie'}ondblclick="CyScheduleUm.ctrl('week_next',0);return false;"{/if}>
                                        <div class="move_week_in"><a href="#">{cb_msg module='grn.schedule' key='GRN_SCH-7' replace='true'}<img src="{$app_path}/grn/image/cybozu/image-common/arrowDown.png?{$build_date}" border="0"></a>
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

        <tbody id="um__body" class="js_customization_schedule_user_id_{$schedule.user_id}">
        {strip}
            {foreach from=$schedule.week key=week_key item=week}
                {if $week_key < $cy_schedule_um_buffer_count || $week_key >= ($cy_schedule_um_buffer_count + $javascript_value_list.cy_schedule_um_week_display) }
                    {assign var='display_flag' value='false'}
                {else}
                    {assign var='display_flag' value='true'}
                {/if}
                <tr id="um__{$week.trid}" {if $display_flag == 'false' }style="display:none;"{/if}>
                    {foreach from=$week.schedule_event item=week_event}
                        <td class="{if $today === $week_event.date}s_today{else}{$week_event.date_type}{/if} personal_month_calendar_cell normalEvent" {if $schedule.access.add && !$do_not_have_using_privilege}rel="{grn_pageurl page='schedule/simple_add' bdate=$week_event.date uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" plid="0" utype="{$schedule.user_type}"{/if}>
                        <div class="personalMonthDate-grn">
                            <a href="{grn_pageurl page='schedule/personal_day' bdate=$week_event.date uid=$schedule.user_id gid=$group_id search_text=$search_text}">{grn_date_format date=$week_event.date format="DateShort_MD" page="personal_month"}</a>
                        </div>
                        {if $schedule.access.add}
                        <div class="addEvent">
                            {capture name='grn_schedule_GRN_SCH_9'}{cb_msg module='grn.schedule' key='GRN_SCH-9' replace='true'}{/capture}
                            <a href="{grn_pageurl page='schedule/add' bdate=$week_event.date uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" onclick="cy_um_rd(this);">
                                <div class="iconWrite-grn" title="{$smarty.capture.grn_schedule_GRN_SCH_9}"></div>
                            </a>
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
                                {capture name="star"}
                                    {strip}
                                        {if $event.time_schedule neq ''}<div class="listTime">{if ! $event.private}<a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$week_event.date uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" onclick="cy_um_rd(this);">{/if}{$event.time_schedule|grn_noescape}{if ! $event.private}</a>{/if}</div>{/if}
                                         {* actually it's a private and hidden event*}
                                        <div class="personalMonthEventTitle{if $event.allday}Allday{/if}">
                                            {if ! $event.private}

                                            {if $event.type == "share_temporary" || $event.type == "temporary"}<span class="{$event.type}">{/if}
                                            <a href="{grn_pageurl page='schedule/view' event=$event.id bdate=$week_event.date uid=$schedule.user_id gid=$group_id referer_key=$referer_key}" onclick="cy_um_rd(this);">
                                                {if $event.conflict}
                                                    <span class="attention">
                                                    {capture name='grn_schedule_GRN_SCH_914'}{cb_msg module='grn.schedule' key='GRN_SCH-914' replace='true'}{/capture}
                                                        {grn_image image="attention16.gif" alt=$smarty.capture.grn_schedule_GRN_SCH_914}
                                                </span>
                                                {/if}
                                                {if $event.attendance_check_show}
                                                    {capture name='grn_schedule_GRN_SCH_1036'}{cb_msg module='grn.schedule' key='GRN_SCH-1036' replace='true'}{/capture}
                                                    {grn_image alt=$smarty.capture.grn_schedule_GRN_SCH_1036 class="unanswered_icon_base_grn" image="image-app-schedule/event_unanswered16.png"}
                                                {/if}
                                                {/if}{*end of private if*}
                                                {*GTM-103*}
                                                {if !$event.private && $event.event_menu neq '' && $event.event_menu_color neq '' && $event.event_menu_color neq '0'}
                                                    {if !$event.facility_name_after}
                                                        {$event.event_facility_name|grn_noescape}
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

                                                {/if}{*End GTM-103*}
                                        {if $event.is_private}
                                            {grn_image image="image-common/privateMark_sub16.png"}
                                        {/if}
                                        {if $event.type == 'share_repeat' || $event.type == 'repeat'}
                                            {grn_image image="repeat16.gif"}
                                        {/if}
                                        {if $event.report}
                                            {grn_image image="report16.gif"}
                                        {/if}
                                        {if ! $event.private}
                                            </a>
                                            {if $event.type == "share_temporary" || $event.type == "temporary"}</span>{/if}
                                            {/if}
                                        </div>
                                    {/strip}
                                {/capture}
                                {$smarty.capture.star|grn_noescape}
                            </div>
                        {/foreach}
                        </td>
                    {/foreach}
                </tr>

                {grn_schedule_weekbanner banner_events=$week.banner_event page='schedule/view' setdate=$week.week_start enddate=$week.week_end banner_class='s_banner' blank_class='br_banner' banner_image='banner16.gif' uid=$schedule.user_id gid=$group_id referer_key=$referer_key trid=$week.trid display_flag=$display_flag onclick="cy_um_rd(this);"}
            {/foreach}
        {/strip}
        </tbody>
        <tbody>
            <tr>
                <td colspan="7" class="personal_month_calendar_navi_bottom">
                    <table class="move_week_area">
                        <tbody>
                            <tr>
                                <td>
                                    <div class="move_week" onclick="CyScheduleUm.ctrl('week_prev',0);return false;" {if $user_agent.app == 'ie'}ondblclick="CyScheduleUm.ctrl('week_prev',0);return false;"{/if}>
                                        <div class="move_week_in"><a href="#"><img src="{$app_path}/grn/image/cybozu/image-common/arrowUp.png?{$build_date}"border="0">{cb_msg module='grn.schedule' key='GRN_SCH-10' replace='true'}</a>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <div class="move_week" onclick="CyScheduleUm.ctrl('week_next',0);return false;" {if $user_agent.app == 'ie'}ondblclick="CyScheduleUm.ctrl('week_next',0);return false;"{/if}>
                                        <div class="move_week_in"><a href="#">{cb_msg module='grn.schedule' key='GRN_SCH-11' replace='true'}<img src="{$app_path}/grn/image/cybozu/image-common/arrowDown.png?{$build_date}" border="0"></a>
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
    <table width="100%">
        <colgroup>
            <col width="6%">
            {foreach from=$month_count item=month}
                <col width="5%">
            {/foreach}
            <col width="6%">
            <col width="*">
        </colgroup>
        <tr>
            {if $uid_is_empty}
                {assign var='user_id' value=''}
            {/if}
            <td align="center" nowrap>
                <a href="{grn_pageurl page=$page_info.all bdate=$calendar_prev_year uid=$user_id gid=$group_id search_text=$search_text}">&lt;&lt;{cb_msg module='grn.schedule' key='GRN_SCH-12' replace='true'}</a>
            </td>
            {foreach from=$month_count item=month}
                <td align="center"><a href="{grn_pageurl page=$page_info.all bdate=$month.date uid=$user_id gid=$group_id search_text=$search_text}">{cb_msg module='fw.date' key='MonthShort'|cat:$month.month}{cb_msg module='fw.ui' key='date_month_unit'}</a></td>
            {/foreach}
            <td align="center" nowrap>
                <a href="{grn_pageurl page=$page_info.all bdate=$calendar_next_year uid=$user_id gid=$group_id search_text=$search_text}">{cb_msg module='grn.schedule' key='GRN_SCH-14' replace='true'}&gt;&gt;</a>
            </td>
            <td class="v-align-middle" align="right" nowrap>
            {strip}
              <div class="moveButtonBlock-grn">
                <span class="moveButtonBaseDisable-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-781' replace='true'}">
                  <a href="javascript:void(0);" id="onloadAble0" name="onloadAble" class="scheduleMove" onclick="if(check_disable(this))CyScheduleUm.ctrl('month_prev',0);return false;" {if $user_agent.app == 'ie'}ondblclick="if(check_disable(this))CyScheduleUm.ctrl('month_prev',0);return false;"{/if} title="{cb_msg module='grn.schedule' key='GRN_SCH-781' replace='true'}"><span class="moveButtonArrowLeftDisable-grn"></span></a>
                </span>
                <span class="moveButtonBaseDisable-grn">
                  <a href="javascript:void(0);" id="onloadAble2" name="onloadAble" class="scheduleMove" onclick="if(check_disable(this))location.href='{grn_pageurl page=$page_info.all bdate=$date uid=$user_id gid=$group_id search_text=$search_text}';return false;"> {cb_msg module='grn.schedule' key='GRN_SCH-782' replace='true'} </a>
                </span>
                <span class="moveButtonBaseDisable-grn" title="{cb_msg module='grn.schedule' key='GRN_SCH-783' replace='true'}">
                  <a href="javascript:void(0);" id="onloadAble4" name="onloadAble" class="scheduleMove" onclick="if(check_disable(this))CyScheduleUm.ctrl('month_next',0);return false;" {if $user_agent.app == 'ie'}ondblclick="if(check_disable(this))CyScheduleUm.ctrl('month_next',0);return false;"{/if}><span class="moveButtonArrowRightDisable-grn"></span></a>
                </span>
              </div>
            {/strip}
            </td>
        </tr>
    </table>
</div><!--view_end--->
 
<div id="loading" class="loading" style="display:none;position:absolute;">{grn_image image="spinner.gif"}{cb_msg module='grn.schedule' key='GRN_SCH-25' replace='true'}</div>
</div>
{grn_load_javascript file="fw/yui/build/dragdrop/dragdrop-min.js"}
{grn_load_javascript file="fw/yui/build/selector/selector-min.js"}
{grn_load_javascript file="grn/html/schedule.js"}
{include file="grn/error_handler.tpl"}
{grn_load_customization_js_css}
{include file='grn/footer.tpl'}

{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
<div class="mainareaSchedule-grn">
{grn_load_javascript file="grn/html/schedule.js"}
{*
<div class="bold">{grn_date_format format='DateFull_YMDW' date=$bdate}</div>
{include file='schedule/_member_day.tpl'}
*}
<div><span class="bold">{grn_date_format format='DateFull_YMDW' date=$bdate}</span><a href="javascript:void(0);display_on_off('display_day_open:display_swith_image_open:display_swith_image_close')"><span id="display_swith_image_open" class="mLeft10">{cb_msg module='grn.schedule' key='GRN_SCH-535' replace='true'}{capture name='grn_schedule_GRN_SCH_536'}{cb_msg module='grn.schedule' key='GRN_SCH-536' replace='true'}{/capture}{capture name='grn_schedule_GRN_SCH_537'}{cb_msg module='grn.schedule' key='GRN_SCH-537' replace='true'}{/capture}{grn_image image='addressee_on20.gif' alt=$smarty.capture.grn_schedule_GRN_SCH_536 title=$smarty.capture.grn_schedule_GRN_SCH_537}</span><span id="display_swith_image_close" class="mLeft10" style="display:none;">{cb_msg module='grn.schedule' key='GRN_SCH-538' replace='true'}{capture name='grn_schedule_GRN_SCH_539'}{cb_msg module='grn.schedule' key='GRN_SCH-539' replace='true'}{/capture}{capture name='grn_schedule_GRN_SCH_540'}{cb_msg module='grn.schedule' key='GRN_SCH-540' replace='true'}{/capture}{grn_image image='addressee_off20.gif' alt=$smarty.capture.grn_schedule_GRN_SCH_539 title=$smarty.capture.grn_schedule_GRN_SCH_540}</span></a></div>
<div id="display_day_open" style="display:none;">
{include file='schedule/_member_day.tpl'}
</div>
{grn_title title=$page_title class=$page_info.parts[0] style="display:inline-block;"}
{assign var='form_name' value=$smarty.template|basename}
{assign var="t_year" value=$schedule_event.this_date->year}
{assign var="t_month" value=$schedule_event.this_date->month}
{assign var="t_day" value=$schedule_event.this_date->day}
{assign var="s_year" value=$schedule_event.start_date->year}
{assign var="s_month" value=$schedule_event.start_date->month}
{assign var="s_day" value=$schedule_event.start_date->day}
<form class="js_customization_form" id="{$form_name}" name="{$form_name}" method="post" action="{grn_pageurl page='schedule/command_modify'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <div class="js_customization_schedule_header_space"></div>
 <div id="show_error" class="attention" style="display:none"><span class="bold" >{cb_msg module='grn.schedule' key='GRN_SCH-178' replace='true'}</span></div>
 {include file='grn/indispensable.tpl'}
 <table class="std_form">
  <tr valign="top">
   <th>{capture name='grn_schedule_GRN_SCH_543'}{cb_msg module='grn.schedule' key='GRN_SCH-543' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_GRN_SCH_543 necessary=TRUE}</th>
   <td>
   {capture name='grn_schedule_GRN_SCH_544'}{cb_msg module='grn.schedule' key='GRN_SCH-178' replace='true'}{/capture}{validate form=$form_name field="apply" criteria="notEmpty" message=$smarty.capture.grn_schedule_GRN_SCH_544 append="validation_errors"}{if $bdate}<div class="mBottom3"><span class="radiobutton_base_grn">{capture name='grn_schedule_GRN_SCH_992'}{cb_msg module='grn.schedule' key='GRN_SCH-992' replace='true'}{/capture}{grn_radio name="apply" id="apply3" value="this" caption=$smarty.capture.grn_schedule_GRN_SCH_992|cat:$schedule_event.date onclick="selectOff('ymd',this.form,'start_');selectOff('ymd',this.form,'end_');"}{grn_select_date prefix='this_' date=$schedule_event.this_date form_name=$form_name no_delimiter=true}</span></div><div class="mBottom3">{capture name='grn_schedule_GRN_SCH_850'}{cb_msg module='grn.schedule' key='GRN_SCH-850' replace='true'}{$schedule_event.after_date}{cb_msg module='grn.schedule' key='GRN_SCH-851' replace='true'}{/capture}{grn_radio name="apply" id="apply4" value="after" caption=$smarty.capture.grn_schedule_GRN_SCH_850 onclick="selectOn('ymd',this.form,'end_');changeDate(this.form,'start_',$t_year,$t_month,$t_day);selectOff('ymd',this.form,'start_');" span_cover="1"}</div><div class="mBottom3">{capture name='grn_schedule_GRN_SCH_547'}{cb_msg module='grn.schedule' key='GRN_SCH-547' replace='true'}{/capture}{grn_radio name="apply" id="apply5" value="all" caption=$smarty.capture.grn_schedule_GRN_SCH_547 onclick="selectOn('ymd',this.form,'start_');selectOn('ymd',this.form,'end_');changeDate(this.form,'start_',$s_year,$s_month,$s_day)" span_cover="1"}</div>{else}<div class="mBottom3">{capture name='grn_schedule_GRN_SCH_548'}{cb_msg module='grn.schedule' key='GRN_SCH-548' replace='true'}{/capture}{grn_radio name="apply" id="apply5" value="all" caption=$smarty.capture.grn_schedule_GRN_SCH_548 span_cover="1"}</div>{/if}</td>
  <tr valign="top">
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-549' replace='true'}</th>
   <td>
<div class="sub_title mBottom3">{cb_msg module='grn.schedule' key='GRN_SCH-550' replace='true'}</div>
<div class="mBottom3">
{if $schedule_event.type == 'day'}
{capture name='grn_schedule_GRN_SCH_551'}{cb_msg module='grn.schedule' key='GRN_SCH-551' replace='true'}{/capture}{grn_radio name="type" id="day" value="day" caption=$smarty.capture.grn_schedule_GRN_SCH_551 checked=TRUE span_cover="1"}
{else}
{capture name='grn_schedule_GRN_SCH_552'}{cb_msg module='grn.schedule' key='GRN_SCH-552' replace='true'}{/capture}{grn_radio name="type" id="day" value="day" caption=$smarty.capture.grn_schedule_GRN_SCH_552 span_cover="1"}
{/if}
</div>
<div class="mBottom3">
{if $schedule_event.type == 'weekday'}
{capture name='grn_schedule_GRN_SCH_553'}{cb_msg module='grn.schedule' key='GRN_SCH-553' replace='true'}{/capture}{grn_radio name="type" id="weekday" value="weekday" caption=$smarty.capture.grn_schedule_GRN_SCH_553 checked=TRUE span_cover="1"}
{else}
{capture name='grn_schedule_GRN_SCH_554'}{cb_msg module='grn.schedule' key='GRN_SCH-554' replace='true'}{/capture}{grn_radio name="type" id="weekday" value="weekday" caption=$smarty.capture.grn_schedule_GRN_SCH_554 span_cover="1"}
{/if}
</div>
<div class="mBottom3">
{if $schedule_event.type != 'day' && $schedule_event.type != 'weekday' && $schedule_event.type != 'month'}
 {assign var='selected_week' value='checked'}
{/if}
<span class="radiobutton_base_grn">
<input type="radio" name="type" id="week" value="week" {$selected_week}>
<select name="week" onclick="radio_select('{$form_name}','type','week')">
    <option value="week"{if $schedule_event.type == 'week'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-60' replace='true'}
    <option value="1stweek"{if $schedule_event.type == '1stweek'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-61' replace='true'}
    <option value="2ndweek"{if $schedule_event.type == '2ndweek'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-62' replace='true'}
    <option value="3rdweek"{if $schedule_event.type == '3rdweek'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-63' replace='true'}
    <option value="4thweek"{if $schedule_event.type == '4thweek'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-64' replace='true'}
    <option value="lastweek"{if $schedule_event.type == 'lastweek'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-65' replace='true'}
   </select>
   <select name="wday" onclick="radio_select('{$form_name}','type','week')">
    <option value="0"{if $schedule_event.wday == '0'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-561' replace='true'}
    <option value="1"{if $schedule_event.wday == '1'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-562' replace='true'}
    <option value="2"{if $schedule_event.wday == '2'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-563' replace='true'}
    <option value="3"{if $schedule_event.wday == '3'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-564' replace='true'}
    <option value="4"{if $schedule_event.wday == '4'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-565' replace='true'}
    <option value="5"{if $schedule_event.wday == '5'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-566' replace='true'}
    <option value="6"{if $schedule_event.wday == '6'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-567' replace='true'}
   </select>
</span>
</div>
<div class="mBottom15">
<span class="radiobutton_base_grn">
{if $schedule_event.type == 'month'}
{capture name='grn_schedule_GRN_SCH_568'}{cb_msg module='grn.schedule' key='GRN_SCH-568' replace='true'}{/capture}{grn_radio name="type" id="3month" value="month" caption=$smarty.capture.grn_schedule_GRN_SCH_568 checked=TRUE}<select name="day" >
{else}
{capture name='grn_schedule_GRN_SCH_569'}{cb_msg module='grn.schedule' key='GRN_SCH-569' replace='true'}{/capture}{grn_radio name="type" id="3month" value="month" caption=$smarty.capture.grn_schedule_GRN_SCH_569}<select name="day" onclick="radio_select('{$form_name}','type','month')">
{/if}
<option value=1{if $schedule_event.day == '1'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-570' replace='true'}
<option value=2{if $schedule_event.day == '2'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-571' replace='true'}
<option value=3{if $schedule_event.day == '3'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-572' replace='true'}
<option value=4{if $schedule_event.day == '4'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-573' replace='true'}
<option value=5{if $schedule_event.day == '5'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-574' replace='true'}
<option value=6{if $schedule_event.day == '6'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-575' replace='true'}
<option value=7{if $schedule_event.day == '7'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-576' replace='true'}
<option value=8{if $schedule_event.day == '8'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-577' replace='true'}
<option value=9{if $schedule_event.day == '9'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-578' replace='true'}
<option value=10{if $schedule_event.day == '10'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-579' replace='true'}
<option value=11{if $schedule_event.day == '11'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-580' replace='true'}
<option value=12{if $schedule_event.day == '12'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-581' replace='true'}
<option value=13{if $schedule_event.day == '13'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-582' replace='true'}
<option value=14{if $schedule_event.day == '14'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-583' replace='true'}
<option value=15{if $schedule_event.day == '15'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-584' replace='true'}
<option value=16{if $schedule_event.day == '16'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-585' replace='true'}
<option value=17{if $schedule_event.day == '17'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-586' replace='true'}
<option value=18{if $schedule_event.day == '18'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-587' replace='true'}
<option value=19{if $schedule_event.day == '19'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-588' replace='true'}
<option value=20{if $schedule_event.day == '20'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-589' replace='true'}
<option value=21{if $schedule_event.day == '21'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-590' replace='true'}
<option value=22{if $schedule_event.day == '22'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-591' replace='true'}
<option value=23{if $schedule_event.day == '23'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-592' replace='true'}
<option value=24{if $schedule_event.day == '24'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-593' replace='true'}
<option value=25{if $schedule_event.day == '25'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-594' replace='true'}
<option value=26{if $schedule_event.day == '26'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-595' replace='true'}
<option value=27{if $schedule_event.day == '27'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-596' replace='true'}
<option value=28{if $schedule_event.day == '28'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-597' replace='true'}
<option value=29{if $schedule_event.day == '29'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-598' replace='true'}
<option value=30{if $schedule_event.day == '30'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-599' replace='true'}
<option value=31{if $schedule_event.day == '31'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-600' replace='true'}
   <option value="0" {if $schedule_event.day == '0'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-601' replace='true'}
   </select>
</span>
</div>
<div class="sub_title mBottom3">{cb_msg module='grn.schedule' key='GRN_SCH-602' replace='true'}</div>
{literal}
<script language="JavaScript" type="text/javascript">

function change_enddate()
{
    form = document.forms["{/literal}{$form_name}{literal}"];
    cb_ui_select_date_change_enddate( form );
}
//-->
</script>
{/literal}
{grn_select_date prefix='start_' date=$schedule_event.start_date form_name=$form_name onchange='change_enddate();' no_delimiter=true}{cb_msg module='grn.schedule' key='GRN_SCH-606' replace='true'}{grn_select_date prefix='end_' date=$schedule_event.end_date form_name=$form_name no_delimiter=true}
<div><span id="span_time_span" class="margin_top sub_explanation"><span class="attention" id="invalid_date" style="display:none;">{cb_msg module='grn.schedule' key='invalid_date' replace='true'}</span></span></div>
<div class="margin_top"><span class="sub_explanation">{cb_msg module='grn.schedule' key='GRN_SCH-607' replace='true'}&nbsp;{$repeat_limit}{cb_msg module='grn.schedule' key='GRN_SCH-608' replace='true'}</span></div>
<p>
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-609' replace='true'}</th>
   <td>
{grn_select_time prefix='start_' minute_interval=$minute_interval time=$schedule_event.start_time}{include file='grn/time_selector.tpl' target_form=$form_name start_hour='start_hour' end_hour='end_hour'}{cb_msg module='grn.schedule' key='GRN_SCH-610' replace='true'}{grn_select_time prefix='end_' minute_interval=$minute_interval time=$schedule_event.end_time}<span id="span_time_span" class="repeat_time_span margin_top sub_explanation"><span id="time_span">{cb_msg module='grn.schedule' key='time_span' replace='true'}</span><span id="hours_num" style="display:none;"></span><span id="hours_unit" style="display:none;">{cb_msg module='grn.schedule' key='hours_unit' replace='true'}</span><span id="minutes_num" style="display:none;"></span><span id="minutes_unit" style="display:none;">{cb_msg module='grn.schedule' key='minutes_unit' replace='true'}</span><span class="attention" id="validate_repeat_date" style="display:none;">{cb_msg module='grn.schedule' key='validate_repeat_date' replace='true'}</span></span>
{include file='schedule/_select_timezone.tpl' timezone=$schedule_event.timezone end_timezone=$schedule_event.timezone disable_different_timezones='true'}
<div id="another_timezone" class="link_timezone"><span id="timezone_to_link"><span id="current_timezone">{cb_msg module='fw.timezone' key=$schedule_event.timezone}</span><span>&nbsp;{cb_msg module='grn.schedule' key='timezone_to_link' replace='true'}&nbsp;</span></span><a id="opne_timezone_dialog" href="javascript:;" onclick="GRN_ScheduleSelectTimezone.openTimezoneDialog();">{cb_msg module='grn.schedule' key='display_timezone' replace='true'}</a></div>
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-611' replace='true'}</th>
   <td>
    <select menu="scuedule_menu" name="menu" class="hidden">
{if $schedule_event.selectmenu !== FALSE && $schedule_event.selectmenu !== '' && ! is_null( $schedule_event.selectmenu )}
     <option value="{$schedule_event.selectmenu|escape};#{$schedule_event.menucolor|escape}">{$schedule_event.selectmenu|escape}</option>
{/if}
     <option value="">-----</option>
{foreach from=$menus key=menu_id item=menu}
     <option value="{$menu[0]|escape};#{$menu[1]|escape}">{$menu[0]|escape}</option>
{/foreach}
    </select>&nbsp;{grn_text name="title" value=$schedule_event.title size="80" disable_return_key=true}
   </td>
  </tr>
  <tr valign="top">
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-612' replace='true'}</th>
   <td>
    {grn_member_add name='member_select' form_name=$form_name selected_users=$schedule_event.users app_id='schedule' access_plugin=$add_plugin include_org=$show_organize popup_include_org=$show_organize org_direct=TRUE is_calendar=TRUE}
   </td>
  </tr>
{if ! $disabled_facility}
  <tr valign="top">
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-613' replace='true'}</th>
   <td>
       {include file='schedule/facility_add.tpl' initialize_item=$schedule_event.facilities}
<!--extended_items-->
<div id="extended_items" name="extended_items" style="margin-left:20px;{if $schedule_event.facilities|@count < 1}display:none;{/if}">
<table>
{include file='schedule/_action_item_contents.tpl' extended_items=$extended_items}
</table>
</div>
<!--extended_items_end-->
   </td>
  </tr>
{/if}
  <tr>
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-615' replace='true'}</th>
   <td>
    {include file="schedule/_confirmview.tpl"}
   </td>
  </tr>
{if $use_private}
    {include file="schedule/_private_menu.tpl"}
{/if}

  {include file="schedule/_address_menu.tpl"}

  <tr valign="top">
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-616' replace='true'}</th>
   <td>{grn_textarea name="memo" value=$schedule_event.memo rows="5" cols="65"}</td>
  </tr>
  <tr>
   <td></td>
   <td>
    {include file="schedule/_modify_button.tpl"}
   </td>
  </tr>
 </table>
 <input type="hidden" name="RP" value="1">
 <input type="hidden" name='event_id' value="{$schedule_event.event_id|escape}">
 <input type="hidden" name='bdate' value="{$bdate|escape}">
 <input type="hidden" name="uid" value="{$user_id|escape|escape:"javascript"}">
 <input type="hidden" name="referer_key" value="{$referer_key|escape}">
<!---GTM143-->
<input type="hidden" id="hfExcept" name ="hfExcept" />
<!---end GTM143-->
 <input type="hidden" name="additional_items" value="{$schedule_event.additional_items|escape}">
</form>
{if $bdate}
<script language="JavaScript">
<!--
    window.onload = function(){literal}{{/literal}typeChange("{$form_name}","apply","1");{literal}}{/literal}
//-->
</script>
{/if}
<script type="text/javascript" src="{$app_path}/grn/html/schedule_span.js?{$build_date}"></script>
<script type="text/javascript" src="{$app_path}/grn/html/schedule_validate_date.js?{$build_date}"></script>
<script type="text/javascript" src="{$app_path}/grn/html/timezone_info.js?{$build_date}"></script>
</div>
{include file="grn/footer.tpl"}
{grn_load_customization_js_css}
{grn_load_javascript file="js/dist/schedule.js"}
{literal}
    <script language="JavaScript" type="text/javascript">
        jQuery(function () {
            grn.js.component.customization.schedule.event_trigger.syncMembers("schedule.event.edit.show");
        });
    </script>
{/literal}

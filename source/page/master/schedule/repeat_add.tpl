{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
<div class="mainareaSchedule-grn">
{grn_load_javascript file="grn/html/schedule.js"}
<div><span class="bold">{grn_date_format format='DateFull_YMDW' date=$bdate}</span><a href="javascript:void(0);display_on_off('display_day_open:display_swith_image_open:display_swith_image_close')"><span id="display_swith_image_open" class="mLeft10">{cb_msg module='grn.schedule' key='GRN_SCH-48' replace='true'}{capture name='grn_schedule_GRN_SCH_49'}{cb_msg module='grn.schedule' key='GRN_SCH-49' replace='true'}{/capture}{capture name='grn_schedule_GRN_SCH_50'}{cb_msg module='grn.schedule' key='GRN_SCH-50' replace='true'}{/capture}{grn_image image='addressee_on20.gif' alt=$smarty.capture.grn_schedule_GRN_SCH_49 title=$smarty.capture.grn_schedule_GRN_SCH_50}</span><span id="display_swith_image_close" class="mLeft10" style="display:none;">{cb_msg module='grn.schedule' key='GRN_SCH-51' replace='true'}{capture name='grn_schedule_GRN_SCH_52'}{cb_msg module='grn.schedule' key='GRN_SCH-52' replace='true'}{/capture}{capture name='grn_schedule_GRN_SCH_53'}{cb_msg module='grn.schedule' key='GRN_SCH-53' replace='true'}{/capture}{grn_image image='addressee_off20.gif' alt=$smarty.capture.grn_schedule_GRN_SCH_52 title=$smarty.capture.grn_schedule_GRN_SCH_53}</span></a></div>
<div id="display_day_open" style="display:none;">
{include file='schedule/_member_day.tpl'}
</div>
{grn_title title=$page_title class=$page_info.parts[0] style="display:inline-block;"}
{assign var='form_name' value=$smarty.template|basename}
<div class="explanation mTop3 mBottom5">{cb_msg module='grn.schedule' key='GRN_SCH-55' replace='true'}</div>
<form class="js_customization_form" name="{$form_name}" id="{$form_name}" method="post" action="{grn_pageurl page='schedule/command_add'}">
{include file="schedule/_add_menu.tpl"}
<div class="js_customization_schedule_header_space"></div>
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<!---GTM143-->
<input type="hidden" id="hfExcept" name ="hfExcept" />
<!---end GTM143-->
<input type="hidden" name="additional_items" value="{$schedule_event.additional_items|escape}">
 <table class="std_form">
  <tr valign="top">
   <th nowrap>{cb_msg module='grn.schedule' key='GRN_SCH-56' replace='true'}</th>
   <td>
    <table>
     <tr>
      <td nowrap>
<div class="sub_title mBottom3">{cb_msg module='grn.schedule' key='GRN_SCH-57' replace='true'}</div>
<div class="mBottom3">
{if $schedule_event.type == 'day'}
 {assign var='selected_day' value=TRUE}
{/if}
{capture name='grn_schedule_GRN_SCH_58'}{cb_msg module='grn.schedule' key='GRN_SCH-58' replace='true'}{/capture}{grn_radio name="type" id="day" value="day" caption=$smarty.capture.grn_schedule_GRN_SCH_58 checked=$selected_day span_cover="1"}
</div>
<div class="mBottom3">
{if $schedule_event.type == 'weekday'}
 {assign var='selected_weekday' value=TRUE}
{/if}
{capture name='grn_schedule_GRN_SCH_59'}{cb_msg module='grn.schedule' key='GRN_SCH-59' replace='true'}{/capture}{grn_radio name="type" id="weekday" value="weekday" caption=$smarty.capture.grn_schedule_GRN_SCH_59 checked=$selected_weekday span_cover="1"}
</div>
<div class="mBottom3">
{if $schedule_event.type != 'day' && $schedule_event.type != 'weekday' && $schedule_event.type != 'month'}
 {assign var='selected_week' value='checked'}
{/if}
<span class="radiobutton_base_grn"><input type="radio" name="type" id="week" value="week" {$selected_week}><select name="week" onclick="radio_select('{$form_name}','type','week')">
    <option value="week" {if $schedule_event.type == 'week'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-60' replace='true'}
    <option value="1stweek" {if $schedule_event.type == '1stweek'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-61' replace='true'}
    <option value="2ndweek" {if $schedule_event.type == '2ndweek'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-62' replace='true'}
    <option value="3rdweek" {if $schedule_event.type == '3rdweek'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-63' replace='true'}
    <option value="4thweek" {if $schedule_event.type == '4thweek'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-64' replace='true'}
    <option value="lastweek" {if $schedule_event.type == 'lastweek'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-65' replace='true'}
   </select><select name="wday" onclick="radio_select('{$form_name}','type','week')">
    <option value="0"{if $schedule_event.wday == '0'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-66' replace='true'}
    <option value="1"{if $schedule_event.wday == '1'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-67' replace='true'}
    <option value="2"{if $schedule_event.wday == '2'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-68' replace='true'}
    <option value="3"{if $schedule_event.wday == '3'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-69' replace='true'}
    <option value="4"{if $schedule_event.wday == '4'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-70' replace='true'}
    <option value="5"{if $schedule_event.wday == '5'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-71' replace='true'}
    <option value="6"{if $schedule_event.wday == '6'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-72' replace='true'}
   </select></span>
</div>
<div class="mBottom15">
{if $schedule_event.type == 'month'}
 {assign var='selected_month' value=TRUE}
{/if}
{capture name='grn_schedule_GRN_SCH_73'}{cb_msg module='grn.schedule' key='GRN_SCH-73' replace='true'}{/capture}<span class="radiobutton_base_grn">{grn_radio name="type" id="3month" value="month" caption=$smarty.capture.grn_schedule_GRN_SCH_73 checked=$selected_month}<select name="day" onclick="radio_select('{$form_name}','type','month')">
<option value=1{if $schedule_event.day == '1'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-74' replace='true'}
<option value=2{if $schedule_event.day == '2'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-75' replace='true'}
<option value=3{if $schedule_event.day == '3'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-76' replace='true'}
<option value=4{if $schedule_event.day == '4'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-77' replace='true'}
<option value=5{if $schedule_event.day == '5'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-78' replace='true'}
<option value=6{if $schedule_event.day == '6'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-79' replace='true'}
<option value=7{if $schedule_event.day == '7'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-80' replace='true'}
<option value=8{if $schedule_event.day == '8'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-81' replace='true'}
<option value=9{if $schedule_event.day == '9'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-82' replace='true'}
<option value=10{if $schedule_event.day == '10'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-83' replace='true'}
<option value=11{if $schedule_event.day == '11'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-84' replace='true'}
<option value=12{if $schedule_event.day == '12'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-85' replace='true'}
<option value=13{if $schedule_event.day == '13'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-86' replace='true'}
<option value=14{if $schedule_event.day == '14'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-87' replace='true'}
<option value=15{if $schedule_event.day == '15'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-88' replace='true'}
<option value=16{if $schedule_event.day == '16'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-89' replace='true'}
<option value=17{if $schedule_event.day == '17'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-90' replace='true'}
<option value=18{if $schedule_event.day == '18'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-91' replace='true'}
<option value=19{if $schedule_event.day == '19'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-92' replace='true'}
<option value=20{if $schedule_event.day == '20'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-93' replace='true'}
<option value=21{if $schedule_event.day == '21'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-94' replace='true'}
<option value=22{if $schedule_event.day == '22'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-95' replace='true'}
<option value=23{if $schedule_event.day == '23'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-96' replace='true'}
<option value=24{if $schedule_event.day == '24'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-97' replace='true'}
<option value=25{if $schedule_event.day == '25'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-98' replace='true'}
<option value=26{if $schedule_event.day == '26'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-99' replace='true'}
<option value=27{if $schedule_event.day == '27'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-100' replace='true'}
<option value=28{if $schedule_event.day == '28'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-101' replace='true'}
<option value=29{if $schedule_event.day == '29'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-102' replace='true'}
<option value=30{if $schedule_event.day == '30'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-103' replace='true'}
<option value=31{if $schedule_event.day == '31'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-104' replace='true'}
   <option value="0" {if $schedule_event.day == '0'} selected{/if}>{cb_msg module='grn.schedule' key='GRN_SCH-105' replace='true'}
   </select></span>
</div>
<div class="sub_title mBottom3">{cb_msg module='grn.schedule' key='GRN_SCH-106' replace='true'}</div>
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
{grn_select_date prefix='start_' date=$schedule_event.start_date form_name=$form_name onchange='change_enddate();' no_delimiter=true}{cb_msg module='grn.schedule' key='GRN_SCH-110' replace='true'}{grn_select_date prefix='end_' date=$schedule_event.end_date form_name=$form_name no_delimiter=true}
<div><span id="span_time_span" class="margin_top sub_explanation"><span class="attention" id="invalid_date" style="display:none;">{cb_msg module='grn.schedule' key='invalid_date' replace='true'}</span></span></div>
<div class="mTop3"><span class="sub_explanation">{cb_msg module='grn.schedule' key='GRN_SCH-111' replace='true'}&nbsp;{$repeat_limit}{cb_msg module='grn.schedule' key='GRN_SCH-112' replace='true'}</span></div>
      </td>
     </tr>
    </table>
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-119' replace='true'}</th>
   <td>
{grn_select_time prefix='start_' minute_interval=$minute_interval time=$schedule_event.start_time}{include file='grn/time_selector.tpl' target_form=$form_name start_hour='start_hour' end_hour='end_hour'}{cb_msg module='grn.schedule' key='GRN_SCH-120' replace='true'}{grn_select_time prefix='end_' minute_interval=$minute_interval time=$schedule_event.end_time}<span id="span_time_span" class="repeat_time_span margin_top sub_explanation"><span id="time_span">{cb_msg module='grn.schedule' key='time_span' replace='true'}</span><span id="hours_num" style="display:none;"></span><span id="hours_unit" style="display:none;">{cb_msg module='grn.schedule' key='hours_unit' replace='true'}</span><span id="minutes_num" style="display:none;"></span><span id="minutes_unit" style="display:none;">{cb_msg module='grn.schedule' key='minutes_unit' replace='true'}</span><span class="attention" id="validate_repeat_date" style="display:none;">{cb_msg module='grn.schedule' key='validate_repeat_date' replace='true'}</span></span>
{include file='schedule/_select_timezone.tpl' timezone=$schedule_event.timezone end_timezone=$schedule_event.end_timezone disable_different_timezones='true'}
<div id="another_timezone" class="link_timezone"><span id="timezone_to_link"><span id="current_timezone">{cb_msg module='fw.timezone' key=$schedule_event.timezone}</span><span>&nbsp;{cb_msg module='grn.schedule' key='timezone_to_link' replace='true'}&nbsp;</span></span><a id="opne_timezone_dialog" href="javascript:;" onclick="GRN_ScheduleSelectTimezone.openTimezoneDialog();">{cb_msg module='grn.schedule' key='display_timezone' replace='true'}</a></div>
   </td>
  </tr>
  <tr>
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-121' replace='true'}</th>
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
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-122' replace='true'}</th>
   <td>
    {grn_member_add name='member_select' form_name=$form_name selected_users=$schedule_event.users app_id='schedule' access_plugin=$add_plugin include_org=$show_organize popup_include_org=$show_organize org_direct=TRUE is_calendar=TRUE}
   </td>
  </tr>
{if ! $disabled_facility}
  <tr valign="top">
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-123' replace='true'}</th>
   <td>
    {include file='schedule/facility_add.tpl' initialize_item=$schedule_event.facilities}

<!--extended_items-->
<div id="extended_items" name="extended_items" class="facilityExtended-grn" {if $schedule_event.facilities|@count < 1}style="display:none;"{/if}>
<table>
{include file='schedule/_action_item_contents.tpl' extended_items=$extended_items}
</table>
</div>
<!--extended_items_end-->
   </td>
  </tr>
{/if}
  <tr>
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-124' replace='true'}</th>
   <td>
    {include file="schedule/_confirmview.tpl"}
   </td>
  </tr>
{if $use_private}
  {include file="schedule/_private_menu.tpl"}
{/if}

  {include file="schedule/_address_menu.tpl"}

  <tr valign="top">
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-125' replace='true'}</th>
   <td>{grn_textarea name="memo" value=$schedule_event.memo rows="5" cols="65"}</td>
  </tr>
  <tr>
   <td>&nbsp;</td>
   <td>
    {include file="schedule/_add_button.tpl"}  
   </td>
  </tr>
 </table>
 <input type="hidden" name="RP" value="1">
</form>
<script type="text/javascript" src="{$app_path}/grn/html/schedule_span.js?{$build_date}"></script>
<script type="text/javascript" src="{$app_path}/grn/html/schedule_validate_date.js?{$build_date}"></script>
<script type="text/javascript" src="{$app_path}/grn/html/timezone_info.js?{$build_date}"></script>
</div>
{include file='grn/footer.tpl'}
{grn_load_customization_js_css}
{grn_load_javascript file="js/dist/schedule.js"}
{literal}
<script language="JavaScript" type="text/javascript">
    jQuery(function () {
        grn.js.component.customization.schedule.event_trigger.syncMembers("schedule.event.create.show");
    });
</script>
{/literal}

{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/form_disable.js"}
<form name="{$form_name}" method="get" action="{grn_pageurl page='system/calendar/command_export' postfix='calendar.csv'}">

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-44' replace='true'}</th>
{if $calendar.id == '1'}
  <td>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-45' replace='true'}</td>
{else}
  <td>{$calendar.title|escape}</td>
{/if}
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-46' replace='true'}</th>
  <td>
       {capture name='grn_system_calendar_GRN_SY_CA_47'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-47' replace='true'}{/capture}{grn_radio name='all' id='all1' value='1' caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_47 checked=true onclick="setDisableById(d, 'start_year:start_month:start_day:end_year:end_month:end_day', 'on')"}
       <div class="margin_top">
       {capture name='grn_system_calendar_GRN_SY_CA_48'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-48' replace='true'}{/capture}{grn_radio name='all' id='all2' value='0' caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_48 onclick="setDisableById(d, 'start_year:start_month:start_day:end_year:end_month:end_day', 'off')"}<br>
       {grn_select_date prefix='start_' date=$stime form_name=$form_name necessary=true}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-49' replace='true'}{grn_select_date prefix='end_' date=$etime form_name=$form_name necessary=true}{* 月日は消す *}
       </div>
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-50' replace='true'}</th>
  <td>{grn_charset name='charset' bom='TRUE'}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-51' replace='true'}</th>
  <td>
      {capture name='grn_system_calendar_GRN_SY_CA_52'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-52' replace='true'}{/capture}{grn_radio name='title' id='3' value='1' caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_52 checked=false}&nbsp;{capture name='grn_system_calendar_GRN_SY_CA_53'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-53' replace='true'}{/capture}{grn_radio name='title' id='4' value='0' caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_53 checked=true}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_calendar_GRN_SY_CA_54'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-54' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_54}
       {grn_button_cancel class='margin' page='system/calendar/systemcalendar_list' scid=$calendar.id}
  </td>
 </tr>
</table>

<input type="hidden" name="scid" value="{$calendar.id}">
</form>

<script language="JavaScript">
<!--
    var d = document.forms["{$form_name}"];
    window.onload = function(){literal}{{/literal}if(d.elements['all'][0].checked) setDisableById(d,'start_year:start_month:start_day:end_year:end_month:end_day','on');{literal}}{/literal}
//-->
</script>

<hr>
<p>
{include file='system/calendar/_csv_columns.tpl'}
{include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='export' column_explanation=$smarty.capture.explanation}

{include file='grn/system_footer.tpl'}

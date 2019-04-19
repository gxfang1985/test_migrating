{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/form_disable.js"}
<form name="{$form_name}" method="get" action="{grn_pageurl page='personal/calendar/command_export' postfix='my_calendar.csv'}">

<table class="std_form">
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-3' replace='true'}</th>
  <td>
  {capture name='grn_personal_calendar_GRN_PRS_CA_4'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-4' replace='true'}{/capture}{grn_radio name='all' id='all1' value='1' caption=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_4 checked=true onclick="setDisableById(d, 'start_year:start_month:start_day:end_year:end_month:end_day', 'on')"}
  <div class="margin_top">
  {capture name='grn_personal_calendar_GRN_PRS_CA_5'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-5' replace='true'}{/capture}{grn_radio name='all' id='all2' value='0' caption=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_5 onclick="setDisableById(d, 'start_year:start_month:start_day:end_year:end_month:end_day', 'off')"}<br>
  {grn_select_date prefix='start_' date=$stime necessary=true form_name=$form_name}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-6' replace='true'}{grn_select_date prefix='end_' date=$etime necessary=true form_name=$form_name}{* 月日は消す *}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-7' replace='true'}</th>
  <td>{grn_charset name='charset' bom='TRUE'}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-8' replace='true'}</th>
  <td>
  {capture name='grn_personal_calendar_GRN_PRS_CA_9'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-9' replace='true'}{/capture}{grn_radio name='title' id='yes' value='1' caption=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_9 checked=false}&nbsp;{capture name='grn_personal_calendar_GRN_PRS_CA_10'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-10' replace='true'}{/capture}{grn_radio name='title' id='no' value='0' caption=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_10 checked=true}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_personal_calendar_GRN_PRS_CA_11'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-11' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_11}
  {grn_button_cancel class='margin' page='personal/calendar/calendar_view' bdate=$stime->year}
  </td>
 </tr>
</table>

</form>
<script language="JavaScript">
<!--
    var d = document.forms["{$form_name}"];
    window.onload = function(){literal}{{/literal}if(d.elements['all'][0].checked) setDisableById(d,'start_year:start_month:start_day:end_year:end_month:end_day','on');{literal}}{/literal}
//-->
</script>
<hr>
<p>
{include file='personal/calendar/_csv_columns.tpl'}
{include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='export' column_explanation=$smarty.capture.explanation}

{include file='grn/personal_footer.tpl'}

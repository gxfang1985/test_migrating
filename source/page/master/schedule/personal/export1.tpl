{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/personal/command_'|cat:$page_info.last postfix='schedules.csv'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
     {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-35' replace='true'}
  </th>
  <td>
      {grn_select_date prefix='start_' date="$stime" form_name=$form_name}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-36' replace='true'}{grn_select_date prefix='end_' date="$etime" form_name=$form_name}  </td>
 </tr>
 <tr>
  <th nowrap>
     {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-37' replace='true'}
  </th>
  <td>
     {grn_charset name='charset' bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
     {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-38' replace='true'}
  </th>
  <td>
     {capture name='grn_schedule_personal_GRN_SCH_PE_39'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-39' replace='true'}{/capture}{grn_radio name='item_name' id='yes' value='1' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_39}&nbsp;{capture name='grn_schedule_personal_GRN_SCH_PE_40'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-40' replace='true'}{/capture}{grn_radio name='item_name' id='no' value='0' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_40 checked=true}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_schedule_personal_GRN_SCH_PE_41'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-41' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_41}
      {grn_button_cancel page='personal/application_list' app_id='schedule'}
  </td>
 </tr>
</table>

<p>
<hr>
<p>
{include file='schedule/personal/_event_csv_columns.tpl'}
{capture name='grn_schedule_personal_GRN_SCH_PE_42'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-42' replace='true'}{/capture}{include file='grn/csv_columns.tpl' columns=$columns column_explanation=$smarty.capture.explanation type='export' sub_explanation=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_42}
</form>
{include file='grn/personal_footer.tpl'}

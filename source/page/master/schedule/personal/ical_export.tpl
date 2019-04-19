{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/personal/command_'|cat:$page_info.last postfix='schedules.ical'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>
     {cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-35' replace='true'}
  </th>
  <td>
      {grn_select_date prefix='start_' date="$stime" form_name=$form_name}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-36' replace='true'}{grn_select_date prefix='end_' date="$etime" form_name=$form_name}  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_schedule_personal_GRN_SCH_PE_41'}{cb_msg module='grn.schedule.personal' key='GRN_SCH_PE-41' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_personal_GRN_SCH_PE_41}
      {grn_button_cancel page='personal/application_list' app_id='schedule'}
  </td>
 </tr>
</table>
</form>
{include file='grn/personal_footer.tpl'}

{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-470' replace='true'}
  <div class="attention">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-471' replace='true'}</div>
 </p>
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-472' replace='true'}</th>
  <td>{grn_select_date prefix='term_' date=$start_date form_name=$form_name}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-473' replace='true'}</td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_schedule_system_GRN_SCH_SY_474'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-474' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_474}
       {grn_button_cancel page='system/application_list' app_id='schedule'}
  </td>
 </tr>
</table>
</form>

{include file='grn/system_footer.tpl'}

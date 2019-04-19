{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="fagid" value="{$facility_group.fagid}">
 <p>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-156' replace='true'}<span class="bold">{grn_sentence caption=$facility_group.title image='facilitygroup20.gif'}</span>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-157' replace='true'}</p>
 <p>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-158' replace='true'}<br />{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-159' replace='true'}</p>
 <p>
  {capture name='grn_schedule_operation_GRN_SCH_OP_160'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-160' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_160}
  {capture name='grn_schedule_operation_GRN_SCH_OP_161'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-161' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_161}
 </p>
</form>
{include file='grn/footer.tpl'}

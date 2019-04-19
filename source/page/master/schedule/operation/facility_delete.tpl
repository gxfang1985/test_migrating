{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="fagid" value="{$facility.fagid}">
<input type="hidden" name="faid" value="{$facility.faid}">
 <p>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-75' replace='true'}<span class="bold">{grn_sentence caption=$facility.title image='facility20.gif'}</span>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-76' replace='true'}</p>
 <p>
  {capture name='grn_schedule_operation_GRN_SCH_OP_77'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-77' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_77}
  {capture name='grn_schedule_operation_GRN_SCH_OP_78'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-78' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_78}
 </p>
</form>
{include file='grn/footer.tpl'}

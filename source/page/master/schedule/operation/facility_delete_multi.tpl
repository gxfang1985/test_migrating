{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-162' replace='true'}<span class="bold">{$delete_item.delete_numbers}</span>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-163' replace='true'}</p>
 <p>
  {capture name='grn_schedule_operation_GRN_SCH_OP_164'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-164' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_164}
  {capture name='grn_schedule_operation_GRN_SCH_OP_165'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-165' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_165}
 </p>
{foreach from=$delete_item.facility item=faid}
 <input type="hidden" name="faid[]" value="{$faid}">
{/foreach}
<input type="hidden" name="fagid" value="{$fagid|escape}">
</form>
{include file='grn/footer.tpl'}

{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="tid" value="{$target|escape}">
<input type="hidden" name="oid" value="{$org_id|escape}">
<input type="hidden" name="fagid" value="{$fgroup_id|escape}">
<input type="hidden" name="uid" value="{$user_id|escape}">
<input type="hidden" name="rid" value="{$role_id|escape}">
<input type="hidden" name="faid" value="{$facility_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-188' replace='true'}
{include file='schedule/operation/_schedule_user_name.tpl'}
{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-22' replace='true'}
</div>

{capture name='grn_schedule_operation_GRN_SCH_OP_23'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-23' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_23}
{capture name='grn_schedule_operation_GRN_SCH_OP_24'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-24' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_24}

</form>

{include file='grn/footer.tpl'}

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
<input type="hidden" name="security_model" value="{$security_model}">

<div class="explanation">
{capture name="grant_caption"}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-11' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-12' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-13' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-14' replace='true'}{/capture}

{include file='schedule/operation/_schedule_user_name.tpl'}
{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-15' replace='true'}<span class="bold">{if $is_grant}{$smarty.capture.grant_caption|grn_noescape}{elseif $is_revoke}{$smarty.capture.revoke_caption|grn_noescape}{/if}</span>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-16' replace='true'}

<div class="attention">
{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-17' replace='true'}
{include file='schedule/operation/_schedule_user_name.tpl'}
{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-18' replace='true'}
</div>

</div>

{capture name='grn_schedule_operation_GRN_SCH_OP_19'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-19' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_19}
{capture name='grn_schedule_operation_GRN_SCH_OP_20'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-20' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_20}

</form>

{include file='grn/footer.tpl'}

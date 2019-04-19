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
{include file='schedule/operation/_schedule_user_name.tpl'}
{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-169' replace='true'}
</div>

<p>
<table class="std_form">
<tr>
<th>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-170' replace='true'}</th>
<td>
{capture name="grant_caption"}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-171' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-172' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-173' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-174' replace='true'}{/capture}
{grn_radio name='security_model' id='grant' value='grant' caption=$smarty.capture.grant_caption checked=$is_grant}<br>
{grn_radio name='security_model' id='revoke' value='revoke' caption=$smarty.capture.revoke_caption checked=$is_revoke}<br>
</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_schedule_operation_GRN_SCH_OP_175'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-175' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_175}
{grn_button_cancel}
</td>
</tr>
</table>

</form>

{include file='grn/footer.tpl'}

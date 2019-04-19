{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="cid" value="{$cid|escape}">
<input type="hidden" name="fid" value="{$fid|escape}">
<input type="hidden" name="psid" value="{$psid|escape}">
{foreach from=$mids item=member_id}
<input type="hidden" name="mids[]" value="{$member_id|escape}">
{/foreach}

<div class="explanation">
{cb_msg module='grn.workflow.system' key='key_104_1' replace='true'}<span class="bold">{$col_role|escape}</span>{cb_msg module='grn.workflow.system' key='key_104_2' replace='true'}<span class="bold">{$member_count}</span>{cb_msg module='grn.workflow.system' key='key_104_3' replace='true'}
</div>

<p>
{capture name='grn_workflow_system_w_yes'}{cb_msg module='grn.workflow.system' key='w_yes' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_yes}
{capture name='grn_workflow_system_w_no'}{cb_msg module='grn.workflow.system' key='w_no' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_workflow_system_w_no page='workflow/operation/form_default_list' poid=$poid cid=$cid fid=$fid psid=$psid}
</p>

</form>

{include file='grn/footer.tpl'}

{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cid" value="{$cid|escape}">
<input type="hidden" name="fid" value="{$fid|escape}">
<p class="explanation">{if GRN_WORKFLOW_CIRCULAR == $col_type}{cb_msg module='grn.workflow.system' key='key_115_1' replace='true'}{else}{cb_msg module='grn.workflow.system' key='key_115_2' replace='true'}{/if}{cb_msg module='grn.workflow.system' key='key_115_3' replace='true'}<span class="bold">{$path_step_count|escape}</span>{cb_msg module='grn.workflow.system' key='key_115_4' replace='true'}</p>
{capture name='grn_workflow_system_w_yes'}{cb_msg module='grn.workflow.system' key='w_yes' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_yes}
{capture name='grn_workflow_system_w_no'}{cb_msg module='grn.workflow.system' key='w_no' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_workflow_system_w_no page='workflow/operation/form_view' cid=$cid fid=$fid}
{foreach from=$psids item=path_step_id}
<input type="hidden" name="psids[]" value="{$path_step_id|escape}">
{/foreach}
</form>
{include file="grn/footer.tpl"}

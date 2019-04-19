{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
<input type="hidden" name="sid" value="{$skip_id|escape}">
{foreach from=$condition_ids key=key item=id}
<input type="hidden" name="pcids[]" value="{$id|escape}">
{/foreach}
 <p>{cb_msg module='grn.workflow.system' key='key_90_1' replace='true'}<span class="bold">{$count|escape}</span>{cb_msg module='grn.workflow.system' key='key_90_2' replace='true'}</p>
 <p>
  {capture name='grn_workflow_system_w_yes'}{cb_msg module='grn.workflow.system' key='w_yes' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_yes}
  {capture name='grn_workflow_system_w_no'}{cb_msg module='grn.workflow.system' key='w_no' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_workflow_system_w_no page='workflow/operation/form_view' cid=$category_id fid=$form_id}
 </p>

{foreach from=$cids item=cid}
<input type="hidden" name="cids[]" value="{$cid|escape}">
{/foreach}
</form>
{include file="grn/footer.tpl"}

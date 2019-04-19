{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.workflow.system' key='key_85_1' replace='true'}<span class="bold">{if $category_id == GRN_WORKFLOW_CATEGORY_NONPARTY_ID}{capture name='grn_workflow_system_w_unlabeled'}{cb_msg module='grn.workflow.system' key='w_unlabeled' replace='true'}{/capture}{grn_sentence image='category_trush20.gif' caption=$smarty.capture.grn_workflow_system_w_unlabeled}{else}{grn_sentence image='category20.gif' caption=$category.name}{/if}</span>{cb_msg module='grn.workflow.system' key='key_85_2' replace='true'}<span class="bold">{$delete_numbers|escape}</span>{cb_msg module='grn.workflow.system' key='key_85_3' replace='true'}</p>
 <p>
  {capture name='grn_workflow_system_w_yes'}{cb_msg module='grn.workflow.system' key='w_yes' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_yes}
  {capture name='grn_workflow_system_w_no'}{cb_msg module='grn.workflow.system' key='w_no' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_workflow_system_w_no page='workflow/system/form_list' cid=$category_id sf=1}
 </p>
<input type="hidden" name="cid" value="{$category_id|escape}">
{foreach from=$form_id_list item=id}
<input type="hidden" name="ids[]" value="{$id|escape}">
{/foreach}
</form>
{include file="grn/system_footer.tpl"}

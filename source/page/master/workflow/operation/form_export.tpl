{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/operation/command_'|cat:$page_info.last postfix=$filename postfix='form.xml'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>{cb_msg module='grn.workflow.system' key='key_101_1' replace='true'}<span class="bold">{grn_sentence image='category20.gif' caption=$category.name}</span>{cb_msg module='grn.workflow.system' key='key_101_2' replace='true'}</p>
<p>
 {capture name='grn_workflow_system_w_export_y'}{cb_msg module='grn.workflow.system' key='w_export_y' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_export_y}
 {capture name='grn_workflow_system_w_cancel'}{cb_msg module='grn.workflow.system' key='w_cancel' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_workflow_system_w_cancel page='workflow/operation/form_list' cid=$category.cid}
</p>
<input type="hidden" name="cid" value="{$category.cid}">
</form>

{include file='grn/footer.tpl'}

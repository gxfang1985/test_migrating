{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p class="explanation">{cb_msg module='grn.workflow.system' key='key_125_1' replace='true'}{grn_image image='public_path20.gif'}<span class="bold">{$col_name|escape}</span>{cb_msg module='grn.workflow.system' key='key_125_2' replace='true'}</p>
{capture name='grn_workflow_system_w_yes'}{cb_msg module='grn.workflow.system' key='w_yes' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_yes}
{capture name='grn_workflow_system_w_no'}{cb_msg module='grn.workflow.system' key='w_no' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_workflow_system_w_no page='workflow/system/path_view' pid=$pid}
<input type="hidden" name="pid" value="{$pid|escape}">
</form>
{include file="grn/system_footer.tpl"}

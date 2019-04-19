{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="pid" value="{$pid|escape}">
<p class="explanation">{cb_msg module='grn.workflow.system' key='key_95_1' replace='true'}{grn_image image='private_path20.gif'}<span class="bold">{$col_name|escape}</span>{cb_msg module='grn.workflow.system' key='key_95_2' replace='true'}<br />{cb_msg module='grn.workflow.system' key='key_95_3' replace='true'}</p>
{capture name='grn_workflow_system_w_yes'}{cb_msg module='grn.workflow.system' key='w_yes' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_yes}
{grn_button_cancel page='workflow/system/path_view' pid=$pid}
</form>
{include file="grn/system_footer.tpl"}

{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last postfix=$filename postfix='paths.xml'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p class="explanation">{cb_msg module='grn.workflow.system' key='key_140' replace='true'}</p>
{capture name='grn_workflow_system_w_export_y'}{cb_msg module='grn.workflow.system' key='w_export_y' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_export_y}
{capture name='grn_workflow_system_w_cancel'}{cb_msg module='grn.workflow.system' key='w_cancel' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_workflow_system_w_cancel page='workflow/system/path_list'}
</form>
{include file='grn/system_footer.tpl'}

{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p><div class="explanation">{cb_msg module='grn.workflow.system' key='w_select_route_step_toapprove_view_y' replace='true'}</div></p>
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape|escape}">
<input type="hidden" name="sid" value="{$skip_id|escape}">
<input type="hidden" name="pcid" value="{$condition_id|escape}">
<input type="hidden" name="pid" value="{$path_id|escape}">

{capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_y' replace='true'}{/capture}{include file='workflow/system/_path_condition_add.tpl' btn_name=$smarty.capture.grn_workflow_system_w_do_change_y}

</form>
{include file='grn/system_footer.tpl'}

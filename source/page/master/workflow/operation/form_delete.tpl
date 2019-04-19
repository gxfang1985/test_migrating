{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.workflow.system' key='key_149_1' replace='true'}<span class="bold">{grn_workflow_form_icon_image icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url}{grn_sentence caption=$form.name}</span>{cb_msg module='grn.workflow.system' key='key_149_2' replace='true'}
 <div class="attention">{cb_msg module='grn.workflow.system' key='w_all_app_form_item_delete_y' replace='true'}</div>
 </p>
 <p>
   {capture name='grn_workflow_system_w_yes'}{cb_msg module='grn.workflow.system' key='w_yes' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_yes}
   {capture name='grn_workflow_system_w_no'}{cb_msg module='grn.workflow.system' key='w_no' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_workflow_system_w_no}
 </p>
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
</form>

{include file='grn/footer.tpl'}

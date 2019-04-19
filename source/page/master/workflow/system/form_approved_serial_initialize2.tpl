{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title|cat:' - Step 2/2' class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-129' replace='true'}</p>
 <p>{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-130' replace='true'}<span class="bold">{grn_workflow_form_icon_image icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url}{grn_sentence caption=$form.name}</span></p>
 <p>{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-131' replace='true'}<span class="bold">{$new_serial_number}</span></p>
 <div class="attention">{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-132' replace='true'}</div>
 <p>
  {capture name='grn_workflow_system_w_yes'}{cb_msg module='grn.workflow.system' key='w_yes' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_yes}
  {capture name='grn_workflow_system_w_no'}{cb_msg module='grn.workflow.system' key='w_no' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_workflow_system_w_no page='workflow/system/form_view' cid=$category_id fid=$form_id}
 </p>
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
<input type="hidden" name="approved_serial_type" value="{$form.approved_serial_type|escape}">
<input type="hidden" name="approved_serial_format" value="{$form.approved_serial_format|escape}">
<input type="hidden" name="approved_serial_number" value="{$new_serial_number|escape}">
</form>
{include file="grn/system_footer.tpl"}

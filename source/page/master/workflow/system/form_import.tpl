{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.workflow.system' key='w_enter_XML_file' replace='true'}</div>
<p>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_workflow_system_w_file'}{cb_msg module='grn.workflow.system' key='w_file' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_file necessary=TRUE}
  </th>
  <td>
      {capture name='grn_workflow_system_w_files_required'}{cb_msg module='grn.workflow.system' key='w_files_required' replace='true'}{/capture}{validate form=$form_name field="file:file" criteria="grn_notFileEmpty" message=$smarty.capture.grn_workflow_system_w_files_required append="validation_errors"}{grn_file name="file" size="50" disable_return_key=true necessary=TRUE}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_workflow_system_w_import_y'}{cb_msg module='grn.workflow.system' key='w_import_y' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_workflow_system_w_import_y}
       {grn_button_cancel class="margin" page='workflow/system/form_list' cid=$category_id}
  </td>
 </tr>
</table>

<input type="hidden" name="cid" value="{$category_id|escape}">
</form>
{include file='grn/system_footer.tpl'}

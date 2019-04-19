{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p class="explanation">{cb_msg module='grn.workflow.system' key='w_enter_XML_file' replace='true'}</p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_file'}{cb_msg module='grn.workflow.system' key='w_file' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_file necessary=1}</th>
  <td>{capture name='grn_workflow_system_w_files_required'}{cb_msg module='grn.workflow.system' key='w_files_required' replace='true'}{/capture}{validate form=$form_name field='file:file' criteria='grn_notFileEmpty' message=$smarty.capture.grn_workflow_system_w_files_required append='validation_errors'}{grn_file name='file' size='50' necessary=1 disable_return_key=true}</td>
 </tr>
 <tr>
  <td></td>
  <td>
   <input class="margin" type="submit" name="send" value="{cb_msg module='grn.workflow.system' key='w_import_y' replace='true'}">
   {grn_button_cancel class='margin' page="workflow/system/path_list"}
  </td>
 </tr>
</table>
</form>
{include file='grn/system_footer.tpl'}

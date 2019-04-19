{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/filemanager/command_mime_modify'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="id" value="{$id}">

<p>
 <div class="explanation">
  {cb_msg module='grn.system.filemanager' key='GRN_SY_FI-70' replace='true'}<span class="bold">{$info.extension|escape}</span>{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-71' replace='true'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-72' replace='true'}
 </div>
</p>
 <div class="sub_explanation">{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-73' replace='true'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-74' replace='true'}<br>{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-75' replace='true'}</div>

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-76' replace='true'}</th>
  <td>{$info.extension|escape}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_system_filemanager_GRN_SY_FI_77'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-77' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_filemanager_GRN_SY_FI_77 necessary=TRUE}</th>
  <td>{capture name='grn_system_filemanager_GRN_SY_FI_78'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-78' replace='true'}{/capture}{validate form=$form_name field="mime" criteria="notEmpty" message=$smarty.capture.grn_system_filemanager_GRN_SY_FI_78 append="validation_errors"}{grn_text necessary=true name="mime" value=$info.mime size="50" disable_return_key=true}</td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_system_filemanager_GRN_SY_FI_79'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-79' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_79}
  {grn_button_cancel page='system/filemanager/mime_view' id=$id}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}

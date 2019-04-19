{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/filemanager/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">
{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-42' replace='true'}
</div>

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_system_filemanager_GRN_SY_FI_43'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-43' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_filemanager_GRN_SY_FI_43 necessary=TRUE}</th>
  <td>{capture name='grn_system_filemanager_GRN_SY_FI_44'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-44' replace='true'}{/capture}{validate form=$form_name field="extension" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_filemanager_GRN_SY_FI_44 append="validation_errors"}{grn_text necessary=true name="extension" value=$info.extension size="50" disable_return_key=true}
   <div class="sub_explanation">{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-45' replace='true'}</div>
   <div class="sub_explanation">{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-46' replace='true'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-47' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_system_filemanager_GRN_SY_FI_48'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-48' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_system_filemanager_GRN_SY_FI_48 necessary=TRUE}</th>
  <td>{capture name='grn_system_filemanager_GRN_SY_FI_49'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-49' replace='true'}{/capture}{validate form=$form_name field="mime" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_system_filemanager_GRN_SY_FI_49 append="validation_errors"}{grn_text necessary=true name="mime" value=$info.mime size="50" disable_return_key=true}
   <div class="sub_explanation">{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-50' replace='true'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-51' replace='true'}</div>
   <div class="sub_explanation">{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-52' replace='true'}/{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-53' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_system_filemanager_GRN_SY_FI_54'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-54' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_54}
  {grn_button_cancel page='system/filemanager/mime_list' sf='1'}
  </td>
 </tr>
</table>

</form>

{include file="grn/system_footer.tpl"}

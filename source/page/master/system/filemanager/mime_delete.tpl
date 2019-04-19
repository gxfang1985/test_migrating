{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/filemanager/command_mime_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
  {cb_msg module='grn.system.filemanager' key='GRN_SY_FI-55' replace='true'}<span class="bold">{$info.extension|escape}</span>{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-56' replace='true'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-57' replace='true'}
 </p>
  <div class="sub_explanation">{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-58' replace='true'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-59' replace='true'}<br>{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-60' replace='true'}</div>
 <p>
  {capture name='grn_system_filemanager_GRN_SY_FI_61'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-61' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_61}
  {capture name='grn_system_filemanager_GRN_SY_FI_62'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-62' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_62}
 </p>
<input type="hidden" name="id" value="{$id}">
</form>
{include file='grn/system_footer.tpl'}

{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/filemanager/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p><div class="explanation">{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-8' replace='true'}</div></p>
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-9' replace='true'}</th>
  <td>{grn_select name=$config.max_filesize.name options=$config.max_filesize.options padding=$config.max_filesize.padding selected=$config.max_filesize.selected}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-10' replace='true'}</th>
  <td>{grn_select name=$config.max_version.name options=$config.max_version.options padding=$config.max_version.padding selected=$config.max_version.selected}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-11' replace='true'}</th>
  <td>{grn_select name=$config.lock_timeout.name options=$config.lock_timeout.options padding=$config.lock_timeout.padding selected=$config.lock_timeout.selected}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-12' replace='true'}</th>
  <td>{capture name='grn_system_filemanager_GRN_SY_FI_13'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-13' replace='true'}{/capture}{grn_checkbox name=$config.file_lockable.name id=$config.file_lockable.name value="1" checked=$config.file_lockable.checked caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_13}</td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_system_filemanager_GRN_SY_FI_14'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-14' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_14}
  {grn_button_cancel}
  </td>
 </tr>
</table>

</form>

{include file="grn/system_footer.tpl"}

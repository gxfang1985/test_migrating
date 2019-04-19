{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_filemanager_GRN_SY_FI_30'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-30' replace='true'}{/capture}{grn_link page='system/filemanager/mime_modify' caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_30 image='modify20.gif' id=$id}</span>
<span class="menu_item">{capture name='grn_system_filemanager_GRN_SY_FI_31'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-31' replace='true'}{/capture}{grn_link page='system/filemanager/mime_delete' caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_31 image='delete20.gif' id=$id}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-32' replace='true'}</th>
  <td>{$info.extension|escape}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-33' replace='true'}</th>
  <td>{$info.mime|escape}</td>
 </tr>
</table>

{include file='grn/system_footer.tpl'}

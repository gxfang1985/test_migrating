{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/filemanager/command_mime_export' postfix='mime.csv'}">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-1' replace='true'}</th>
  <td>{grn_charset name="charset" bom='TRUE'}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-2' replace='true'}</th>
  <td>{capture name='grn_system_filemanager_GRN_SY_FI_3'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-3' replace='true'}{/capture}{grn_radio name="title" id="yes" value="1" caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_3 checked=false}&nbsp;{capture name='grn_system_filemanager_GRN_SY_FI_4'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-4' replace='true'}{/capture}{grn_radio name="title" id="no" value="0" caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_4 checked=true}</td>
 </tr>
 <tr>
  <td></td>
  <td>
  {capture name='grn_system_filemanager_GRN_SY_FI_5'}{cb_msg module='grn.system.filemanager' key='GRN_SY_FI-5' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_filemanager_GRN_SY_FI_5}
  {grn_button_cancel class="margin"}
  </td>
 </tr>
</table>

<hr>
<p>
{include file='system/filemanager/_mime_csv_columns.tpl'}
{include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='export'}

</form>

{include file="grn/system_footer.tpl"}

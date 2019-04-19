{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.portal.system' key='GRN_POT_SY-454' replace='true'}</div>
<p>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_portal_system_GRN_POT_SY_455'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-455' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_system_GRN_POT_SY_455 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_portal_system_GRN_POT_SY_456'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-456' replace='true'}{/capture}{validate form=$form_name field="file:file" criteria="grn_notFileEmpty" message=$smarty.capture.grn_portal_system_GRN_POT_SY_456 append="validation_errors"}{grn_file name="file" size="50" disable_return_key=true necessary=TRUE}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_portal_system_GRN_POT_SY_457'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-457' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_457 id='btn_file_upload'}
       {grn_button_cancel class="margin" page='portal/system/portlet_import_index'}
  </td>
 </tr>
</table>

</form>
{include file='grn/system_footer.tpl'}

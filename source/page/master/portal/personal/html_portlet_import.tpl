{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/personal/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.portal.personal' key='GRN_POT_PE-141' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_portal_personal_GRN_POT_PE_142'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-142' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_personal_GRN_POT_PE_142 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_portal_personal_GRN_POT_PE_143'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-143' replace='true'}{/capture}{validate form=$form_name field="file:file" criteria="grn_notFileEmpty" message=$smarty.capture.grn_portal_personal_GRN_POT_PE_143 append="validation_errors"}{grn_file name="file" size="50" disable_return_key=true necessary=TRUE}</div>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_portal_personal_GRN_POT_PE_144'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-144' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_144 id='btn_file_upload'}
       {grn_button_cancel}
  </td>
 </tr>
</table>

</form>

{include file='grn/personal_footer.tpl'}

{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-361' replace='true'}</div>
<p>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_report_system_GRN_RPRT_SY_362'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-362' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_system_GRN_RPRT_SY_362 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_report_system_GRN_RPRT_SY_363'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-363' replace='true'}{/capture}{validate form=$form_name field="file:file" criteria="grn_notFileEmpty" message=$smarty.capture.grn_report_system_GRN_RPRT_SY_363 append="validation_errors"}{grn_file name="file" size="50" disable_return_key=true necessary=TRUE}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_report_system_GRN_RPRT_SY_364'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-364' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_364}
       {grn_button_cancel class="margin" page='report/system/form_list' cid=$category_id}
  </td>
 </tr>
</table>

<input type="hidden" name="cid" value="{$category_id|escape}">
</form>
{include file='grn/system_footer.tpl'}

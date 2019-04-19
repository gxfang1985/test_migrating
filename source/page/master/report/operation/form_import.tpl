{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-300' replace='true'}</div>
<p>
<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_report_operation_GRN_RPRT_OP_301'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-301' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_operation_GRN_RPRT_OP_301 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_report_operation_GRN_RPRT_OP_302'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-302' replace='true'}{/capture}{validate form=$form_name field="file:file" criteria="grn_notFileEmpty" message=$smarty.capture.grn_report_operation_GRN_RPRT_OP_302 append="validation_errors"}{grn_file name="file" size="50" disable_return_key=true necessary=TRUE}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_report_operation_GRN_RPRT_OP_303'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-303' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_303}
       {grn_button_cancel class="margin" page='report/operation/form_list' cid=$category_id}
  </td>
 </tr>
</table>

<input type="hidden" name="cid" value="{$category_id|escape}">
</form>
{include file='grn/footer.tpl'}

{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-418' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
<table class="std_form">
 <tr valign="top">
  <th nowrap>{capture name='grn_report_operation_GRN_RPRT_OP_419'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-419' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_operation_GRN_RPRT_OP_419}</th>
  <td>
      {grn_textarea name="admin_memo" rows="10" value=$form.admin_memo}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_report_operation_GRN_RPRT_OP_420'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-420' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_420}
      {grn_button_cancel}
  </td>
 </tr>
</table>

<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
</form>

{include file='grn/footer.tpl'}

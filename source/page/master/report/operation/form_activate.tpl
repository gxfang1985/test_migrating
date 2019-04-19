{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-386' replace='true'}<span class="bold">{grn_sentence caption=$form.name image='report20.gif'}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-387' replace='true'}{if $form.active == 1}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-388' replace='true'}{else}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-389' replace='true'}{/if}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-390' replace='true'}</p>
 <p>
  {capture name='grn_report_operation_GRN_RPRT_OP_391'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-391' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_391}
  {capture name='grn_report_operation_GRN_RPRT_OP_392'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-392' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_392}
 </p>
 <input type="hidden" name="cid" value="{$category_id|escape}">
 <input type="hidden" name="fid" value="{$form_id|escape}">
 <input type="hidden" name="active" value="{$form.active|escape}">
</form>
{include file='grn/footer.tpl'}

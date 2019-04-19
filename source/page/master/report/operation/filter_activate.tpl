{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-118' replace='true'}<span class="bold">{grn_sentence caption=$filter.col_name image='report20.gif'}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-119' replace='true'}{if $filter.col_active == 1}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-120' replace='true'}{else}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-121' replace='true'}{/if}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-122' replace='true'}</p>
 <p>
  {capture name='grn_report_operation_GRN_RPRT_OP_123'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-123' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_123}
  {capture name='grn_report_operation_GRN_RPRT_OP_124'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-124' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_124}
 </p>
 <input type="hidden" name="cid" value="{$category_id|escape}">
 <input type="hidden" name="fid" value="{$filter_id|escape}">
 <input type="hidden" name="active" value="{$filter.col_active|escape}">
</form>
{include file='grn/footer.tpl'}

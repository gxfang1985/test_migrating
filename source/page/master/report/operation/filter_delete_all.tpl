{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
 {cb_msg module='grn.report.operation' key='GRN_RPRT_OP-393' replace='true'}<span class="bold">{if $category_id == GRN_REPORT_CATEGORY_NONPARTY_ID}{grn_image image='category_trush20.gif'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-394' replace='true'}{else}{grn_sentence image='category20.gif' caption=$category.name}{/if}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-395' replace='true'}</p>
 <p>
  {capture name='grn_report_operation_GRN_RPRT_OP_396'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-396' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_396}
  {capture name='grn_report_operation_GRN_RPRT_OP_397'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-397' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_397 page='report/operation/filter_index' cid=$category_id sf=1}
 </p>
<input type="hidden" name="cid" value="{$category_id|escape}">
</form>
{include file="grn/footer.tpl"}

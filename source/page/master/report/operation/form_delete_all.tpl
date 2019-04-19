{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
 {cb_msg module='grn.report.operation' key='GRN_RPRT_OP-347' replace='true'}<span class="bold">{if $category_id == GRN_REPORT_CATEGORY_NONPARTY_ID}{grn_image image='category_trush20.gif'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-348' replace='true'}{else}{grn_sentence image='category20.gif' caption=$category.name}{/if}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-349' replace='true'}</p>
 <p>
  {capture name='grn_report_operation_GRN_RPRT_OP_350'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-350' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_350}
  {capture name='grn_report_operation_GRN_RPRT_OP_351'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-351' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_351 page='report/operation/form_list' cid=$category_id sf=1}
 </p>
<input type="hidden" name="cid" value="{$category_id|escape}">
</form>
{include file="grn/footer.tpl"}

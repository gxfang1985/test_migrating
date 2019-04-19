{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="filter_name" value=$smarty.template|basename}
<form name="{$filter_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-425' replace='true'}<span class="bold">{if $category_id == GRN_REPORT_CATEGORY_NONPARTY_ID}{capture name='grn_report_operation_GRN_RPRT_OP_426'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-426' replace='true'}{/capture}{grn_sentence image='category_trush20.gif' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_426}{else}{grn_sentence image='category20.gif' caption=$category.name}{/if}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-427' replace='true'}<span class="bold">{$delete_numbers|escape}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-428' replace='true'}</p>
 <p>
  {capture name='grn_report_operation_GRN_RPRT_OP_429'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-429' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_429}
  {capture name='grn_report_operation_GRN_RPRT_OP_430'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-430' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_430 page='report/operation/filter_index' cid=$category_id sf=1}
 </p>
<input type="hidden" name="cid" value="{$category_id|escape}">
{foreach from=$filter_id_list item=id}
<input type="hidden" name="ids[]" value="{$id|escape}">
{/foreach}
</form>
{include file="grn/footer.tpl"}

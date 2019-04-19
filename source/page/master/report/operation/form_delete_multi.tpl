{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-87' replace='true'}<span class="bold">{if $category_id == GRN_REPORT_CATEGORY_NONPARTY_ID}{capture name='grn_report_operation_GRN_RPRT_OP_88'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-88' replace='true'}{/capture}{grn_sentence image='category_trush20.gif' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_88}{else}{grn_sentence image='category20.gif' caption=$category.name}{/if}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-89' replace='true'}<span class="bold">{$delete_numbers|escape}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-90' replace='true'}</p>
 <p>
  {capture name='grn_report_operation_GRN_RPRT_OP_91'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-91' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_91}
  {capture name='grn_report_operation_GRN_RPRT_OP_92'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-92' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_92 page='report/operation/form_list' cid=$category_id sf=1}
 </p>
<input type="hidden" name="cid" value="{$category_id|escape}">
{foreach from=$form_id_list item=id}
<input type="hidden" name="ids[]" value="{$id|escape}">
{/foreach}
</form>
{include file="grn/footer.tpl"}

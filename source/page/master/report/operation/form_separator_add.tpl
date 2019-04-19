{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-82' replace='true'}<span class="bold">{if $category_id == GRN_REPORT_CATEGORY_NONPARTY_ID}{grn_image image='category_trush20.gif'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-83' replace='true'}{else}{grn_image image='category20.gif'}{$category.name|escape}{/if}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-84' replace='true'}</p>
 <p>
  {capture name='grn_report_operation_GRN_RPRT_OP_85'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-85' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_85}
  {capture name='grn_report_operation_GRN_RPRT_OP_86'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-86' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_86 page='report/operation/form_list' cid=$category_id sf=1}
 </p>
<input type="hidden" name="cid" value="{$category_id|escape}">
</form>
{include file="grn/footer.tpl"}

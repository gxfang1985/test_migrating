{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-375' replace='true'}<span class="bold">{grn_sentence caption=$form.name image='report20.gif'}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-376' replace='true'}</p>
 <p>
  {capture name='grn_report_operation_GRN_RPRT_OP_377'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-377' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_377}
  {capture name='grn_report_operation_GRN_RPRT_OP_378'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-378' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_378}
 </p>
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
</form>
{include file="grn/footer.tpl"}

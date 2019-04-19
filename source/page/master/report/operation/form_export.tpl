{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last postfix=$filename postfix='form.xml'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-212' replace='true'}<span class="bold">{grn_sentence image='category20.gif' caption=$category.name}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-213' replace='true'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-214' replace='true'}</p>
<p>
 {capture name='grn_report_operation_GRN_RPRT_OP_215'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-215' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_215}
 {capture name='grn_report_operation_GRN_RPRT_OP_216'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-216' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_216 page='report/operation/form_list' cid=$category.cid}
</p>
<input type="hidden" name="cid" value="{$category.cid}">
</form>

{include file='grn/footer.tpl'}

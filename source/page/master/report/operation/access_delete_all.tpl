{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-323' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-324' replace='true'}
{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-325' replace='true'}
</div>

<p>
{capture name='grn_report_operation_GRN_RPRT_OP_326'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-326' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_326}
{capture name='grn_report_operation_GRN_RPRT_OP_327'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-327' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_327}
</p>

</form>

{include file='grn/footer.tpl'}

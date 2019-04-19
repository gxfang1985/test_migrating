{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
{foreach from=$eid item=item}
<input type="hidden" name="eid[]" value="{$item|escape}">
{/foreach}

<div class="explanation">
{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-168' replace='true'}<span class="bold">{grn_sentence image='category20.gif' caption=$node.name}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-169' replace='true'}
{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-170' replace='true'}<span class="bold">{$count|escape}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-171' replace='true'}
</div>

<p>
{capture name='grn_report_operation_GRN_RPRT_OP_172'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-172' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_172}
{capture name='grn_report_operation_GRN_RPRT_OP_173'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-173' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_173}
</p>

</form>

{include file='grn/footer.tpl'}

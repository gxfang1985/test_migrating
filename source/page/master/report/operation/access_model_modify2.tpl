{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="security_model" value="{$security_model}">

<div class="explanation">
{capture name="grant_caption"}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-398' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-399' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-400' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-401' replace='true'}{/capture}

{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-402' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-403' replace='true'}
{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-404' replace='true'}<span class="bold">{if $security_model eq 'grant'}{$smarty.capture.grant_caption|grn_noescape}{elseif  $security_model eq 'revoke'}{$smarty.capture.revoke_caption|grn_noescape}{/if}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-405' replace='true'}

<div class="attention">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-406' replace='true'}<span class="bold">{grn_sentence image='category20.gif' caption=$node.name}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-407' replace='true'}</div>

</div>

<p>
{capture name='grn_report_operation_GRN_RPRT_OP_408'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-408' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_408}
{capture name='grn_report_operation_GRN_RPRT_OP_409'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-409' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_409}
</p>
</form>

{include file='grn/footer.tpl'}

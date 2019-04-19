{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-227' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-228' replace='true'}
{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-229' replace='true'}
</div>

<p>
<table class="std_form">
<tr>
<th>{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-230' replace='true'}</th>
<td>
{capture name="grant_caption"}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-231' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-232' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-233' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-234' replace='true'}{/capture}
{grn_radio name='security_model' id='grant' value='grant' caption=$smarty.capture.grant_caption checked=$is_grant}<br>
{grn_radio name='security_model' id='revoke' value='revoke' caption=$smarty.capture.revoke_caption checked=$is_revoke}<br>
</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_report_operation_GRN_RPRT_OP_235'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-235' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_235}
{grn_button_cancel}
</td>
</tr>
</table>

</form>

{include file='grn/footer.tpl'}

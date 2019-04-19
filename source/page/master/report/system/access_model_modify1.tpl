{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-252' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-253' replace='true'}
{cb_msg module='grn.report.system' key='GRN_RPRT_SY-254' replace='true'}
</div>

<p>
<table class="std_form">
<tr>
<th>{cb_msg module='grn.report.system' key='GRN_RPRT_SY-255' replace='true'}</th>
<td>
{capture name="grant_caption"}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-256' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-257' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-258' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-259' replace='true'}{/capture}
{grn_radio name='security_model' id='grant' value='grant' caption=$smarty.capture.grant_caption checked=$is_grant}<br>
{grn_radio name='security_model' id='revoke' value='revoke' caption=$smarty.capture.revoke_caption checked=$is_revoke}<br>
</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_report_system_GRN_RPRT_SY_260'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-260' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_260}
{grn_button_cancel}
</td>
</tr>
</table>

</form>

{include file='grn/system_footer.tpl'}

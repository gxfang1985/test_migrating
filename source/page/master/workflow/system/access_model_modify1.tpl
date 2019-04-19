{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.workflow.system' key='key_148_1' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.workflow.system' key='key_148_2' replace='true'}
</div>

<p>
<table class="std_form">
<tr>
<th>{cb_msg module='grn.workflow.system' key='w_security_mode' replace='true'}</th>
<td>
{capture name="grant_caption"}{cb_msg module='grn.workflow.system' key='w_grant' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.workflow.system' key='w_bracket_right' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.workflow.system' key='w_revoke' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.workflow.system' key='w_bracket_right' replace='true'}{/capture}
{grn_radio name='security_model' id='grant' value='grant' caption=$smarty.capture.grant_caption checked=$is_grant}<br>
{grn_radio name='security_model' id='revoke' value='revoke' caption=$smarty.capture.revoke_caption checked=$is_revoke}<br>
</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_y' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_workflow_system_w_do_change_y}
{grn_button_cancel}
</td>
</tr>
</table>

</form>

{include file='grn/system_footer.tpl'}

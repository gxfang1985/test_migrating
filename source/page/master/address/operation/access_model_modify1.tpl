{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='address/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-1' replace='true'}<span class="bold">{grn_image image='person20.gif'}{$node.name|escape}</span>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-2' replace='true'}
{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-3' replace='true'}
</div>

<p>
<table class="std_form">
<tr>
<th>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-4' replace='true'}</th>
<td>
{capture name="grant_caption"}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-5' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-6' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-7' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-8' replace='true'}{/capture}
{grn_radio name='security_model' id='grant' value='grant' caption=$smarty.capture.grant_caption checked=$grant}<br>
{grn_radio name='security_model' id='revoke' value='revoke' caption=$smarty.capture.revoke_caption checked=$revoke}<br>
</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_address_operation_GRN_ADDR_OP_9'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-9' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_9}
{grn_button_cancel}
</td>
</tr>
</table>

</form>

{include file='grn/footer.tpl'}

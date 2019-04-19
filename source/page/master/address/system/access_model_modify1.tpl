{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='address/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-63' replace='true'}<span class="bold">{grn_image image='person20.gif'}{$node.name|escape}</span>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-64' replace='true'}
</div>

<p>
<table class="std_form">
<tr>
<th>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-65' replace='true'}</th>
<td>
{capture name="grant_caption"}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-66' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-67' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-68' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-69' replace='true'}{/capture}
{grn_radio name='security_model' id='grant' value='grant' caption=$smarty.capture.grant_caption checked=$grant}<br>
{grn_radio name='security_model' id='revoke' value='revoke' caption=$smarty.capture.revoke_caption checked=$revoke}<br>
</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_address_system_GRN_ADDR_SYS_70'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-70' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_70}
{grn_button_cancel}
</td>
</tr>
</table>

</form>

{include file='grn/system_footer.tpl'}

{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='address/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-103' replace='true'}<span class="bold">{grn_image image='person20.gif'}{$node.name|escape}</span>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-104' replace='true'}
</div>

<p>
{capture name='grn_address_operation_GRN_ADDR_OP_105'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-105' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_105}
{capture name='grn_address_operation_GRN_ADDR_OP_106'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-106' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_106}
</p>

</form>

{include file='grn/footer.tpl'}

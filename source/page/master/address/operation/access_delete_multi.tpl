{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='address/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
{foreach from=$eid item=item}
<input type="hidden" name="eid[]" value="{$item|escape}">
{/foreach}

<div class="explanation">
{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-90' replace='true'}<span class="bold">{grn_image image='person20.gif'}{$node.name|escape}</span>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-91' replace='true'}<span class="bold">{$count}</span>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-92' replace='true'}
</div>

<p>
{capture name='grn_address_operation_GRN_ADDR_OP_93'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-93' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_93}
{capture name='grn_address_operation_GRN_ADDR_OP_94'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-94' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_94}
</p>

</form>

{include file='grn/footer.tpl'}

{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='address/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="security_model" value="{$security_model}">

<div class="explanation">
{if 'grant' == $security_model}
    {capture name="security_model"}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-77' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-78' replace='true'}{/capture}
{elseif 'revoke' == $security_model}
    {capture name="security_model"}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-79' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-80' replace='true'}{/capture}
{/if}

{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-81' replace='true'}<span class="bold">{grn_image image='person20.gif'}{$node.name|escape}</span>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-82' replace='true'}
{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-83' replace='true'}<span class="bold">{$smarty.capture.security_model|grn_noescape}</span>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-84' replace='true'}

<div class="attention">
{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-85' replace='true'}<span class="bold">{grn_image image='person20.gif'}{$node.name|escape}</span>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-86' replace='true'}
</div>

</div>

<p>
{capture name='grn_address_operation_GRN_ADDR_OP_87'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-87' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_87}
{capture name='grn_address_operation_GRN_ADDR_OP_88'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-88' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_88}
</p>

</form>

{include file='grn/footer.tpl'}

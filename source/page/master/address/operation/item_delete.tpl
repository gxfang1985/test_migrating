{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='address/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-107' replace='true'}<span class="bold">{grn_sentence image='person20.gif' caption=$book.display_name}</span>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-108' replace='true'}<span class="bold">{$item.display_name|escape}</span>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-109' replace='true'}</p>
 <p>
   {capture name='grn_address_operation_GRN_ADDR_OP_110'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-110' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_110}
   {capture name='grn_address_operation_GRN_ADDR_OP_111'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-111' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_111}
 </p>
<input type="hidden" name="bid" value="{$book.oid}">
<input type="hidden" name="eiid" value="{$extended_item_id}">
</form>

{include file='grn/footer.tpl'}

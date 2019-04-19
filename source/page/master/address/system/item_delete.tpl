{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='address/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-249' replace='true'}<span class="bold">{$item.display_name|escape}</span>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-250' replace='true'}</p>
 <p>
   {capture name='grn_address_system_GRN_ADDR_SYS_251'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-251' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_251}
   {capture name='grn_address_system_GRN_ADDR_SYS_252'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-252' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_252}
 </p>
<input type="hidden" name="bid" value="{$book_id}">
<input type="hidden" name="eiid" value="{$extended_item_id}">
</form>

{include file='grn/system_footer.tpl'}

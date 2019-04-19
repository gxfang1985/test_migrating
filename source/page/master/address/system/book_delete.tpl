{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='address/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-191' replace='true'}<span class="bold">{grn_sentence caption=$book.display_name class='person20'}</span>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-192' replace='true'}
 <div class="attention">{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-193' replace='true'}</div>
 </p>
 <p>
   {capture name='grn_address_system_GRN_ADDR_SYS_194'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-194' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_194}
   {capture name='grn_address_system_GRN_ADDR_SYS_195'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-195' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_195}
 </p>
<input type="hidden" name="bid" value="{$book.oid}">
</form>

{include file='grn/system_footer.tpl'}

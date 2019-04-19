{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='address/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-244' replace='true'}<span class="bold">{grn_image image='person20.gif'}{$node.name|escape}</span>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-245' replace='true'}
</div>

<p>
{capture name='grn_address_system_GRN_ADDR_SYS_246'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-246' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_246}
{capture name='grn_address_system_GRN_ADDR_SYS_247'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-247' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_247}
</p>

</form>

{include file='grn/system_footer.tpl'}

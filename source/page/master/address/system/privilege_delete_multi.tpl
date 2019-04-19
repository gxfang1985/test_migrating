{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='address/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
{foreach from=$eid item=item}
<input type="hidden" name="eid[]" value="{$item|escape}">
{/foreach}

<div class="explanation">
{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-127' replace='true'}<span class="bold">{grn_image image='person20.gif'}{$node.name|escape}</span>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-128' replace='true'}<span class="bold">{$count}</span>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-129' replace='true'}
</div>

<p>
{capture name='grn_address_system_GRN_ADDR_SYS_130'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-130' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_130}
{capture name='grn_address_system_GRN_ADDR_SYS_131'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-131' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_131}
</p>

</form>

{include file='grn/system_footer.tpl'}

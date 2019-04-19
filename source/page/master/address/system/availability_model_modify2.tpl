{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='address/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="security_model" value="{$security_model}">

<div class="explanation">
{if 'grant' == $security_model}
    {capture name="security_model"}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-285' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-286' replace='true'}{/capture}
{elseif 'revoke' == $security_model}
    {capture name="security_model"}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-287' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-288' replace='true'}{/capture}
{/if}

{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-289' replace='true'}<span class="bold">{$smarty.capture.security_model|grn_noescape}</span>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-290' replace='true'}

<div class="attention">
{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-291' replace='true'}
</div>

</div>

<p>
{capture name='grn_address_system_GRN_ADDR_SYS_292'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-292' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_292}
{capture name='grn_address_system_GRN_ADDR_SYS_293'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-293' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_293}
</p>

</form>

{include file='grn/system_footer.tpl'}

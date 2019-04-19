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
    {capture name="security_model"}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-153' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-154' replace='true'}{/capture}
{elseif 'revoke' == $security_model}
    {capture name="security_model"}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-155' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-156' replace='true'}{/capture}
{/if}

{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-157' replace='true'}<span class="bold">{grn_image image='person20.gif'}{$node.name|escape}</span>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-158' replace='true'}<span class="bold">{$smarty.capture.security_model|grn_noescape}</span>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-159' replace='true'}

<div class="attention">
{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-160' replace='true'}<span class="bold">{grn_image image='person20.gif'}{$node.name|escape}</span>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-161' replace='true'}
</div>

</div>

<p>
{capture name='grn_address_system_GRN_ADDR_SYS_162'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-162' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_162}
{capture name='grn_address_system_GRN_ADDR_SYS_163'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-163' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_163}
</p>

</form>

{include file='grn/system_footer.tpl'}

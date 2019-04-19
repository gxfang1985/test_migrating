{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="security_model" value="{$security_model}">
{foreach from=$ours_params key=key item=item}
<input type="hidden" name="{$key}" value="{$item|escape}">
{/foreach}
<div class="explanation">
{cb_msg module='grn.portal.operation' key='GRN_POT_OP-6' replace='true'}
{if 'portal' == $node.type}
{$app_name|escape}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-7' replace='true'}<span class="bold">{grn_image image='portal20.gif'}{$node.name|escape}</span>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-8' replace='true'}
{else}
{cb_msg module='grn.portal.operation' key='GRN_POT_OP-9' replace='true'}<span class="bold">{grn_image image='portlet20.gif'}{$node.name|escape}</span>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-10' replace='true'}
{/if}
{cb_msg module='grn.portal.operation' key='GRN_POT_OP-11' replace='true'}
</div>

{capture name='grn_portal_operation_GRN_POT_OP_12'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-12' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_12}
{capture name='grn_portal_operation_GRN_POT_OP_13'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-13' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_13}

</form>

{include file='grn/footer.tpl'}

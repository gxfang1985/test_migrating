{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{if 'portal' == $node.type}
{$app_name|escape}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-21' replace='true'}<span class="bold">{grn_image image='portal20.gif'}{$node.name|escape}</span>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-22' replace='true'}
{else}
{cb_msg module='grn.portal.operation' key='GRN_POT_OP-23' replace='true'}<span class="bold">{grn_image image='portlet20.gif'}{$node.name|escape}</span>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-24' replace='true'}
{/if}
{cb_msg module='grn.portal.operation' key='GRN_POT_OP-25' replace='true'}
</div>

{capture name='grn_portal_operation_GRN_POT_OP_26'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-26' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_26}
{capture name='grn_portal_operation_GRN_POT_OP_27'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-27' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_27}

{foreach from=$ours_params key=key item=item}
<input type="hidden" name="{$key}" value="{$item|escape}">
{/foreach}
</form>

{include file='grn/footer.tpl'}

{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
{foreach from=$eid item=item}
<input type="hidden" name="eid[]" value="{$item|escape}">
{/foreach}

<div class="explanation">
{cb_msg module='grn.link.operation' key='GRN_LNK_OP-21' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-22' replace='true'}
{cb_msg module='grn.link.operation' key='GRN_LNK_OP-23' replace='true'}<span class="bold">{$count}</span> {cb_msg module='grn.link.operation' key='GRN_LNK_OP-24' replace='true'}
</div>

{capture name='grn_link_operation_GRN_LNK_OP_25'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-25' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_25}
{capture name='grn_link_operation_GRN_LNK_OP_26'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-26' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_26}

</form>

{include file='grn/footer.tpl'}

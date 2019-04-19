{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.link.operation' key='GRN_LNK_OP-14' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$node.name|escape}</span>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-15' replace='true'}
{cb_msg module='grn.link.operation' key='GRN_LNK_OP-16' replace='true'}
</div>

{capture name='grn_link_operation_GRN_LNK_OP_17'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-17' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_17}
{capture name='grn_link_operation_GRN_LNK_OP_18'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-18' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_18}

</form>

{include file='grn/footer.tpl'}

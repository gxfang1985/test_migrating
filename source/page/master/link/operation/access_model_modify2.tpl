{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="security_model" value="{$security_model}">

<div class="explanation">
{capture name="grant_caption"}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-1' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-2' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-3' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-4' replace='true'}{/capture}

{cb_msg module='grn.link.operation' key='GRN_LNK_OP-5' replace='true'}<span class="bold">{grn_sentence image='category20.gif' caption=$node.name}</span>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-6' replace='true'}
{cb_msg module='grn.link.operation' key='GRN_LNK_OP-7' replace='true'}<span class="bold">{if $security_model eq 'grant'}{$smarty.capture.grant_caption|grn_noescape}{elseif  $security_model eq 'revoke'}{$smarty.capture.revoke_caption|grn_noescape}{/if}</span>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-8' replace='true'}

<div class="attention">{cb_msg module='grn.link.operation' key='GRN_LNK_OP-9' replace='true'}<span class="bold">{grn_sentence image='category20.gif' caption=$node.name}</span>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-10' replace='true'}</div>

</div>

<p>
{capture name='grn_link_operation_GRN_LNK_OP_11'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-11' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_11}
{capture name='grn_link_operation_GRN_LNK_OP_12'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-12' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_12}
</p>
</form>

{include file='grn/footer.tpl'}

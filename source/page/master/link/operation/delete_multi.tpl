{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-57' replace='true'}<span class="bold">{grn_sentence image='category20.gif' caption=$category.name}</span>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-58' replace='true'}<span class="bold">{$delete_numbers|escape}</span>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-59' replace='true'}</p>
 <p>
  {capture name='grn_link_operation_GRN_LNK_OP_60'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-60' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_60}
  {capture name='grn_link_operation_GRN_LNK_OP_61'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-61' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_61}
 </p>
<input type="hidden" name="cid" value="{$category.cid}">
{foreach from=$link item=id}
<input type="hidden" name="ids[]" value="{$id}">
{/foreach}
</form>
{include file="grn/footer.tpl"}

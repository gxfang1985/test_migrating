{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-72' replace='true'}<span class="bold">{grn_image image='category20.gif'}{$category.title|escape}</span>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-74' replace='true'}</p>
 <p>
  {capture name='grn_link_operation_GRN_LNK_OP_75'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-75' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_75}
  {capture name='grn_link_operation_GRN_LNK_OP_76'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-76' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_76}
 </p>
<input type="hidden" name="cid" value="{$category.cid}">
</form>
{include file="grn/footer.tpl"}

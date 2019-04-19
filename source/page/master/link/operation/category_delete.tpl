{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-126' replace='true'}<span class="bold">{grn_sentence image='category20.gif' caption=$category.title}</span>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-127' replace='true'}</p>
 <div class="attention">{cb_msg module='grn.link.operation' key='GRN_LNK_OP-128' replace='true'}</div>
 <p>
  {capture name='grn_link_operation_GRN_LNK_OP_129'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-129' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_129}
  {capture name='grn_link_operation_GRN_LNK_OP_130'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-130' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_130}
 </p>
<input type="hidden" name="cid" value="{$category.cid}">
</form>
{include file="grn/footer.tpl"}

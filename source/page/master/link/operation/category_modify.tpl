{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-85' replace='true'}</p>
{include file="grn/show_validation_errors.tpl"}
{include file='grn/indispensable.tpl'}
 {include file='link/operation/_category_modify.tpl' button_file='link/operation/_category_modify_buttons.tpl'}
<input type="hidden" name="cid" value="{$category.cid}">
</form>
{include file="grn/footer.tpl"}

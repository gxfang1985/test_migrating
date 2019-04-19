{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/operation/command_file_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{include file="grn/file_delete.tpl"}
<input type="hidden" name="cid" value="{$category_id}">
<input type="hidden" name="aid" value="{$article_id}">
<input type="hidden" name="follow_id" value="{$follow_id}">
</form>
{include file="grn/footer.tpl"}

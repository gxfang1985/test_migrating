{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="get" action="{grn_pageurl page='message/search'}">
<input type="hidden" name="cid" value="{$category_id}">
{include file='message/_search_default.tpl' view_page='message/view'}
</form>
{include file="grn/footer.tpl"}

{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/operation/command_bulletin_delete_term1'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{include file='bulletin/_article_delete_term1.tpl' page_prefix='bulletin/operation'}

</form>
{include file="grn/footer.tpl"}

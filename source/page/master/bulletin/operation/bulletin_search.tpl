{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class='bulletin'}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="get" action="{grn_pageurl page=$page_info.all}">

{include file='bulletin/_article_search.tpl' page_prefix='bulletin/operation'}

</form>
{include file="grn/footer.tpl"}

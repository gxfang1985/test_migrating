{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='bulletin/command_draft_reuse'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{include file="bulletin/_send.tpl" form_name=$form_name cancel_page="bulletin/draft_view" submit_page='bulletin/command_draft_reuse'}
</form>
{include file="grn/footer.tpl"}

{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/command_draft_file_restore'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="aid" value="{$article_id}">
{include file="grn/file_restore.tpl" download_page="bulletin/draft_file_download" linkparams=$linkparams}
</form>
{include file="grn/footer.tpl"}

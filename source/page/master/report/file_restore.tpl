{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/command_file_restore'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="type" value="{$type}">
<input type="hidden" name="rid" value="{$report_id}">
<input type="hidden" name="follow_id" value="{$follow_id}">
{include file="grn/file_restore.tpl" download_page="report/file_download" linkparams=$linkparams}
</form>
{include file="grn/footer.tpl"}

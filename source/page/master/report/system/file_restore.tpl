{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{if ! $page_prefix}{assign var='page_prefix' value='report/system'}{/if}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page=$page_prefix|cat:'/command_file_restore'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="type" value="{$type}">
<input type="hidden" name="rid" value="{$report_id}">
<input type="hidden" name="follow_id" value="{$follow_id}">
{include file="grn/file_restore.tpl" download_page=$page_prefix|cat:"/file_download" linkparams=$linkparams}
</form>
{include file="grn/system_footer.tpl"}

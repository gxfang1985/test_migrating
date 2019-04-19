{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='space/command_file_restore'}">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="spid" value="{$space_id}">
<input type="hidden" name="tid"  value="{$thread_id}">
<input type="hidden" name="fid"  value="{$file_id}">
<input type="hidden" name="type" value="{$file_type}">
<input type="hidden" name="from" value="{$from}">
{include file="grn/file_restore.tpl" download_page="space/file_download" linkparams=$linkparams}
</form>
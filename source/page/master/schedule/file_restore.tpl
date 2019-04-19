{* GTM-1136 *}
{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/command_file_restore'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="event" value="{$event_id}">
{include file="grn/file_restore.tpl" download_page="schedule/file_download" linkparams=$linkparams}
</form>
{include file="grn/footer.tpl"}

{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class='cabinet'}
<form name="restore" method="post" action="{grn_pageurl page='cabinet/command_restore'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="hid" value="{$folder_id}">
{include file="grn/file_restore.tpl" download_page="cabinet/download" linkparams=$linkparams}
</form>
{include file="grn/footer.tpl"}

{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='message/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cid" value="{$cid}">
<input type="hidden" name="rid" value="{$rid}">
<input type="hidden" name="mid" value="{$mid}">
<input type="hidden" name="rfid" value="{$rfid}">
<input type="hidden" name="frm" value="{$frm}">
{include file="grn/file_lock.tpl" download_page="message/file_download" linkparams=$linkparams}
</form>
{include file='grn/footer.tpl'}

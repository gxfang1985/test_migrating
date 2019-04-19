{include file='grn/head.tpl'}
{include file='grn/header.tpl'}

{grn_title title=$page_title class=$page_info.parts[0]}
<form name="{$form_name}" method="post" enctype='multipart/form-data' action="{grn_pageurl page='message/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{include file='grn/file_upload.tpl' download_page='message/file_download' linkparams=$linkparams}
<input type="hidden" name="cid" value="{$cid}">
<input type="hidden" name="rid" value="{$rid}">
<input type="hidden" name="mid" value="{$mid}">
<input type="hidden" name="rfid" value="{$rfid}">
<input type='hidden' name='fn' value="{$form_name}">
<input type='hidden' name='frm' value="{$frm}">
</form>

{include file='grn/footer.tpl'}

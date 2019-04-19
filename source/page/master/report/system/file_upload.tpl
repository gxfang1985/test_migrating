{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
<form name="{$form_name}" method="post" enctype='multipart/form-data' action="{grn_pageurl page='report/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{include file='grn/file_upload.tpl' download_page='report/system/file_download' linkparams=$linkparams}
<input type="hidden" name="fid" value="{$fid}">
<input type="hidden" name="cid" value="{$cid}">
<input type="hidden" name="iid" value="{$iid}">
<input type="hidden" name="follow_id" value="{$follow_id}">
<input type="hidden" name="rid" value="{$rid}">
<input type='hidden' name='fn' value="{$form_name}">
<input type='hidden' name='frm' value="{$form_id}">
</form>
{include file='grn/system_footer.tpl'}

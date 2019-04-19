{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=''}

{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='memo/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<input type="hidden" name="iid" value="{$item_id}">
<input type="hidden" name="did" value="{$folder_id}">
<input type="hidden" name="fid" value="{$file_id}">
{include file="grn/file_upload.tpl" download_page="memo/attached_file_download" linkparams=$linkparams}
</form>
{include file="grn/footer.tpl"}

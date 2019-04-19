{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class='cabinet'}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='cabinet/command_upload'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="hid" value="{$folder_id}">
{include file="grn/file_upload.tpl" download_page="cabinet/download" linkparams=$linkparams}
{if $index_return}
<input type="hidden" name="index_return" value="index_return">
{/if}
</form>
{include file="grn/footer.tpl"}

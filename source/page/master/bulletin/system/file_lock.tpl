{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/system/command_file_lock'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{include file="grn/file_lock.tpl" download_page="bulletin/system/file_download" linkparams=$linkparams}
<input type="hidden" name="cid" value="{$category_id}">
<input type="hidden" name="aid" value="{$article_id}">
<input type="hidden" name="follow_id" value="{$follow_id}">
</form>
{include file="grn/system_footer.tpl"}

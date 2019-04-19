{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_file_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{include file="grn/file_delete.tpl"}
<input type="hidden" name="fid" value="{$file_id}">
<input type="hidden" name="cid" value="{$category_id}">
<input type="hidden" name="frm" value="{$form_id}">
<input type="hidden" name="rid" value="{$report_id}">
<input type="hidden" name="follow_id" value="{$follow_id}">
</form>
{include file="grn/system_footer.tpl"}

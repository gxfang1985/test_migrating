{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="fid" value="{$fid}">
<input type="hidden" name="cid" value="{$cid}">
<input type="hidden" name="iid" value="{$iid}">
<input type="hidden" name="follow_id" value="{$follow_id}">
<input type="hidden" name="rid" value="{$rid}">
{include file="grn/file_modify.tpl"}
</form>
{include file='grn/footer.tpl'}

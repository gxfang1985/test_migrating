{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='message/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{include file='grn/file_delete.tpl'}
<input type="hidden" name="mid" value="{$mid}">
<input type="hidden" name="rfid" value="{$rfid}">
<input type="hidden" name="frm" value="{$frm}">
</form>
{include file='grn/system_footer.tpl'}

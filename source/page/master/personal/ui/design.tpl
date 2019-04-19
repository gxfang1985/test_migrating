{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_load_javascript file="grn/html/design.js"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/ui/command_'|cat:$page_info.last} "><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{grn_design assign="design"}
{include file='grn/ui/_design.tpl'}
</form>
{include file='grn/personal_footer.tpl'}

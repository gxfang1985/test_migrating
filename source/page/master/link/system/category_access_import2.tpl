{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title|cat:' - Step 2/2' class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="charset" value="{$charset}">
<input type="hidden" name="skip" value="{$skip}">
<input type="hidden" name="file" value="{$file}">
 {include file='link/system/_category_access_import2.tpl' button_file='link/system/_category_access_import2_buttons.tpl'}
</form>
<hr>
<p>
{include file="link/system/_access_csv_columns.tpl"} 
{include file="grn/csv_columns.tpl"  column_explanation=$smarty.capture.explanation type="import"}

{include file="grn/system_footer.tpl"}

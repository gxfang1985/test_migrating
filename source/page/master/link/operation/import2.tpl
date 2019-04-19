{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title|cat:' - Step 2/2' class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="charset" value="{$charset}">
<input type="hidden" name="skip" value="{$skip}">
<input type="hidden" name="file" value="{$file}">
<input type="hidden" name="cid" value="{$category_id}">
 {include file='link/operation/_import2.tpl' button_file='link/operation/_import2_buttons.tpl'}
</form>
<hr>
<p>
{include file="link/operation/_link_csv_columns.tpl"} 
{include file="grn/csv_columns.tpl"  column_explanation=$smarty.capture.explanation type="import"}
{include file="grn/footer.tpl"}

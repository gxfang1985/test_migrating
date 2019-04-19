{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title|cat:' - Step 1/2' class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
{include file="grn/show_validation_errors.tpl"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/operation/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 {include file='link/operation/_import1.tpl' button_file='link/operation/_import1_buttons.tpl'}
<input type="hidden" name="cid" value="{$category_id|escape}">
</form>
<hr>
<p>
{include file="link/operation/_link_csv_columns.tpl"} 
{include file="grn/csv_columns.tpl"  column_explanation=$smarty.capture.explanation type="import"}
{include file="grn/footer.tpl"}

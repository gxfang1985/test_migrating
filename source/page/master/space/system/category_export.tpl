{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='space/system/command_category_export' postfix='category.csv'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{include file='space/system/_category_csv_columns.tpl'}
{include file='space/system/_export.tpl' column_explanation=$smarty.capture.explanation}

</form>
{include file="grn/system_footer.tpl"}

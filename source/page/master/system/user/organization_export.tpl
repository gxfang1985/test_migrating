{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_'|cat:$page_info.last postfix='ounit.csv'}">
{include file='system/user/_export.tpl'}
</form>

<hr>
<p>
{include file='system/user/_organization_csv_columns.tpl'}
{include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='export'}

{include file="grn/system_footer.tpl"}

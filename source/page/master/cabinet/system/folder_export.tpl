{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cabinet/system/command_folder_export' postfix='folder.csv'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{include file='cabinet/system/_folder_csv_columns.tpl'}
{include file='cabinet/system/_export.tpl' column_explanation=$smarty.capture.explanation}

</form>
{include file="grn/system_footer.tpl"}

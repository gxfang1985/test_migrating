{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class='bulletin'}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/system/command_access_export' postfix='bulletin_access.csv'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{include file='bulletin/system/_access_csv_columns.tpl'}
{include file='bulletin/system/_export.tpl' column_explanation=$smarty.capture.explanation}
</form>
{include file="grn/system_footer.tpl"}

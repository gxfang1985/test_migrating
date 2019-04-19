{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='bulletin/system/command_notify_export' postfix='bulletin_notify.csv'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{include file='bulletin/system/_notify_csv_columns.tpl'}
{include file='bulletin/system/_export.tpl' column_explanation=$smarty.capture.explanation}

</form>
{include file="grn/system_footer.tpl"}
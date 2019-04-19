{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class='cabinet'}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cabinet/system/command_notify_export' postfix='cabinet_notify.csv'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{include file='cabinet/system/_access_csv_columns.tpl'}
{include file='cabinet/system/_export.tpl' column_explanation=$smarty.capture.explanation}

</form>
{include file="grn/system_footer.tpl"}

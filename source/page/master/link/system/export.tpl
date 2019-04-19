{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class='bulletin'}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='link/system/command_'|cat:$page_info.last postfix=$file_name}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 {include file='link/system/_export.tpl' button_file='link/system/_export_buttons.tpl'}
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="file_name" value="{$file_name|escape}">
</form>
<hr>
<p>
{include file="link/system/_link_csv_columns.tpl"} 
{include file="grn/csv_columns.tpl"  column_explanation=$smarty.capture.explanation type="export"}
{include file="grn/system_footer.tpl"}

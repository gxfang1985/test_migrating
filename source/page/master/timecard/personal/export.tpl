{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='timecard/personal/command_'|cat:$page_info.last postfix='timecard.csv'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{include file='timecard/_export.tpl' cancel_page='personal/application_list' app_id='timecard'}

</form>

{include file='grn/personal_footer.tpl'}

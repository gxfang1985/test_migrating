{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name='{$form_name}' method='post' action='{grn_pageurl page="workflow/system/command_"|cat:$page_info.last postfix="workflow.csv"}'><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{include file='workflow/system/_petition_export.tpl'}
</form>

{include file='grn/system_footer.tpl'}

{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p><div class="explanation">{cb_msg module='grn.workflow.system' key='w_enter_category_information' replace='true'}</div></p>

{include file="grn/show_validation_errors.tpl"}
{include file='grn/indispensable.tpl'}

{include file='workflow/operation/_category.tpl' button_file='workflow/operation/_category_modify_buttons.tpl'}
<input type="hidden" name="pcid" value="{$pcid}">
</form>
{include file="grn/footer.tpl"}

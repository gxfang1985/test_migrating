{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.workflow.system' key='w_enter_category_information' replace='true'}</div>
<p>

{include file="grn/show_validation_errors.tpl"}
{include file='grn/indispensable.tpl'}

{include file='workflow/system/_category.tpl' button_file='workflow/system/_category_add_buttons.tpl'}
</form>
{include file='grn/system_footer.tpl'}

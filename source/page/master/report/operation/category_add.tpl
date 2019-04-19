{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-299' replace='true'}</div>
<p>

{include file="grn/show_validation_errors.tpl"}
{include file='grn/indispensable.tpl'}

{include file='report/operation/_category.tpl' button_file='report/operation/_category_add_buttons.tpl'}
</form>
{include file='grn/footer.tpl'}

{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='report/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p><div class="explanation">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-365' replace='true'}</div></p>

{include file="grn/show_validation_errors.tpl"}
{include file='grn/indispensable.tpl'}

{include file='report/system/_category.tpl' button_file='report/system/_category_modify_buttons.tpl'}
<input type="hidden" name="pcid" value="{$pcid}">
</form>
{include file="grn/system_footer.tpl"}

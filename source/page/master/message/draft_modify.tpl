{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<p>{cb_msg module='grn.message' key='GRN_MSG-2' replace='true'}</p>

{assign var="form_name" value=$smarty.template|basename}
{include file='grn/show_validation_errors.tpl'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='message/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{include file="message/_send.tpl" button_file="message/_draft_modify_buttons.tpl"}
<input type='hidden' name='fn' value="{$form_name}">
</form>
{include file='grn/footer.tpl'}

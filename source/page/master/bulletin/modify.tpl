{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='bulletin/command_modify'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="tmp_key" value="{$tmp_key}">
{include file="bulletin/_send.tpl" form_name=$form_name cancel_page="bulletin/view" modify_form=1 notify_check=1 submit_page='bulletin/command_modify'}
</form>
{include file="grn/footer.tpl"}

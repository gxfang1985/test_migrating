{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='space/application/discussion/command_add'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="tmp_key" value="{$tmp_key}">
{include file="space/application/discussion/_send.tpl" form_name=$form_name cancel_page="space/application/discussion/index"}
</form>
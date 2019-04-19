{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='space/mobile/application/todo/command_modify'}" data-ajax="false">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type='hidden' name='spid' value="{$space_id}">
<input type='hidden' name='tdid' value="{$todo_id}">
{include file="space/mobile/application/todo/_send.tpl" form_name=$form_name modify_form=1}
</form>

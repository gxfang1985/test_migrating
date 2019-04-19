{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" enctype="multipart/form-data" action="{grn_pageurl page='space/mobile/application/todo/command_add'}" data-ajax="false">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type='hidden' name='spid' value="{$space_id}">
<input type='hidden' name='tid' value="{$thread_id}">
<input type='hidden' name='from' value="{$from}" id="from">
{include file="space/mobile/application/todo/_send.tpl" form_name=$form_name}
</form>

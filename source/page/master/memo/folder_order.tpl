{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=''}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='memo/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
{include file="memo/_folder_order.tpl" form_name=$form_name}
</form>
{include file='grn/footer.tpl'}

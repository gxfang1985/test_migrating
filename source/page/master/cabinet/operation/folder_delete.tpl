{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class='cabinet'}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cabinet/operation/command_folder_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{include file='cabinet/_folder_delete.tpl'}

</form>
{include file="grn/footer.tpl"}

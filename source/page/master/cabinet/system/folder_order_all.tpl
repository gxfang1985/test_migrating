{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class='cabinet'}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='cabinet/system/command_folder_order_all'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

{include file="cabinet/_folder_order.tpl" form_name=$form_name}

</form>
{include file="grn/system_footer.tpl"}

{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<p></p>
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    {include file='grn/member_modify_order.tpl' name='default_public_order' form_name=$form_name list_name='order' selected_item_options=$default_public_list buttons_file='schedule/personal/_default_public_order_buttons.tpl'}
</form>
{include file='grn/personal_footer.tpl'}

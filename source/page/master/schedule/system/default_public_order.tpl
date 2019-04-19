{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<p></p>
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    {include file='grn/member_modify_order.tpl' form_name=$form_name list_name='order' selected_item_options=$default_public_list buttons_file='schedule/system/_default_public_order_buttons.tpl'}

    {foreach from=$ous_params key=key item=item}
        <input type="hidden" name="{$key|escape}" value="{$item|escape}">
    {/foreach}
</form>
{include file='grn/system_footer.tpl'}

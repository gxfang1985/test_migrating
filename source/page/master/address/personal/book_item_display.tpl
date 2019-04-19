{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{assign var='form_name' value=$smarty.template|basename}
{capture name='grn_address_personal_GRN_ADDR_PS_4'}{cb_msg module='grn.address.personal' key='GRN_ADDR_PS-4' replace='true'}{/capture}{grn_title title=$smarty.capture.grn_address_personal_GRN_ADDR_PS_4 class=$page_info.parts[0]}


<form name="{$form_name}" method="post" action="{grn_pageurl page='address/personal/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.address.personal' key='GRN_ADDR_PS-5' replace='true'}</div>
<span class="bold">{if $book.oid == -1}{cb_msg module='grn.address.personal' key='GRN_ADDR_PS-6' replace='true'}{$resources.application_name|escape}{else}{$book.display_name|escape}{/if}</span>
     <p>
     <!--builtin_items-->
{foreach from=$builtin_items key=item_id item=item}
    {if $item_id == 'subject'}
     <div class="word">
        {grn_image image='check16.gif'}&nbsp;{$item.display_name}
     </div>
    {elseif $item_id != 'route_time' && $item_id != 'route_fare' && $item_id != 'route_detail'}
        {if $item.use}
     <div class="word">
        {grn_checkbox name="display_flags[$item_id]" id="$item_id" value=1 checked=$item.display caption=$item.display_name}
     </div>
        {/if}
    {/if}
{/foreach}
     <!--builtin_items_end-->
     <!--extended_items-->
{foreach from=$extended_items key=item_id item=item}
 {if $item.use}
     <div class="word">{grn_checkbox name="display_flags[$item_id]" id="$item_id" value=1 checked=$item.display caption=$item.display_name}</div>
 {/if}
{/foreach}
     <!--extended_items_end-->
      {capture name='grn_address_personal_GRN_ADDR_PS_7'}{cb_msg module='grn.address.personal' key='GRN_ADDR_PS-7' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_personal_GRN_ADDR_PS_7}
      {grn_button_cancel}

<input type="hidden" name="bid" value="{$book.oid}">
</form>

{include file='grn/personal_footer.tpl'}

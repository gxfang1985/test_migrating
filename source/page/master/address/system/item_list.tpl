{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
<form name="{$form_name}" method="post" action="{grn_pageurl page='address/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_address_system_GRN_ADDR_SYS_253'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-253' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_253 page='address/system/item_add' bid=$book_id image='write20.gif'}</span>
<span class="menu_item">{capture name='grn_address_system_GRN_ADDR_SYS_254'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-254' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_254 page='address/system/item_order' bid=$book_id image='order20.gif'}</span>
</div>

  <p>
  <div class="explanation">{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-255' replace='true'}</div>

  <p>
  <div class="sub_title">{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-256' replace='true'}</div>
  <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
   <colgroup>
    <col width="25%">
    <col width="35%">
    <col width="10%">
    <col width="10%">
    <col width="10%">
    <col width="10%">
   </colgroup>
   <tr>
    <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-257' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-258' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-259' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-260' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-261' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-262' replace='true'}</th>
   </tr>
{foreach from=$builtin_items key=item_id item=item}
    {if $item_id != 'route_time' && $item_id != 'route_fare' && $item_id != 'route_detail'}
        {if $item_id == 'subject'}
            {assign var='disabled' value=true}
        {else}
            {assign var='disabled' value=false}
        {/if}
   <tr valign="top">
    <td nowrap>{grn_link caption=$item.display_name page='address/system/item_view' bid=$book_id biid=$item_id image='detail20.gif'}</td>
    <td nowrap>{$item_id|escape}</td>
    <td align="center" nowrap>{if $disabled}{grn_image image='check16.gif'}{else}{grn_checkbox name="builtin_items[$item_id][use]" id="use_$item_id" value=1 checked=$item.use}{/if}</td>
    <td align="center" nowrap>{if $disabled}{grn_image image='check16.gif'}{else}{grn_checkbox name="builtin_items[$item_id][display]" id="display_$item_id" value=1 checked=$item.display}{/if}</td>
    <td align="center" nowrap>{if $disabled}{grn_image image='check16.gif'}{else}{grn_checkbox name="builtin_items[$item_id][necessary]" id="necessary_$item_id" value=1 checked=$item.necessary}{/if}</td>
    <td align="center" nowrap>{if ! $disabled}{grn_checkbox name="builtin_items[$item_id][not_modify]" id="not_modify_$item_id" value=1 checked=$item.not_modify}{/if}</td>
   </tr>
    {/if}
{/foreach}
  </table>
  
  <p>
  <div class="sub_title">{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-263' replace='true'}</div>
  <table class="list_column">
   <colgroup>
    <col width="25%">
    <col width="35%">
    <col width="10%">
    <col width="10%">
    <col width="10%">
    <col width="10%">
   </colgroup>
   <tr>
    <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-264' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-265' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-266' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-267' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-268' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-269' replace='true'}</th>
   </tr>
{foreach from=$extended_items key=item_id item=item}
   <tr>
    <td nowrap>{grn_link caption=$item.display_name page='address/system/item_view' bid=$book_id eiid=$item_id image='detail20.gif'}</td>
    <td nowrap>{$item.id|escape}</td>
    <td align="center" nowrap>{grn_checkbox name="extended_items[$item_id][use]" id="use_$item_id" value=1 checked=$item.use}</td>
    <td align="center" nowrap>{grn_checkbox name="extended_items[$item_id][display]" id="display_$item_id" value=1 checked=$item.display}</td>
    <td align="center" nowrap>{grn_checkbox name="extended_items[$item_id][necessary]" id="necessary_$item_id" value=1 checked=$item.necessary}</td>
    <td align="center" nowrap>{grn_checkbox name="extended_items[$item_id][not_modify]" id="not_modify_$item_id" value=1 checked=$item.not_modify}</td>
   </tr>
{/foreach}
  </table>

    <input class="margin" type="submit" value="{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-270' replace='true'}">
    {grn_button_cancel page='address/system/item_index'}

<input type="hidden" name="bid" value="{$book_id}">
</form>

{include file='grn/system_footer.tpl'}

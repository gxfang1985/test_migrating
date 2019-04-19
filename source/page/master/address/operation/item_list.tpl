{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
<form name="{$form_name}" method="post" action="{grn_pageurl page='address/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_address_operation_GRN_ADDR_OP_112'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-112' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_112 page='address/operation/item_add' bid=$book_id image='write20.gif'}</span>
<span class="menu_item">{capture name='grn_address_operation_GRN_ADDR_OP_113'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-113' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_113 page='address/operation/item_order' bid=$book_id image='order20.gif'}</span>
</div>

  <div class="margin_vert">
  <p><div class="explanation">{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-114' replace='true'}</div></p>
  </div>
  
  <div class="sub_title">{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-115' replace='true'}</div>
  <table class="admin_list_table" width="100%">
   <colgroup>
    <col width="25%">
    <col width="35%">
    <col width="10%">
    <col width="10%">
    <col width="10%">
    <col width="10%">
   </colgroup>
   <tr>
    <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-116' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-117' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-118' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-119' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-120' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-121' replace='true'}</th>
   </tr>
{foreach from=$builtin_items key=item_id item=item}
    {if $item_id != 'route_time' && $item_id != 'route_fare' && $item_id != 'route_detail'}
        {if $item_id == 'subject'}
            {assign var='disabled' value=true}
        {else}
            {assign var='disabled' value=false}
        {/if}
   <tr valign="top">
    <td nowrap>{grn_link image='detail20.gif' caption=$item.display_name page='address/operation/item_view' bid=$book_id biid=$item_id}</td>
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
  <div class="sub_title">{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-122' replace='true'}</div>
  <table class="admin_list_table">
   <colgroup>
    <col width="25%">
    <col width="35%">
    <col width="10%">
    <col width="10%">
    <col width="10%">
    <col width="10%">
   </colgroup>
   <tr>
    <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-123' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-124' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-125' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-126' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-127' replace='true'}</th>
    <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-128' replace='true'}</th>
   </tr>
{foreach from=$extended_items key=item_id item=item}
   <tr>
    <td nowrap>{grn_link image='detail20.gif' caption=$item.display_name page='address/operation/item_view' bid=$book_id eiid=$item_id}</td>
    <td nowrap>{$item.id|escape}</td>
    <td align="center" nowrap>{grn_checkbox name="extended_items[$item_id][use]" id="use_$item_id" value=1 checked=$item.use}</td>
    <td align="center" nowrap>{grn_checkbox name="extended_items[$item_id][display]" id="display_$item_id" value=1 checked=$item.display}</td>
    <td align="center" nowrap>{grn_checkbox name="extended_items[$item_id][necessary]" id="necessary_$item_id" value=1 checked=$item.necessary}</td>
    <td align="center" nowrap>{grn_checkbox name="extended_items[$item_id][not_modify]" id="not_modify_$item_id" value=1 checked=$item.not_modify}</td>
   </tr>
{/foreach}
  </table>

    {capture name='grn_address_operation_GRN_ADDR_OP_129'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-129' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_129}
    {grn_button_cancel page='address/index'}

<input type="hidden" name="bid" value="{$book_id}">
</form>

{include file='grn/footer.tpl'}

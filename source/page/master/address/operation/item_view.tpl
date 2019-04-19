{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{if $item.id == 'subject'}
 {assign var='enable' value=false}
{else}
 {assign var='enable' value=true}
{/if}

{if $enable}
<div id="main_menu_part">
 {if $access.modify}
  {if $builtin_item_id}
<span class="menu_item">{capture name='grn_address_operation_GRN_ADDR_OP_55'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-55' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_55 page='address/operation/item_modify' image='modify20.gif' bid=$book_id biid=$builtin_item_id}</span>
  {elseif $extended_item_id}
<span class="menu_item">{capture name='grn_address_operation_GRN_ADDR_OP_56'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-56' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_56 page='address/operation/item_modify' image='modify20.gif' bid=$book_id eiid=$extended_item_id}</span>
  {/if}
 {/if}
 {if $access.delete}
<span class="menu_item">{capture name='grn_address_operation_GRN_ADDR_OP_57'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-57' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_57 page='address/operation/item_delete' image='delete20.gif' bid=$book_id eiid=$extended_item_id}</span>
 {/if}
</div>
{/if}

<p>
<table class="view_table">
 <tr>
  <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-58' replace='true'}</th>
  <td>{$item.display_name|escape}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-59' replace='true'}</th>
     {assign var='item_type' value=$item.type}
  <td>{$item_type_options.$item_type.label|escape}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-60' replace='true'}</th>
  <td>{$item.id|escape}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-61' replace='true'}</th>
  <td>{if $item.use}{capture name='grn_address_operation_GRN_ADDR_OP_62'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-62' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_62 image='check20.gif'}{else}{capture name='grn_address_operation_GRN_ADDR_OP_63'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-63' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_63 image='spacer20.gif'}{/if}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-64' replace='true'}</th>
  <td>{if $item.display}{capture name='grn_address_operation_GRN_ADDR_OP_65'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-65' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_65 image='check20.gif'}{else}{capture name='grn_address_operation_GRN_ADDR_OP_66'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-66' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_66 image='spacer20.gif'}{/if}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-67' replace='true'}</th>
  <td>{if $item.necessary}{capture name='grn_address_operation_GRN_ADDR_OP_68'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-68' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_68 image='check20.gif'}{else}{capture name='grn_address_operation_GRN_ADDR_OP_69'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-69' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_69 image='spacer20.gif'}{/if}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-70' replace='true'}</th>
  <td>{if $item.not_modify}{capture name='grn_address_operation_GRN_ADDR_OP_71'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-71' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_71 image='check20.gif'}{else}{capture name='grn_address_operation_GRN_ADDR_OP_72'}{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-72' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_address_operation_GRN_ADDR_OP_72 image='spacer20.gif'}{/if}</td>
 </tr>
 {if $smarty.const.ON_FOREST != 1}
 <tr>
  <th nowrap>{cb_msg module='grn.address.operation' key='GRN_ADDR_OP-73' replace='true'}</th>
  <td>{assign var='sso' value=$item.sso}{if $sso}{$sso_options.$sso.label|escape}{else}{cb_msg module="grn.address" key="default_sso"}{/if}</td>
 </tr>
 {/if}
</table>

{include file='grn/footer.tpl'}

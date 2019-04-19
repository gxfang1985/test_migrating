{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{if $item.id == 'subject'}
 {assign var='enable' value=false}
{else}
 {assign var='enable' value=true}
{/if}

{if $enable}
<div id="main_menu_part">
<span class="menu_item">{if $access.modify}{if $builtin_item_id}{capture name='grn_address_system_GRN_ADDR_SYS_132'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-132' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_132 page='address/system/item_modify' image='modify20.gif' bid=$book_id biid=$builtin_item_id}{elseif $extended_item_id}{capture name='grn_address_system_GRN_ADDR_SYS_133'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-133' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_133 page='address/system/item_modify' image='modify20.gif' bid=$book_id eiid=$extended_item_id}{/if}{/if}</span>
<span class="menu_item">{if $access.delete}{capture name='grn_address_system_GRN_ADDR_SYS_134'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-134' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_134 page='address/system/item_delete' image='delete20.gif' bid=$book_id eiid=$extended_item_id}{/if}</span>
</div>
{/if}

<p>
<table class="view_table">
 <tr id="display_name">
  <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-135' replace='true'}</th>
  <td>{$item.display_name|escape}</td>
 </tr>
 <tr id="item_type">
  <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-136' replace='true'}</th>
     {assign var='item_type' value=$item.type}
  <td>{$item_type_options.$item_type.label|escape}</td>
 </tr>
 <tr id="id">
  <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-137' replace='true'}</th>
  <td>{$item.id|escape}</td>
 </tr>
 <tr id="use">
  <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-138' replace='true'}</th>
  <td>{if $item.use}{capture name='grn_address_system_GRN_ADDR_SYS_139'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-139' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_139 image='check20.gif'}{else}{capture name='grn_address_system_GRN_ADDR_SYS_140'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-140' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_140 image='spacer20.gif'}{/if}</td>
 </tr>
 <tr id="display">
  <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-141' replace='true'}</th>
  <td>{if $item.display}{capture name='grn_address_system_GRN_ADDR_SYS_142'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-142' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_142 image='check20.gif'}{else}{capture name='grn_address_system_GRN_ADDR_SYS_143'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-143' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_143 image='spacer20.gif'}{/if}</td>
 </tr>
 <tr id="necessary">
  <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-144' replace='true'}</th>
  <td>{if $item.necessary}{capture name='grn_address_system_GRN_ADDR_SYS_145'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-145' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_145 image='check20.gif'}{else}{capture name='grn_address_system_GRN_ADDR_SYS_146'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-146' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_146 image='spacer20.gif'}{/if}</td>
 </tr>
 <tr id="not_modify">
  <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-147' replace='true'}</th>
  <td>{if $item.not_modify}{capture name='grn_address_system_GRN_ADDR_SYS_148'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-148' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_148 image='check20.gif'}{else}{capture name='grn_address_system_GRN_ADDR_SYS_149'}{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-149' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_address_system_GRN_ADDR_SYS_149 image='spacer20.gif'}{/if}</td>
 </tr>
 {if $smarty.const.ON_FOREST !== 1 }
 <tr id="sso">
  <th nowrap>{cb_msg module='grn.address.system' key='GRN_ADDR_SYS-150' replace='true'}</th>  
  <td>{assign var='sso' value=$item.sso}{if $sso}{$sso_options.$sso.label|escape}{else}{cb_msg module="grn.address" key="default_sso"}{/if}</td> 
 </tr>
 {/if}
</table>

{include file='grn/system_footer.tpl'}

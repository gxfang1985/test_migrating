{if ! $with_explanation}
<div id="one_parts">
 <!--action-->
 <div id="action">
  <div class="explanation">{cb_msg module='grn.address.personal' key='GRN_ADDR_PS-8' replace='true'}</div>
{/if}
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.address.personal' key='GRN_ADDR_PS-9' replace='true'}</th>
  <td><span class="bold"><span class="bold">{cb_msg module='grn.address.personal' key='GRN_ADDR_PS-10' replace='true'}</span></span></td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.address.personal' key='GRN_ADDR_PS-11' replace='true'}</th>
  <td>

     <p>
     <!--builtin_items-->
{foreach from=$builtin_items key=item_id item=item}
 {if $item_id == 'display_name'}
     <div class="tree_item">{grn_image image='check16.gif'}&nbsp;{$item.display_name}</div>
 {else}
  {if $item.use && $item.show}
     <div class="tree_item">{grn_checkbox name="display_flags[$item_id]" id="$item_id" value=1 checked=$item.display caption=$item.display_name}</div>
  {/if}
 {/if}
{/foreach}
     <!--builtin_items_end-->
     <!--extended_items-->
{foreach from=$extended_items key=item_id item=item}
 {if $item.use && $item.show}
     <div class="tree_item">{grn_checkbox name="display_flags[$item_id]" id="$item_id" value=1 checked=$item.display caption=$item.display_name}</div>
 {/if}
{/foreach}
     <!--extended_items_end-->
  </td>
  </tr>
</table>  

{if ! $with_explanation}
      {capture name='grn_address_personal_GRN_ADDR_PS_12'}{cb_msg module='grn.address.personal' key='GRN_ADDR_PS-12' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_address_personal_GRN_ADDR_PS_12}
      {grn_button_cancel}
 </div>
 <!--action_end-->
</div>
{/if}

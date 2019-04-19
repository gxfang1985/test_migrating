{if $display == 'input' || $display == 'input-system' || $display == 'input-operation'}
  <td nowrap class="{$item_class}">
 {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
 {capture name='checkbox'}item_{$item.iid}{/capture}
 {capture name='checkbox_id'}checkbox_{$item.iid}{/capture}
 {grn_checkbox name=$smarty.capture.checkbox id=$smarty.capture.checkbox_id value='1' caption='' checked=$item.number}
 {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
  </td>
{else}
  <td class="{$item_class}">
 {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
 {if $item.number == 1}
  {grn_image image='check20.gif'}
 {/if}
 {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
  </td>
{/if}

{if $display == 'input' || $display == 'input-system' || $display == 'input-operation'}
  <td nowrap class="{$item_class}">
 {if $settings.not_display != 1}
  <span id="item_{$item.iid}" class="no-wrap">
  {if $item.br != 1}&nbsp;{$item.separator|escape}&nbsp;{/if}
  {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
   <font color="blue">{cb_msg module='grn.workflow' key='key_25_1' replace='true'}</font>
   <input type="hidden" name="item_{$item.iid}" value="">
  {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
  </span>
 {/if}
  </td>
{else}
 {if $settings.right_align == 1}
  <td style="text-align:right;" class="{$item_class}">
 {else}
  <td class="{$item_class}">
 {/if}
 {if $settings.not_display != 1}
  <span id="item_{$item.iid}" class="no-wrap js_customization_input_item_{$item.code}" data-calc={$item.number_for_js|escape}>
  {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
  {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
  {$item.number|escape}
  {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
  </span>
 {/if}
  </td>
{/if}

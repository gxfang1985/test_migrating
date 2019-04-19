{if $display == 'input' || $display == 'input-system' || $display == 'input-operation'}
  <td nowrap class="{$item_class}">
 {if $item.br != 1}&nbsp;{$item.separator|escape}&nbsp;{/if}
 {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
 {capture name='menu_string'}item_{$item.iid}{/capture}
 {if $item.required == 1}
  {capture name=validate_require}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='is_required_field_2' replace='true'}{/capture}
  {validate form=$form_name field=$smarty.capture.menu_string criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require append="validation_errors"}
 {/if}
  {grn_select name=$smarty.capture.menu_string size='1' options=$menu_options class="js_customization_input_item_`$item.code`"}
 {if $item.required == 1}
  <span class="attention">*</span>
 {/if}
 {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
  </td>
{else}
  <td class="{$item_class}">
 {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
 {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
 {$item.text|escape}
 {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
  </td>
{/if}
{if $display == 'input' || $display == 'input-system' || $display == 'input-operation'}
  <td nowrap class="{$item_class}">
 {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
 {capture name='numeric'}item_{$item.iid}{/capture}
 {if $item.required == 1}
  {capture name=validate_require}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-436' replace='true'}{/capture}
  {validate form=$form_name field=$smarty.capture.numeric criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require append="validation_errors"}
 {/if}
 {capture name=validate_numeric}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-437' replace='true'}{/capture}
 {validate form=$form_name field=$smarty.capture.numeric criteria="grn_report_isNumber" message=$smarty.capture.validate_numeric append="validation_errors" empty=true}
 {if $settings.input_numbers == 1}
  {if $settings.max_input_number !=''}
   {capture name="validate_max"}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-438' replace='true'}{/capture}
   {validate form=$form_name field=$smarty.capture.numeric criteria="grn_report_isRangeMax" max=$settings.max_input_number scale=$settings.effective_figures message=$smarty.capture.validate_max append="validation_errors" empty=true}
  {/if} 
  {if $settings.min_input_number !=''}
   {capture name="validate_min"}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-439' replace='true'}{/capture}
   {validate form=$form_name field=$smarty.capture.numeric criteria="grn_report_isRangeMin" min=$settings.min_input_number scale=$settings.effective_figures message=$smarty.capture.validate_min append="validation_errors" empty=true}
  {/if}
 {/if}
 {grn_text name=$smarty.capture.numeric size=$settings.size maxlength=$setting.max_input_size value=$item.number}
  <font color="#0000ff">#</font>
 {if $item.required == 1}
  <span class="attention">*</span>
 {/if}
 {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
  </td>
{else}
 {if $settings.right_align == 1}
  <td style="text-align:right;" class="{$item_class}">
 {else}
  <td class="{$item_class}">
 {/if}
  <span class="no-wrap">
 {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
 {$item.number|escape}
 {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
  </span>
  </td>
{/if}
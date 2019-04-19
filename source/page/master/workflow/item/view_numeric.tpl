{capture name='numeric'}item_{$item.iid}{/capture}
{if $display == 'input' || $display == 'input-system' || $display == 'input-operation'}
  {if $item.attach_file_view == 0}
    <td class="{$item_class}" nowrap><span style="color:blue">{cb_msg module='grn.workflow' key='key_51_1' replace='true'}</span></td>
      <input type="hidden" name="{$smarty.capture.numeric|grn_noescape}" value="{$item.number|escape}">
  {elseif $item.attach_file_view == 1 && $item.attach_file == 0}
    <td class="{$item_class}">
    {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
    {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
    {$item.number|escape}
    {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
    </td>
  <input type="hidden" name="{$smarty.capture.numeric|grn_noescape}" value="{$item.number|escape}">
  {else}
    <td nowrap class="{$item_class}">
      {if $item.br != 1}&nbsp;{$item.separator|escape}&nbsp;{/if}
      {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
      {if $item.required == 1}
        {capture name=validate_require}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='is_required_field_2' replace='true'}{/capture}
        {validate form=$form_name field=$smarty.capture.numeric criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require append="validation_errors"}
      {/if}
      {capture name=validate_numeric}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='is_numeral' replace='true'}{/capture}
      {validate form=$form_name field=$smarty.capture.numeric criteria="grn_workflow_isNumber" message=$smarty.capture.validate_numeric append="validation_errors" empty=true}
      {if $settings.input_numbers == 1}
        {if $settings.max_input_number !=''}
          {capture name="validate_max"}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='is_exceeding_maximum' replace='true'}{/capture}
          {validate form=$form_name field=$smarty.capture.numeric criteria="grn_workflow_isRangeMax" max=$settings.max_input_number scale=$settings.effective_figures message=$smarty.capture.validate_max append="validation_errors" empty=true}
        {/if}
        {if $settings.min_input_number !=''}
          {capture name="validate_min"}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='is_underrunning_minimum' replace='true'}{/capture}
          {validate form=$form_name field=$smarty.capture.numeric criteria="grn_workflow_isRangeMin" min=$settings.min_input_number scale=$settings.effective_figures message=$smarty.capture.validate_min append="validation_errors" empty=true}
        {/if}
      {/if}
      {grn_text id=$item.iid name=$smarty.capture.numeric size=$settings.size maxlength=$settings.max_input_size value=$item.number class="js_customization_input_item_`$item.code`"}
      <span style="color:#0000ff">#</span>
      {if $item.required == 1}
        <span class="attention">*</span>
      {/if}
      {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
    </td>
  {/if}
{elseif $display == 'view-confirm'}
  {if $item.attach_file_view == 0 && $item.type != 1}
    {if $settings.right_align == 1}
      <td style="text-align:right;" class="{$item_class}" nowrap>
    {else}
      <td class="{$item_class}" nowrap>
    {/if}
      <span style="color:blue">&nbsp;</span></td>
  {else}
    {if $settings.right_align == 1}
      <td style="text-align:right;" class="{$item_class}">
    {else}
      <td class="{$item_class}">
    {/if}
        {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {$item.number|escape}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
      </td>
  {/if}
{elseif $item.view_mode}
  {if $item.view_mode == 'view'}
    {if $settings.right_align == 1}
      <td style="text-align:right;" class="{$item_class}">
    {else}
      <td class="{$item_class}">
    {/if}
        {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {$item.number|escape}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
      </td>
  {elseif $item.view_mode == 'edit'}
    {if $settings.right_align == 1}
      <td nowrap style="text-align:right;" class="{$item_class}">
        {else}
      <td nowrap class="{$item_class}">
    {/if}
      {if $item.br != 1}&nbsp;{$item.separator|escape}&nbsp;{/if}
      {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
      {if $item.required == 1}
        {capture name=validate_require}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='is_required_field_2' replace='true'}{/capture}
        {validate form=$form_name field=$smarty.capture.numeric criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require append="validation_errors"}
      {/if}
      {capture name=validate_numeric}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='is_numeral' replace='true'}{/capture}
      {validate form=$form_name field=$smarty.capture.numeric criteria="grn_workflow_isNumber" message=$smarty.capture.validate_numeric append="validation_errors" empty=true}
      {if $settings.input_numbers == 1}
        {if $settings.max_input_number !=''}
            {capture name="validate_max"}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='is_exceeding_maximum' replace='true'}{/capture}
            {validate form=$form_name field=$smarty.capture.numeric criteria="grn_workflow_isRangeMax" max=$settings.max_input_number scale=$settings.effective_figures message=$smarty.capture.validate_max append="validation_errors" empty=true}
        {/if}
        {if $settings.min_input_number !=''}
            {capture name="validate_min"}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='is_underrunning_minimum' replace='true'}{/capture}
            {validate form=$form_name field=$smarty.capture.numeric criteria="grn_workflow_isRangeMin" min=$settings.min_input_number scale=$settings.effective_figures message=$smarty.capture.validate_min append="validation_errors" empty=true}
        {/if}
      {/if}
      {grn_text name=$smarty.capture.numeric size=$settings.size maxlength=$settings.max_input_size value=$item.number class="number_type js_customization_input_item_`$item.code`"}
      <span style="color:#0000ff">#</span>
      {if $item.required == 1}
        <span class="attention">*</span>
      {/if}
      {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
    </td>
  {elseif $item.view_mode == 'disable'}
    {if $settings.right_align == 1}
      <td nowrap style="text-align:right;" class="{$item_class}">&nbsp;</td>
    {else}
      <td class="{$item_class}" nowrap>&nbsp;</td>
    {/if}
  {/if}
{elseif $item.view_mode_print}
  {if $settings.right_align == 1}
    <td style="text-align:right;" class="{$item_class}">
  {else}
    <td class="{$item_class}">
  {/if}
      {if $item.view_mode_print == 'disable'}
        &nbsp;
      {else}
        {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {$item.number|escape}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
      {/if}
    </td>
{else}
  {if $settings.right_align == 1}
    <td style="text-align:right;" class="{$item_class}">
      {else}
    <td class="{$item_class}">
  {/if}
      {if $item.attach_file_view == 0 && $item.type != 1}
        &nbsp;
      {else}
        {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {$item.number|escape}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
      {/if}
    </td>
{/if}
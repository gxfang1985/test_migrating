{if $display == 'input' || $display == 'input-system' || $display == 'input-operation'}
  <td nowrap class="{$item_class}">
 {if $item.br != 1}&nbsp;{$item.separator|escape}&nbsp;{/if}
 {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
 {capture name='checkbox'}item_{$item.iid}{/capture}
 {capture name='checkbox_id'}checkbox_{$item.iid}{/capture}
 {grn_checkbox name=$smarty.capture.checkbox id=$smarty.capture.checkbox_id value='1' caption='' checked=$item.number class="js_customization_input_item_`$item.code`"}
 {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
  </td>
{else}
  {strip}
  {capture name='grn_workflow_checkbox_checked'}{cb_msg module='grn.workflow' key='checkbox_checked' replace='true'}{/capture}
  {capture name='grn_workflow_checkbox_not_checked'}{cb_msg module='grn.workflow' key='checkbox_not_checked' replace='true'}{/capture}
  <td class="{$item_class}">
  {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
  {if $item.option_string_type == 1}
    {if $item.number == 1}
      {if $is_mobile}
        <span>{$item.option_string|escape}</span>
        <span class="mobile-checkIcon-grn" aria-label="{$smarty.capture.grn_workflow_checkbox_checked}"></span>
      {else}
        <span class="inline_block_grn mRight10">
          {$item.option_string|escape}
          {grn_image image='check20.gif' border="0" alt=$smarty.capture.grn_workflow_checkbox_checked}
        </span>
      {/if}
    {else}
      {if $is_mobile}
        <span class="mobile_text_color_sub2_grn">{$item.option_string|escape}</span>
        <span class="mobile_checkicon_blank_grn" aria-label="{$smarty.capture.grn_workflow_checkbox_not_checked}"></span>
      {else}
        <span class="inline_block_grn mRight10 text_color_sub2_grn">
          {$item.option_string|escape}
          {grn_image image='spacer1.gif' border="0" alt=$smarty.capture.grn_workflow_checkbox_not_checked width="0px" height="20px"}
        </span>
      {/if}
    {/if}
  {elseif $item.option_string_type == 2}
    {if $item.number == 1}
      {if $is_mobile}
        <span class="mobile-checkIcon-grn" aria-label="{$smarty.capture.grn_workflow_checkbox_checked}"></span>
        <span>{$item.option_string|escape}</span>
      {else}
        <span class="inline_block_grn mRight10">
          {grn_image image='check20.gif' border="0" alt=$smarty.capture.grn_workflow_checkbox_checked}
          {$item.option_string|escape}
        </span>
      {/if}
    {else}
      {if $is_mobile}
        <span class="mobile_checkicon_blank_grn" aria-label="{$smarty.capture.grn_workflow_checkbox_not_checked}"></span>
        <span class="mobile_text_color_sub2_grn">{$item.option_string|escape}</span>
      {else}
        <span class="inline_block_grn mRight10 text_color_sub2_grn">
          {grn_image image='spacer1.gif' border="0" alt=$smarty.capture.grn_workflow_checkbox_not_checked width="0px" height="20px"}
          {$item.option_string|escape}
        </span>
      {/if}
    {/if}
  {elseif $item.number == 1}
    {if $is_mobile}
      <span class="mobile-checkIcon-grn" aria-label="{$smarty.capture.grn_workflow_checkbox_checked}"></span>
    {else}
      <span class="inline_block_grn mRight10">
        {grn_image image='check20.gif' border="0" alt=$smarty.capture.grn_workflow_checkbox_checked}
      </span>
    {/if}
  {/if}
  </td>
  {/strip}
{/if}


{capture name='string_multiple'}item_{$item.iid}{/capture}
{capture name='string_multiple_editor'}editor_{$smarty.capture.string_multiple}{/capture}
{if $display == 'input' || $display == 'input-system' || $display == 'input-operation'}
        <td nowrap class="{$item_class}">
          {literal}
          <style type="text/css">
          <!-- 
          .string_multiple_table TD
          {
            vertical-align:bottom;
            padding:0px;
          }
          -->
          </style>
          {/literal}
          <table class="string_multiple_table"><tr>
        {if $item.option_string_type == 1}<td class>{$item.option_string|escape}</td>{/if}
            {capture name='string_multiple'}item_{$item.iid}{/capture}
            {if $item.required == 1}
              <td>
                {capture name=validate_require}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-262' replace='true'}{/capture}
                {validate form=$form_name field=$smarty.capture.string_multiple criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require append="validation_errors"}
              </td>
            {/if}
              <td>
                {include file="grn/richeditor.tpl" html=$item.html text=$item.text cols=$settings.col_size rows=$settings.row_size enable=$input_config.enable_htmleditor
                 name=$smarty.capture.string_multiple switch_name=$smarty.capture.string_multiple_editor class="form_textarea_grn"}
              </td>
        {if $item.required == 1}
            <td><span class="attention">*</span></td>
        {/if}
        {if $item.option_string_type == 2}<td>{$item.option_string|escape}</td>{/if}
          </tr></table>
        </td>
{elseif $display == 'view-confirm'}
        <td class="{$item_class}">
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {if $item.html}
        {$item.html|grn_noescape}
        {else}
        {grn_format span_mode=true body=$item.text}
        {/if}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
{elseif $item.view_mode}
    {if     $item.view_mode == 'view'}
        <td class="{$item_class}">
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {if $item.html}
        {$item.html|grn_noescape}
        {else}
        {grn_format span_mode=true body=$item.text}
        {/if}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
    {elseif $item.view_mode == 'edit'}
        <td nowrap class="{$item_class}">
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
            {capture name='string_multiple'}item_{$item.iid}{/capture}
            {if $item.required == 1}
                {capture name=validate_require}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-263' replace='true'}{/capture}
                {validate form=$form_name field=$smarty.capture.string_multiple criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require append="validation_errors"}
            {/if}
            {grn_textarea name=$smarty.capture.string_multiple class="textEss" rows=$settings.row_size cols=$settings.col_size value=$item.text}
        {if $item.required == 1}
            <span class="attention">*</span>
        {/if}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
    {elseif $item.view_mode == 'disable'}
        <td class="{$item_class}" nowrap>&nbsp;</td>
    {/if}
{elseif $item.view_mode_print}
    <td class="{$item_class}">
    {if $item.view_mode_print == 'disable'}
        &nbsp;
    {else}
     {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
     {if $item.html}
     {$item.html|grn_noescape}
     {else}
     {grn_format span_mode=true body=$item.text}
     {/if}
     {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
    {/if}
    </td>
{else}
    <td class="{$item_class}">
    {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
    {if $item.html}
    {$item.html|grn_noescape}
    {else}
    {grn_format span_mode=true body=$item.text}
    {/if}
    {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
    </td>
{/if}

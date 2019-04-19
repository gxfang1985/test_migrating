{capture name='string_multiple'}item_{$item.iid}{/capture}
{if $display == 'input' || $display == 'input-system' || $display == 'input-operation'}
    {if $item.attach_file_view == 0}
        <td class="{$item_class}" nowrap><font color="blue">{cb_msg module='grn.workflow' key='key_51_1' replace='true'}</font></td>
        <input type="hidden" name="{$smarty.capture.string_multiple|grn_noescape}" value="{$item.text|escape}">
    {elseif $item.attach_file_view == 1 && $item.attach_file == 0}
        <td class="{$item_class}">
        {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {grn_format span_mode=true body=$item.text}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
        <input type="hidden" name="{$smarty.capture.string_multiple|grn_noescape}" value="{$item.text|escape}">
    {else}
        <td nowrap class="{$item_class}">
        {if $item.br != 1}&nbsp;{$item.separator|escape}&nbsp;{/if}
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
            {capture name='string_multiple'}item_{$item.iid}{/capture}
            {if $item.required == 1}
                {capture name=validate_require}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='is_required_field_2' replace='true'}{/capture}
                {validate form=$form_name field=$smarty.capture.string_multiple criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require append="validation_errors"}
            {/if}
            {grn_textarea name=$smarty.capture.string_multiple class="textEss js_customization_input_item_`$item.code`" rows=$settings.row_size cols=$settings.col_size value=$item.text formsize_ajust_grn=true}
        {if $item.required == 1}
            <span class="attention">*</span>
        {/if}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
    {/if}
{elseif $display == 'view-confirm'}
    {if $item.attach_file_view == 0 && $item.type != 1}
        <td class="{$item_class}" nowrap><font color="blue">&nbsp;</font></td>
    {else}
        <td class="{$item_class}">
        {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {grn_format span_mode=true body=$item.text}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
    {/if}
{elseif $item.view_mode}
    {if     $item.view_mode == 'view'}
        <td class="{$item_class}">
        {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {grn_format span_mode=true body=$item.text}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
    {elseif $item.view_mode == 'edit'}
        <td nowrap class="{$item_class}">
        {if $item.br != 1}&nbsp;{$item.separator|escape}&nbsp;{/if}
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
            {capture name='string_multiple'}item_{$item.iid}{/capture}
            {if $item.required == 1}
                {capture name=validate_require}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='is_required_field_2' replace='true'}{/capture}
                {validate form=$form_name field=$smarty.capture.string_multiple criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require append="validation_errors"}
            {/if}
            {grn_textarea name=$smarty.capture.string_multiple class="textEss js_customization_input_item_`$item.code`" rows=$settings.row_size cols=$settings.col_size value=$item.text formsize_ajust_grn=true}
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
     {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
     {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
     {grn_format span_mode=true body=$item.text}
     {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
    {/if}
    </td>
{else}
    <td class="{$item_class}">
    {if $item.attach_file_view == 0 && $item.type != 1}
        &nbsp;
    {else}
     {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
     {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
     {grn_format span_mode=true body=$item.text}
     {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
    {/if}
    </td>
{/if}

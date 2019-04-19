{capture name='time_prefix'}item_{$item.iid}_{/capture}
{if $display == 'input' || $display == 'input-system' || $display == 'input-operation'}
        <td nowrap class="{$item_class}">
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {if $item.required == 1}
            {capture name=validate_require_hour}{cb_msg module='grn.report.item' key='time_require_hour_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='time_require_hour_2' replace='true'}{/capture}
            {capture name=validate_require_minute}{cb_msg module='grn.report.item' key='time_require_minute_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='time_require_minute_2' replace='true'}{/capture}
            {validate form=$form_name field=$smarty.capture.time_prefix|cat:"hour"  criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_hour  append="validation_errors"}
            {validate form=$form_name field=$smarty.capture.time_prefix|cat:"minute" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_minute append="validation_errors"}
        {/if}
        {grn_select_time minute_interval=$settings.unit prefix=$smarty.capture.time_prefix time=$item.time form_name=$form_name show_blank=$show_blank}
        {if $item.required == 1}
            <span class="attention">*</span>
        {/if}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
{elseif $display == 'view-confirm'}
        <td class="{$item_class}">
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {grn_date_format date=$item.time}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
{elseif $item.view_mode}
    {if     $item.view_mode == 'view'}
        <td class="{$item_class}">
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {grn_date_format date=$item.time}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
    {elseif $item.view_mode == 'edit'}
        <td nowrap class="{$item_class}">
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {if $item.required == 1}
            {capture name=validate_require_hour}{cb_msg module='grn.report.item' key='time_require_hour_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='time_require_hour_2' replace='true'}{/capture}
            {capture name=validate_require_minute}{cb_msg module='grn.report.item' key='time_require_minute_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='time_require_minute_2' replace='true'}{/capture}
            {validate form=$form_name field=$smarty.capture.time_prefix|cat:"hour"  criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_hour  append="validation_errors"}
            {validate form=$form_name field=$smarty.capture.time_prefix|cat:"minute" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_minute append="validation_errors"}
        {/if}
        {grn_select_time minute_interval=$settings.unit prefix=$smarty.capture.time_prefix time=$item.time form_name=$form_name show_blank=$show_blank}
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
    {grn_date_format date=$item.time}
    {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
    {/if}
    </td>
{else}
    <td class="{$item_class}">
    {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
    {grn_date_format date=$item.time}
    {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
    </td>
{/if}

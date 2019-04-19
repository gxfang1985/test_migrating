{capture name='string_single'}item_{$item.iid|escape}{/capture}
{if $display == 'input' || $display == 'input-system' || $display == 'input-operation'}
    <td nowrap class="{$item_class}">
    {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
    {if $settings.input_chars == 1}
        {capture name=validate_input_chars_zenkaku}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-37' replace='true'}{/capture}
        {validate form=$form_name field=$smarty.capture.string_single criteria="grn_report_isStringKind" kind="zenkaku" message=$smarty.capture.validate_input_chars_zenkaku append="validation_errors" empty=true}
    {elseif $settings.input_chars == 2}
        {capture name=validate_input_chars_hankaku}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-38' replace='true'}{/capture}
        {validate form=$form_name field=$smarty.capture.string_single criteria="grn_report_isStringKind" kind="hankaku" message=$smarty.capture.validate_input_chars_hankaku append="validation_errors" empty=true}
    {/if}
    {if $item.required == 1}
        {capture name=validate_require}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-36' replace='true'}{/capture}
        {validate form=$form_name field=$smarty.capture.string_single criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require append="validation_errors"}
    {/if}
    {if $settings.max_input_size}
        {capture name=validate_max_input_size}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-39' replace='true'}{/capture}
        {validate form=$form_name field=$smarty.capture.string_single criteria="grn_report_isLength" min="0" max=$settings.max_input_size message=$smarty.capture.validate_max_input_size append="validation_errors" empty=true}
    {/if}
    {grn_text name=$smarty.capture.string_single size=$settings.size maxlength=$settings.max_input_size value=$item.text}
    {if $item.required == 1}
        <span class="attention">*</span>
    {/if}
    {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
    </td>
{elseif $display == 'view-confirm'}
    <td class="{$item_class}">
    {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
    {$item.text|escape}
    {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
    </td>
{elseif $item.view_mode}
    {if     $item.view_mode == 'view'}
        <td class="{$item_class}">
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {$item.text|escape}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
    {elseif $item.view_mode == 'edit'}
        <td nowrap class="{$item_class}">
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {if $settings.input_chars == 1}
            {capture name=validate_input_chars_zenkaku}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-41' replace='true'}{/capture}
            {validate form=$form_name field=$smarty.capture.string_single criteria="grn_report_isStringKind" kind="zenkaku" message=$smarty.capture.validate_input_chars_zenkaku append="validation_errors" empty=true}
        {elseif $settings.input_chars == 2}
            {capture name=validate_input_chars_hankaku}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-42' replace='true'}{/capture}
            {validate form=$form_name field=$smarty.capture.string_single criteria="grn_report_isStringKind" kind="hankaku" message=$smarty.capture.validate_input_chars_hankaku append="validation_errors" empty=true}
        {/if}
        {if $item.required == 1}
            {capture name=validate_require}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-40' replace='true'}{/capture}
            {validate form=$form_name field=$smarty.capture.string_single criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require append="validation_errors"}
        {/if}
        {if $settings.max_input_size}
            {capture name=validate_max_input_size}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-43' replace='true'}{/capture}
            {validate form=$form_name field=$smarty.capture.string_single criteria="grn_report_isLength" min="0" max=$settings.max_input_size message=$smarty.capture.validate_max_input_size append="validation_errors" empty=true}
        {/if}
        {grn_text name=$smarty.capture.string_single size=$settings.size maxlength=$settings.max_input_size value=$item.text}
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
     {$item.text|escape}
     {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
    {/if}
    </td>
{else}
    <td class="{$item_class}">
    {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
    {$item.text|escape}
    {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
    </td>
{/if}

{capture name='string_single'}item_{$item.iid|escape}{/capture}
{if $display == 'input' || $display == 'input-system' || $display == 'input-operation'}
    {if $item.attach_file_view == 0 && $item.type != 1}
        <td class="{$item_class}" nowrap><font color="blue">{cb_msg module='grn.workflow' key='key_51_1' replace='true'}</font></td>
        <input type="hidden" name="{$smarty.capture.string_single|grn_noescape}" value="{$item.text|escape}">
    {elseif $item.attach_file_view == 1 && $item.attach_file == 0 && $item.type != 1}
        <td class="{$item_class}">
        {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {$item.text|escape}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
        <input type="hidden" name="{$smarty.capture.string_single|grn_noescape}" value="{$item.text|escape}">
    {else}
        <td nowrap class="{$item_class}">
        {if $item.br != 1}&nbsp;{$item.separator|escape}&nbsp;{/if}
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {if $settings.input_chars == 1}
            {capture name=validate_input_chars_zenkaku}{cb_msg module='grn.workflow' key='single_byte_contained_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='single_byte_contained_2' replace='true'}{/capture}
            {validate form=$form_name field=$smarty.capture.string_single criteria="grn_workflow_isStringKind" kind="zenkaku" message=$smarty.capture.validate_input_chars_zenkaku append="validation_errors" empty=true}
        {elseif $settings.input_chars == 2}
            {capture name=validate_input_chars_hankaku}{cb_msg module='grn.workflow' key='two_bytes_contained_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='two_bytes_contained_2' replace='true'}{/capture}
            {validate form=$form_name field=$smarty.capture.string_single criteria="grn_workflow_isStringKind" kind="hankaku" message=$smarty.capture.validate_input_chars_hankaku append="validation_errors" empty=true}
        {/if}
        {if $item.required == 1}
            {capture name=validate_require}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='is_required_field_2' replace='true'}{/capture}
            {validate form=$form_name field=$smarty.capture.string_single criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require append="validation_errors"}
        {/if}
        {if $settings.max_input_size}
            {capture name=validate_max_input_size}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='exceeding_maximum_character_number' replace='true'}{/capture}
            {validate form=$form_name field=$smarty.capture.string_single criteria="grn_workflow_isLength" min="0" max=$settings.max_input_size message=$smarty.capture.validate_max_input_size append="validation_errors" empty=true}
        {/if}
            {grn_text name=$smarty.capture.string_single size=$settings.size maxlength=$settings.max_input_size value=$item.text class="js_customization_input_item_`$item.code`"}
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
        {$item.text|escape}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
    {/if}
{elseif $item.view_mode}
    {if     $item.view_mode == 'view'}
        <td class="{$item_class}">
        {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {$item.text|escape}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
    {elseif $item.view_mode == 'edit'}
        <td nowrap class="{$item_class}">
        {if $item.br != 1}&nbsp;{$item.separator|escape}&nbsp;{/if}
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {if $settings.input_chars == 1}
            {capture name=validate_input_chars_zenkaku}{cb_msg module='grn.workflow' key='single_byte_contained_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='single_byte_contained_2' replace='true'}{/capture}
            {validate form=$form_name field=$smarty.capture.string_single criteria="grn_workflow_isStringKind" kind="zenkaku" message=$smarty.capture.validate_input_chars_zenkaku append="validation_errors" empty=true}
        {elseif $settings.input_chars == 2}
            {capture name=validate_input_chars_hankaku}{cb_msg module='grn.workflow' key='two_bytes_contained_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='two_bytes_contained_2' replace='true'}{/capture}
            {validate form=$form_name field=$smarty.capture.string_single criteria="grn_workflow_isStringKind" kind="hankaku" message=$smarty.capture.validate_input_chars_hankaku append="validation_errors" empty=true}
        {/if}
        {if $item.required == 1}
            {capture name=validate_require}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='is_required_field_2' replace='true'}{/capture}
            {validate form=$form_name field=$smarty.capture.string_single criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require append="validation_errors"}
        {/if}
        {if $settings.max_input_size}
            {capture name=validate_max_input_size}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='exceeding_maximum_character_number' replace='true'}{/capture}
            {validate form=$form_name field=$smarty.capture.string_single criteria="grn_workflow_isLength" min="0" max=$settings.max_input_size message=$smarty.capture.validate_max_input_size append="validation_errors" empty=true}
        {/if}
            {grn_text name=$smarty.capture.string_single size=$settings.size maxlength=$settings.max_input_size value=$item.text class="js_customization_input_item_`$item.code`"}
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
    {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
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
    {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
    {if $item.attach_file_view == 0 && $item.type != 1}
        &nbsp;
    {else}
     {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
     {$item.text|escape}
     {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
    {/if}
    </td>
{/if}

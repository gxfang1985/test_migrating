{capture name='date_prefix'}item_{$item.iid}_{/capture}
{if $display == 'input' || $display == 'input-system' || $display == 'input-operation'}
    {if $item.attach_file_view == 0}
        <td class="{$item_class}" nowrap><font color="blue">{cb_msg module='grn.workflow' key='key_51_1' replace='true'}</font></td>
        <input type="hidden" name="{$smarty.capture.date_prefix|grn_noescape}year"  value="{$initial_date->year}">
        <input type="hidden" name="{$smarty.capture.date_prefix|grn_noescape}month" value="{$initial_date->month}">
        <input type="hidden" name="{$smarty.capture.date_prefix|grn_noescape}day"   value="{$initial_date->day}">
        {if $settings.date_type == 1}
            <input type="hidden" name="{$smarty.capture.date_prefix|grn_noescape}hour"  value="{$initial_time->hour}">
            <input type="hidden" name="{$smarty.capture.date_prefix|grn_noescape}minute" value="{$initial_time->minute}">
        {/if}
    {elseif $item.attach_file_view == 1 && $item.attach_file == 0}
        <td class="{$item_class}">
        {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {if $settings.date_type == 1}
            {if $item.text.year != '' && $item.text.month != '' && $item.text.day != '' && $item.text.hour != '' && $item.text.minute != ''}
                {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$item.datets }
            {/if}
        {else}
            {if $item.text.year != '' && $item.text.month != '' && $item.text.day != ''}
                {grn_date_format format='LongDateFormat' date=$item.datets }
            {/if}
        {/if}
        {if $settings.date_type != 1}
            {if $item.text.year == '' || $item.text.month == '' || $item.text.day == ''}
                {if $item.text.year != ''}
                    {$item.text.year|escape}{cb_msg module='grn.workflow' key='GRN_WKF_13' replace='true'}
                {else}
                    &nbsp;&nbsp;&nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_13' replace='true'}
                {/if}
                {if $item.text.month != ''}
                    {$item.text.month|escape}{cb_msg module='grn.workflow' key='GRN_WKF_14' replace='true'}
                {else}
                    &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_14' replace='true'}
                {/if}
                {if $item.text.day != ''}
                    {$item.text.day|escape}{cb_msg module='grn.workflow' key='GRN_WKF_15' replace='true'}
                {else}
                    &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_15' replace='true'}
                {/if}
            {/if}
        {/if}
        {if $settings.date_type == 1}
            {if $item.text.year == '' || $item.text.month == '' || $item.text.day == '' || $item.text.hour == '' || $item.text.minute == ''}
                {if $item.text.year != ''}
                    {$item.text.year|escape}{cb_msg module='grn.workflow' key='GRN_WKF_13' replace='true'}
                {else}
                    &nbsp;&nbsp;&nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_13' replace='true'}
                {/if}
                {if $item.text.month != ''}
                    {$item.text.month|escape}{cb_msg module='grn.workflow' key='GRN_WKF_14' replace='true'}
                {else}
                    &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_14' replace='true'}
                {/if}
                {if $item.text.day != ''}
                    {$item.text.day|escape}{cb_msg module='grn.workflow' key='GRN_WKF_15' replace='true'}
                {else}
                    &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_15' replace='true'}
                {/if}
                {if $item.text.hour != ''}
                    {$item.text.hour|escape}{cb_msg module='grn.workflow' key='GRN_WKF_18' replace='true'}
                {else}
                    &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_18' replace='true'}
                {/if}
                {if $item.text.minute != ''}
                    {$item.text.minute|escape}{cb_msg module='grn.workflow' key='GRN_WKF_19' replace='true'}
                {else}
                    &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_19' replace='true'}
                {/if}
            {/if}
        {/if}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
        <input type="hidden" name="{$smarty.capture.date_prefix|grn_noescape}year"  value="{$initial_date->year}">
        <input type="hidden" name="{$smarty.capture.date_prefix|grn_noescape}month" value="{$initial_date->month}">
        <input type="hidden" name="{$smarty.capture.date_prefix|grn_noescape}day"   value="{$initial_date->day}">
        {if $settings.date_type == 1}
            <input type="hidden" name="{$smarty.capture.date_prefix|grn_noescape}hour"  value="{$initial_time->hour}">
            <input type="hidden" name="{$smarty.capture.date_prefix|grn_noescape}minute" value="{$initial_time->minute}">
        {/if}
    {else}
        <td nowrap class="{$item_class} js_customization_input_item_{$item.code}">
        {if $item.br != 1}&nbsp;{$item.separator|escape}&nbsp;{/if}
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {if $item.required == 1}
            {capture name=validate_require_year}{cb_msg module='grn.workflow' key='year_required_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='year_required_2' replace='true'}{/capture}
            {capture name=validate_require_month}{cb_msg module='grn.workflow' key='month_required_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='month_required_2' replace='true'}{/capture}
            {capture name=validate_require_day}{cb_msg module='grn.workflow' key='date_required_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='date_required_2' replace='true'}{/capture}
            {if $current_language == 'en'}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"month" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_month append="validation_errors"}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"day"   criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_day   append="validation_errors"}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"year"  criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_year  append="validation_errors"}
            {else}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"year"  criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_year  append="validation_errors"}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"month" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_month append="validation_errors"}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"day"   criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_day   append="validation_errors"}
            {/if}
            {if $settings.date_type == 1}
                {capture name=validate_require_hour}{cb_msg module='grn.workflow' key='hour_required_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='hour_required_2' replace='true'}{/capture}
                {capture name=validate_require_minute}{cb_msg module='grn.workflow' key='minute_required_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='minute_required_2' replace='true'}{/capture}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"hour"  criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_hour  append="validation_errors"}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"minute" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_minute append="validation_errors"}
            {/if}
        {/if}
        {grn_select_date prefix=$smarty.capture.date_prefix date=$initial_date form_name=$form_name show_blank=$show_blank}{if $settings.date_type == 1}&nbsp;{grn_select_time prefix=$smarty.capture.date_prefix time=$initial_time}{/if}
        {if $settings.date_type == 1}
        <script>
            {literal}
            jQuery(document).ready(function(){{/literal}
                var item_hour = jQuery("#{$smarty.capture.date_prefix|grn_noescape}hour");
                var item_minute = jQuery("#{$smarty.capture.date_prefix|grn_noescape}minute");{literal}
                item_hour.change(function(){
                    if (item_hour.val() != '' && item_minute.val() == '')
                    {
                        item_minute.val(0);
                    }
                });
            });
            {/literal}
        </script>
        {/if}
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
        {if $settings.date_type == 1}
            {if $item.text.year != '' && $item.text.month != '' && $item.text.day != '' && $item.text.hour != '' && $item.text.minute != ''}
                {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$item.datets }
            {/if}
        {else}
            {if $item.text.year != '' && $item.text.month != '' && $item.text.day != ''}
                {grn_date_format format='LongDateFormat' date=$item.datets }
            {/if}
        {/if}
        {if $settings.date_type != 1}
            {if $item.text.year == '' || $item.text.month == '' || $item.text.day == ''}
                {if $item.text.year != ''}
                    {$item.text.year|escape}{cb_msg module='grn.workflow' key='GRN_WKF_13' replace='true'}
                {else}
                    &nbsp;&nbsp;&nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_13' replace='true'}
                {/if}
                {if $item.text.month != ''}
                    {$item.text.month|escape}{cb_msg module='grn.workflow' key='GRN_WKF_14' replace='true'}
                {else}
                    &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_14' replace='true'}
                {/if}
                {if $item.text.day != ''}
                    {$item.text.day|escape}{cb_msg module='grn.workflow' key='GRN_WKF_15' replace='true'}
                {else}
                    &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_15' replace='true'}
                {/if}
            {/if}
        {/if}
        {if $settings.date_type == 1}
            {if $item.text.year == '' || $item.text.month == '' || $item.text.day == '' || $item.text.hour == '' || $item.text.minute == ''}
                {if $item.text.year != ''}
                    {$item.text.year|escape}{cb_msg module='grn.workflow' key='GRN_WKF_13' replace='true'}
                {else}
                    &nbsp;&nbsp;&nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_13' replace='true'}
                {/if}
                {if $item.text.month != ''}
                    {$item.text.month|escape}{cb_msg module='grn.workflow' key='GRN_WKF_14' replace='true'}
                {else}
                    &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_14' replace='true'}
                {/if}
                {if $item.text.day != ''}
                    {$item.text.day|escape}{cb_msg module='grn.workflow' key='GRN_WKF_15' replace='true'}
                {else}
                    &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_15' replace='true'}
                {/if}
                {if $item.text.hour != ''}
                    {$item.text.hour|escape}{cb_msg module='grn.workflow' key='GRN_WKF_18' replace='true'}
                {else}
                    &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_18' replace='true'}
                {/if}
                {if $item.text.minute != ''}
                    {$item.text.minute|escape}{cb_msg module='grn.workflow' key='GRN_WKF_19' replace='true'}
                {else}
                    &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_19' replace='true'}
                {/if}
            {/if}
        {/if}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
    {/if}
{elseif $item.view_mode}
    {if     $item.view_mode == 'view'}
        <td class="{$item_class}">
        {if $item.br != 1 && $item.separator != ''}&nbsp;{$item.separator|escape}&nbsp;{/if}
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {if $settings.date_type == 1}
            {if $item.text.year != '' && $item.text.month != '' && $item.text.day != '' && $item.text.hour != '' && $item.text.minute != ''}
                {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$item.datets }
            {/if}
        {else}
            {if $item.text.year != '' && $item.text.month != '' && $item.text.day != ''}
                {grn_date_format format='LongDateFormat' date=$item.datets }
            {/if}
        {/if}
        {if $settings.date_type != 1}
            {if $item.text.year == '' || $item.text.month == '' || $item.text.day == ''}
                {if $item.text.year != ''}
                    {$item.text.year|escape}{cb_msg module='grn.workflow' key='GRN_WKF_13' replace='true'}
                {else}
                    &nbsp;&nbsp;&nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_13' replace='true'}
                {/if}
                {if $item.text.month != ''}
                    {$item.text.month|escape}{cb_msg module='grn.workflow' key='GRN_WKF_14' replace='true'}
                {else}
                    &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_14' replace='true'}
                {/if}
                {if $item.text.day != ''}
                    {$item.text.day|escape}{cb_msg module='grn.workflow' key='GRN_WKF_15' replace='true'}
                {else}
                    &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_15' replace='true'}
                {/if}
            {/if}
        {/if}
        {if $settings.date_type == 1}
            {if $item.text.year == '' || $item.text.month == '' || $item.text.day == '' || $item.text.hour == '' || $item.text.minute == ''}
                {if $item.text.year != ''}
                    {$item.text.year|escape}{cb_msg module='grn.workflow' key='GRN_WKF_13' replace='true'}
                {else}
                    &nbsp;&nbsp;&nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_13' replace='true'}
                {/if}
                {if $item.text.month != ''}
                    {$item.text.month|escape}{cb_msg module='grn.workflow' key='GRN_WKF_14' replace='true'}
                {else}
                    &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_14' replace='true'}
                {/if}
                {if $item.text.day != ''}
                    {$item.text.day|escape}{cb_msg module='grn.workflow' key='GRN_WKF_15' replace='true'}
                {else}
                    &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_15' replace='true'}
                {/if}
                {if $item.text.hour != ''}
                    {$item.text.hour|escape}{cb_msg module='grn.workflow' key='GRN_WKF_18' replace='true'}
                {else}
                    &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_18' replace='true'}
                {/if}
                {if $item.text.minute != ''}
                    {$item.text.minute|escape}{cb_msg module='grn.workflow' key='GRN_WKF_19' replace='true'}
                {else}
                    &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_19' replace='true'}
                {/if}
            {/if}
        {/if}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
    {elseif $item.view_mode == 'edit'}
        <td nowrap class="{$item_class} js_customization_input_item_{$item.code}">
        {if $item.br != 1}&nbsp;{$item.separator|escape}&nbsp;{/if}
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {if $item.required == 1}
            {capture name=validate_require_year}{cb_msg module='grn.workflow' key='year_required_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='year_required_2' replace='true'}{/capture}
            {capture name=validate_require_month}{cb_msg module='grn.workflow' key='month_required_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='month_required_2' replace='true'}{/capture}
            {capture name=validate_require_day}{cb_msg module='grn.workflow' key='date_required_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='date_required_2' replace='true'}{/capture}
            {if $current_language == 'en'}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"month" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_month append="validation_errors"}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"day"   criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_day   append="validation_errors"}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"year"  criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_year  append="validation_errors"}
            {else}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"year"  criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_year  append="validation_errors"}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"month" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_month append="validation_errors"}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"day"   criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_day   append="validation_errors"}
            {/if}
            {if $settings.date_type == 1}
                {capture name=validate_require_hour}{cb_msg module='grn.workflow' key='hour_required_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='hour_required_2' replace='true'}{/capture}
                {capture name=validate_require_minute}{cb_msg module='grn.workflow' key='minute_required_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.workflow' key='minute_required_2' replace='true'}{/capture}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"hour"  criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_hour  append="validation_errors"}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"minute" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_minute append="validation_errors"}
            {/if}
        {/if}
        {grn_select_date prefix=$smarty.capture.date_prefix date=$initial_date form_name=$form_name show_blank=$show_blank}{if $settings.date_type == 1}&nbsp;{grn_select_time prefix=$smarty.capture.date_prefix time=$initial_time}{/if}
        {if $settings.date_type == 1}
        <script>
            {literal}
            jQuery(document).ready(function(){{/literal}
                var item_hour = jQuery("#{$smarty.capture.date_prefix|grn_noescape}hour");
                var item_minute = jQuery("#{$smarty.capture.date_prefix|grn_noescape}minute");{literal}
                item_hour.change(function(){
                    if (item_hour.val() != '' && item_minute.val() == '')
                    {
                        item_minute.val(0);
                    }
                });
            });
            {/literal}
        </script>
        {/if}
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
    {if $settings.date_type == 1}
        {if $item.text.year != '' && $item.text.month != '' && $item.text.day != '' && $item.text.hour != '' && $item.text.minute != ''}
            {grn_date_format_switch format='DateTimeMiddle_YMDW_HM' date=$item.datets locale=$locale}
        {/if}
    {else}
        {if $item.text.year != '' && $item.text.month != '' && $item.text.day != ''}
            {grn_date_format_switch format='LongDateFormat' date=$item.datets locale=$locale}
        {/if}
    {/if}
    {if $settings.date_type != 1}
        {if $item.text.year == '' || $item.text.month == '' || $item.text.day == ''}
            {if $item.text.year != ''}
                {$item.text.year|escape}{grn_msg_switch module='grn.workflow' key='GRN_WKF_13' replace='true'}
            {else}
                &nbsp;&nbsp;&nbsp;&nbsp;{grn_msg_switch module='grn.workflow' key='GRN_WKF_13' replace='true'}
            {/if}
            {if $item.text.month != ''}
                {$item.text.month|escape}{grn_msg_switch module='grn.workflow' key='GRN_WKF_14' replace='true'}
            {else}
                &nbsp;&nbsp;{grn_msg_switch module='grn.workflow' key='GRN_WKF_14' replace='true'}
            {/if}
            {if $item.text.day != ''}
                {$item.text.day|escape}{grn_msg_switch module='grn.workflow' key='GRN_WKF_15' replace='true'}
            {else}
                &nbsp;&nbsp;{grn_msg_switch module='grn.workflow' key='GRN_WKF_15' replace='true'}
            {/if}
        {/if}
    {/if}
    {if $settings.date_type == 1}
        {if $item.text.year == '' || $item.text.month == '' || $item.text.day == '' || $item.text.hour == '' || $item.text.minute == ''}
            {if $item.text.year != ''}
                {$item.text.year|escape}{grn_msg_switch module='grn.workflow' key='GRN_WKF_13' replace='true'}
            {else}
                &nbsp;&nbsp;&nbsp;&nbsp;{grn_msg_switch module='grn.workflow' key='GRN_WKF_13' replace='true'}
            {/if}
            {if $item.text.month != ''}
                {$item.text.month|escape}{grn_msg_switch module='grn.workflow' key='GRN_WKF_14' replace='true'}
            {else}
                &nbsp;&nbsp;{grn_msg_switch module='grn.workflow' key='GRN_WKF_14' replace='true'}
            {/if}
            {if $item.text.day != ''}
                {$item.text.day|escape}{grn_msg_switch module='grn.workflow' key='GRN_WKF_15' replace='true'}
            {else}
                &nbsp;&nbsp;{grn_msg_switch module='grn.workflow' key='GRN_WKF_15' replace='true'}
            {/if}
            {if $item.text.hour != ''}
                {$item.text.hour|escape}{grn_msg_switch module='grn.workflow' key='GRN_WKF_18' replace='true'}
            {else}
                &nbsp;&nbsp;{grn_msg_switch module='grn.workflow' key='GRN_WKF_18' replace='true'}
            {/if}
            {if $item.text.minute != ''}
                {$item.text.minute|escape}{grn_msg_switch module='grn.workflow' key='GRN_WKF_19' replace='true'}
            {else}
                &nbsp;&nbsp;{grn_msg_switch module='grn.workflow' key='GRN_WKF_19' replace='true'}
            {/if}
        {/if}
    {/if}
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
    {if $settings.date_type == 1}
        {if $item.text.year != '' && $item.text.month != '' && $item.text.day != '' && $item.text.hour != '' && $item.text.minute != ''}
            {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$item.datets }
        {/if}
    {else}
        {if $item.text.year != '' && $item.text.month != '' && $item.text.day != ''}
            {grn_date_format format='LongDateFormat' date=$item.datets }
        {/if}
    {/if}
    {if $settings.date_type != 1}
        {if $item.text.year == '' || $item.text.month == '' || $item.text.day == ''}
            {if $item.text.year != ''}
                {$item.text.year|escape}{cb_msg module='grn.workflow' key='GRN_WKF_13' replace='true'}
            {else}
                &nbsp;&nbsp;&nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_13' replace='true'}
            {/if}
            {if $item.text.month != ''}
                {$item.text.month|escape}{cb_msg module='grn.workflow' key='GRN_WKF_14' replace='true'}
            {else}
                &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_14' replace='true'}
            {/if}
            {if $item.text.day != ''}
                {$item.text.day|escape}{cb_msg module='grn.workflow' key='GRN_WKF_15' replace='true'}
            {else}
                &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_15' replace='true'}
            {/if}
        {/if}
    {/if}
    {if $settings.date_type == 1}
        {if $item.text.year == '' || $item.text.month == '' || $item.text.day == '' || $item.text.hour == '' || $item.text.minute == ''}
            {if $item.text.year != ''}
                {$item.text.year|escape}{cb_msg module='grn.workflow' key='GRN_WKF_13' replace='true'}
            {else}
                &nbsp;&nbsp;&nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_13' replace='true'}
            {/if}
            {if $item.text.month != ''}
                {$item.text.month|escape}{cb_msg module='grn.workflow' key='GRN_WKF_14' replace='true'}
            {else}
                &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_14' replace='true'}
            {/if}
            {if $item.text.day != ''}
                {$item.text.day|escape}{cb_msg module='grn.workflow' key='GRN_WKF_15' replace='true'}
            {else}
                &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_15' replace='true'}
            {/if}
            {if $item.text.hour != ''}
                {$item.text.hour|escape}{cb_msg module='grn.workflow' key='GRN_WKF_18' replace='true'}
            {else}
                &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_18' replace='true'}
            {/if}
            {if $item.text.minute != ''}
                {$item.text.minute|escape}{cb_msg module='grn.workflow' key='GRN_WKF_19' replace='true'}
            {else}
                &nbsp;&nbsp;{cb_msg module='grn.workflow' key='GRN_WKF_19' replace='true'}
            {/if}
        {/if}
    {/if}
    {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
    {/if}
    </td>
{/if}

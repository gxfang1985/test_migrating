{capture name='date_prefix'}item_{$item.iid}_{/capture}
{if $display == 'input' || $display == 'input-system' || $display == 'input-operation'}
        <td nowrap class="{$item_class}">
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {if $item.required == 1}
            {capture name=validate_require_year}{cb_msg module='grn.report.item' key='year_required_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='year_required_2' replace='true'}{/capture}
            {capture name=validate_require_month}{cb_msg module='grn.report.item' key='month_required_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='month_required_2' replace='true'}{/capture}
            {capture name=validate_require_day}{cb_msg module='grn.report.item' key='date_required_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='date_required_2' replace='true'}{/capture}
            {if $current_language == 'en'}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"month" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_month append="validation_errors"}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"day"   criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_day   append="validation_errors"}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"year"  criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_year  append="validation_errors"}
            {else}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"year"  criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_year  append="validation_errors"}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"month" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_month append="validation_errors"}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"day"   criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_day   append="validation_errors"}
            {/if}
        {/if}
        {grn_select_date prefix=$smarty.capture.date_prefix date=$initial_date form_name=$form_name show_blank=$show_blank}
        {if $item.required == 1}
            <span class="attention">*</span>
        {/if}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
{elseif $display == 'view-confirm'}
        <td class="{$item_class}">
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
{*
        {if $item.text.year != ''}
            {$item.text.year|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-394' replace='true'}{$item.text.month|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-395' replace='true'}{$item.text.day|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-396' replace='true'}
        {else}
            {$item.text.month|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-397' replace='true'}{$item.text.day|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-398' replace='true'}
        {/if}
*}
        {if $item.text.year != ''}
            {$item.text.year|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-399' replace='true'}
        {else}
            &nbsp;&nbsp;&nbsp;&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-400' replace='true'}
        {/if}
        
        {if $item.text.month != ''}
            {$item.text.month|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-401' replace='true'}
        {else}
            &nbsp;&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-402' replace='true'}
        {/if}
        
        {if $item.text.day != ''}
            {$item.text.day|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-403' replace='true'}
        {else}
            &nbsp;&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-404' replace='true'}
        {/if}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
{elseif $item.view_mode}
    {if     $item.view_mode == 'view'}
        <td class="{$item_class}">
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
{*
        {if $item.text.year != ''}
            {$item.text.year|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-405' replace='true'}{$item.text.month|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-406' replace='true'}{$item.text.day|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-407' replace='true'}
        {else}
            {$item.text.month|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-408' replace='true'}{$item.text.day|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-409' replace='true'}
        {/if}
*}
        {if $item.text.year != ''}
            {$item.text.year|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-410' replace='true'}
        {else}
            &nbsp;&nbsp;&nbsp;&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-411' replace='true'}
        {/if}
        
        {if $item.text.month != ''}
            {$item.text.month|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-412' replace='true'}
        {else}
            &nbsp;&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-413' replace='true'}
        {/if}
        
        {if $item.text.day != ''}
            {$item.text.day|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-414' replace='true'}
        {else}
            &nbsp;&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-415' replace='true'}
        {/if}
        {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
        </td>
    {elseif $item.view_mode == 'edit'}
        <td nowrap class="{$item_class}">
        {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
        {if $item.required == 1}
            {capture name=validate_require_year}{cb_msg module='grn.report.item' key='year_required_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='year_required_2' replace='true'}{/capture}
            {capture name=validate_require_month}{cb_msg module='grn.report.item' key='month_required_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='month_required_2' replace='true'}{/capture}
            {capture name=validate_require_day}{cb_msg module='grn.report.item' key='date_required_1' replace='true'}{$current_display_name|grn_noescape}{cb_msg module='grn.report.item' key='date_required_2' replace='true'}{/capture}
            {if $current_language == 'en'}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"month" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_month append="validation_errors"}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"day"   criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_day   append="validation_errors"}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"year"  criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_year  append="validation_errors"}
            {else}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"year"  criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_year  append="validation_errors"}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"month" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_month append="validation_errors"}
                {validate form=$form_name field=$smarty.capture.date_prefix|cat:"day"   criteria="notEmpty" transform="cb_trim" message=$smarty.capture.validate_require_day   append="validation_errors"}
            {/if}
        {/if}
        {grn_select_date prefix=$smarty.capture.date_prefix date=$initial_date form_name=$form_name show_blank=$show_blank}
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
{*
    {if $item.text.year != ''}
        {$item.text.year|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-419' replace='true'}{$item.text.month|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-420' replace='true'}{$item.text.day|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-421' replace='true'}
    {else}
        {$item.text.month|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-422' replace='true'}{$item.text.day|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-423' replace='true'}
    {/if}
*}
    {if $item.text.year == '' || $item.text.month == '' || $item.text.day == ''}
        {if $item.text.year != ''}
            {$item.text.year|escape}{grn_msg_switch module='grn.report' key='GRN_RPRT_424'}
        {else}
            &nbsp;&nbsp;&nbsp;&nbsp;{grn_msg_switch module='grn.report' key='GRN_RPRT_424'}
        {/if}
    
        {if $item.text.month != ''}
            {$item.text.month|escape}{grn_msg_switch module='grn.report' key='GRN_RPRT_426'}
        {else}
            &nbsp;&nbsp;{grn_msg_switch module='grn.report' key='GRN_RPRT_426'}
        {/if}
    
        {if $item.text.day != ''}
            {$item.text.day|escape}{grn_msg_switch module='grn.report' key='GRN_RPRT_428'}
        {else}
            &nbsp;&nbsp;{grn_msg_switch module='grn.report' key='GRN_RPRT_428'}
        {/if}
    {else}
        {grn_date_format_switch format='DateShort_MDW' date=$item.datets}
    {/if}
    {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
    {/if}
    </td>
{else}
    <td class="{$item_class}">
    {if $item.option_string_type == 1}{$item.option_string|escape}{/if}
    {if $item.text.year != ''}
        {$item.text.year|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-430' replace='true'}
    {else}
        &nbsp;&nbsp;&nbsp;&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-431' replace='true'}
    {/if}
    
    {if $item.text.month != ''}
        {$item.text.month|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-432' replace='true'}
    {else}
        &nbsp;&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-433' replace='true'}
    {/if}
    
    {if $item.text.day != ''}
        {$item.text.day|escape}{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-434' replace='true'}
    {else}
        &nbsp;&nbsp;{cb_msg module='grn.report.item' key='GRN_RPRT_ITEM-435' replace='true'}
    {/if}
    {if $item.option_string_type == 2}{$item.option_string|escape}{/if}
    </td>
{/if}
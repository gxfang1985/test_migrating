<tr valign="top">
    {capture name='grn_grn_GRN_GRN_1184'}{cb_msg module='grn.grn' key='GRN_GRN-1184' replace='true'}{/capture}
    <th nowrap id="weather_forecast_label">{grn_show_input_title title=$smarty.capture.grn_grn_GRN_GRN_1184}</th>
    <td class="weather_area_base_grn">
        {if $disable}
            <div class="sub_explanation">
                {capture name='default_message_disabled'}{cb_msg module='grn.grn' key='GRN_GRN-1185' replace='true'}{/capture}
                {$message_disabled|default:$smarty.capture.default_message_disabled}
            </div>
        {else}
            {if $location_list}
                {include file="cbwebsrv/weather_location_tree.tpl" location_tree=$location_list location_tree_id='location_tree_id'}
            {else}
                <div class="sub_explanation">
                    {capture name='default_message_nodata'}{cb_msg module='grn.grn' key='GRN_GRN-1186' replace='true'}{/capture}
                    {$message_nodata|default:$smarty.capture.default_message_nodata}
                </div>
            {/if}
        {/if}
    </td>
</tr>
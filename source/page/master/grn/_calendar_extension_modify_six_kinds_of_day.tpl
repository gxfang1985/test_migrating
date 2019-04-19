<tr>
    <th nowrap>
        {cb_msg module='grn.grn' key='GRN_GRN-882' replace='true'}
    </th>
    <td>
        {if $disable}
            <div class="sub_explanation">
                {capture name='default_message_disabled'}{cb_msg module='grn.grn' key='GRN_GRN-883' replace='true'}{/capture}
                {$message_disabled|default:$smarty.capture.default_message_disabled}
            </div>
        {else}
            {if $is_event_receive}
                {capture name='grn_grn_GRN_GRN_884'}{cb_msg module='grn.grn' key='GRN_GRN-884' replace='true'}{/capture}
                {grn_checkbox name=$field_name id='six_kinds_of_day' value='1' caption=$smarty.capture.grn_grn_GRN_GRN_884 checked=$checked}
                <br>
            {else}
                <div class="sub_explanation">
                    {capture name='default_message_nodata'}{cb_msg module='grn.grn' key='GRN_GRN-885' replace='true'}{/capture}
                    {$message_nodata|default:$smarty.capture.default_message_nodata}
                </div>
            {/if}
        {/if}

    </td>
</tr>

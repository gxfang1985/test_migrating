<tr class="js_expiration_date">
    <th>{cb_msg module="grn.space" key="create-space-17" replace="true"}
            <span class="attention">*</span>
    </th>
    <td>
        {if $is_allowed_unlimited}
            <div class="mBottom3">
                <span class="radiobutton_base_grn">
                    {capture name='grn_space_create_space_18'}{cb_msg module='grn.space' key='create-space-18' replace='true'}{/capture}
                    {grn_radio name='default_expiration_date' id='unlimited' value=1 checked=$is_used_unlimited caption=$smarty.capture.grn_space_create_space_18}
                </span>
            </div>
            <div class="mBottom3">
                <span class="radiobutton_base_grn">
                     {capture name='grn_space_create_space_19'}{cb_msg module='grn.space' key='create-space-19' replace='true'}{/capture}
                    {grn_radio name='default_expiration_date' id='limited'  value=0 checked=$is_used_limited caption=$smarty.capture.grn_space_create_space_19}
                </span>
            </div>
        {/if}
        <div class="mBottom3">
            {grn_select_date prefix="expiration_date_" form_name=$form_name necessary=false show_wday=true date=$default_date_expiration support_calendar_disable_ui=true}{grn_select_time prefix='expiration_date_' minute_interval=$minute_interval time=$default_time_expiration}
        </div>
    </td>
</tr>
{grn_load_javascript file="grn/html/component/space/_expiration_date.js"}
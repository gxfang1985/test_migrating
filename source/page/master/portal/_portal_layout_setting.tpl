<div class="layout_setting_grn">
    <div>
        <form action="{grn_pageurl page="portal/"|cat:$page_info.parts[1]|cat:"/command_view"}" method="post" name="layout_setting_form">
            <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <input type="hidden" name="pid" value="{$portal_id}">
            <input type="hidden" name="current_layout" value="{if $fixed == 0}0{else}{$portal_layout[1]}_{$portal_layout[2]}_{$portal_layout[3]}{/if}">
            {strip}
            <span class="vAlignMiddle-grn mRight3">{cb_msg module="grn.portal" key="GRN_POT-11" replace="true"}</span>
            <dl class="selectmenu_grn selectmenu_base_grn mRight5" id="portal_layout_setting_menu">
                <dt>
                    <a class="nowrap-grn" href="javascript:void(0)">
                        <span></span>
                        <span id="portal_layout_setting_current">
                            {if $fixed == 0}
                                {cb_msg module="grn.portal" key="GRN_POT-12" replace="true"}
                            {else}
                                {cb_msg module="grn.portal" key="GRN_POT-6" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}{$portal_layout[1]}{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                {if $portal_layout[2] > 0}
                                    &nbsp;&nbsp;{cb_msg module="grn.portal" key="GRN_POT-7" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}{$portal_layout[2]}{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                {/if}
                                {if $portal_layout[3] > 0}
                                    &nbsp;&nbsp;{cb_msg module="grn.portal" key="GRN_POT-8" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}{$portal_layout[3]}{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                {/if}
                            {/if}
                        </span>
                        <span class="pulldownbutton_arrow_down_grn mLeft3"></span>
                    </a>
                </dt>
                <dd style="margin:0;padding:0"></dd>
            </dl>
            <div class="pulldown_menu_grn" id="portal_layout_setting_pulldown" style="display: none;">
                <div class="portal_layout_pulldown_area_grn">
                    <table class="portal_layout_pulldown_base_grn mBottom15" id="1_column_layout_setting">
                        <tbody>
                        <tr>
                            <td rowspan="2"><span class="portal_layout_thumbnail2_grn"></span></td>
                            <td>
                                <span class="nowrap-grn">
                                    <span class="portal_layout_label_grn">{cb_msg module="grn.portal" key="GRN_POT-26" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-28" replace="true"}</span>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="portal_layout_item_grn">
                                    <span>
                                        <input type="radio" value="100_0_0" id="portal_layout_setting_100_0_0" name="portal_layout" class="mRight3"{if $fixed == 1 && $portal_layout[1] == 100} checked{/if}>
                                    </span>
                                    <label for="portal_layout_setting_100_0_0">
                                        {cb_msg module="grn.portal" key="GRN_POT-6" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                        <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-32" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                    </label>
                                </span>
                                <div class="portal_layout_pulldown_info_grn mLeft20" style="display: none;">
                                    <span class="icon_information_c_grn icon_inline_grn"></span>
                                    <span>{cb_msg module="grn.portal" key="GRN_POT-39" replace="true"}</span>
                                </div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <table class="portal_layout_pulldown_base_grn mBottom15" id="2_column_layout_setting">
                        <tbody>
                        <tr>
                            <td rowspan="2"><span class="portal_layout_thumbnail3_grn"></span></td>
                            <td colspan="2">
                                <span class="nowrap-grn">
                                    <span class="portal_layout_label_grn">{cb_msg module="grn.portal" key="GRN_POT-26" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-29" replace="true"}</span>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="portal_layout_pulldown_info_grn mLeft20" style="display: none;">
                                    <span class="icon_information_c_grn icon_inline_grn"></span>
                                    <span>{cb_msg module="grn.portal" key="GRN_POT-40" replace="true"}</span>
                                </div>
                                <span class="portal_layout_item_grn">
                                    <span>
                                        <input type="radio" value="50_50_0" id="portal_layout_setting_50_50_0" name="portal_layout" class="mRight3"{if $fixed == 1 && $portal_layout[1] == 50} checked{/if}>
                                    </span>
                                    <label for="portal_layout_setting_50_50_0">
                                        {cb_msg module="grn.portal" key="GRN_POT-6" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                        <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-35" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        <span class="mLeft10">
                                            {cb_msg module="grn.portal" key="GRN_POT-7" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                            <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-35" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        </span>
                                    </label>
                                </span>
                                <span class="portal_layout_item_grn">
                                    <span>
                                        <input type="radio" value="40_60_0" id="portal_layout_setting_40_60_0" name="portal_layout" class="mRight3"{if $fixed == 1 && $portal_layout[2] == 60} checked{/if}>
                                    </span>
                                    <label for="portal_layout_setting_40_60_0">
                                        {cb_msg module="grn.portal" key="GRN_POT-6" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                        <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-36" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        <span class="mLeft10">
                                            {cb_msg module="grn.portal" key="GRN_POT-7" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                            <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-34" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        </span>
                                    </label>
                                </span>
                                <span class="portal_layout_item_grn">
                                    <span>
                                        <input type="radio" value="60_40_0" id="portal_layout_setting_60_40_0" name="portal_layout" class="mRight3"{if $fixed == 1 && $portal_layout[1] == 60} checked{/if}>
                                    </span>
                                    <label for="portal_layout_setting_60_40_0">
                                        {cb_msg module="grn.portal" key="GRN_POT-6" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                        <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-34" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        <span class="mLeft10">
                                            {cb_msg module="grn.portal" key="GRN_POT-7" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                            <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-36" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        </span>
                                    </label>
                                </span>
                            </td>
                            <td>
                                <span class="portal_layout_item_grn mLeft20">
                                    <span>
                                        <input type="radio" value="30_70_0" id="portal_layout_setting_30_70_0" name="portal_layout" class="mRight3"{if $fixed == 1 && $portal_layout[2] == 70} checked{/if}>
                                    </span>
                                    <label for="portal_layout_setting_30_70_0">
                                        {cb_msg module="grn.portal" key="GRN_POT-6" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                        <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-37" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        <span class="mLeft10">
                                            {cb_msg module="grn.portal" key="GRN_POT-7" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                            <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-33" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        </span>
                                    </label>
                                </span>
                                <span class="portal_layout_item_grn mLeft20">
                                    <span>
                                        <input type="radio" value="70_30_0" id="portal_layout_setting_70_30_0" name="portal_layout" class="mRight3"{if $fixed == 1 && $portal_layout[1] == 70} checked{/if}>
                                    </span>
                                    <label for="portal_layout_setting_70_30_0">
                                        {cb_msg module="grn.portal" key="GRN_POT-6" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                        <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-33" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        <span class="pLeft10">
                                            {cb_msg module="grn.portal" key="GRN_POT-7" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                            <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-37" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        </span>
                                    </label>
                                </span>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <table class="portal_layout_pulldown_base_grn mBottom15" id="3_column_layout_setting">
                        <tbody>
                        <tr>
                            <td rowspan="2"><span class="portal_layout_thumbnail4_grn"></span></td>
                            <td colspan="2">
                                <span class="nowrap-grn">
                                    <span class="portal_layout_label_grn">{cb_msg module="grn.portal" key="GRN_POT-26" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-30" replace="true"}</span>
                                </span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span class="portal_layout_item_grn">
                                    <span>
                                        <input type="radio" value="33_33_33" id="portal_layout_setting_33_33_33" name="portal_layout" class="mRight3"{if $fixed == 1 && $portal_layout[3] == 33} checked{/if}>
                                    </span>
                                    <label for="portal_layout_setting_33_33_33">
                                        {cb_msg module="grn.portal" key="GRN_POT-6" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                        <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-38" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        <span class="pLeft10">
                                            {cb_msg module="grn.portal" key="GRN_POT-7" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                            <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-38" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        </span>
                                        <span class="pLeft10">
                                            {cb_msg module="grn.portal" key="GRN_POT-8" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                            <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-38" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        </span>
                                    </label>
                                </span>
                                <span class="portal_layout_item_grn">
                                    <span>
                                        <input type="radio" value="30_40_30" id="portal_layout_setting_30_40_30" name="portal_layout" class="mRight3"{if $fixed == 1 && $portal_layout[1] == 30 && $portal_layout[2] == 40} checked{/if}>
                                    </span>
                                    <label for="portal_layout_setting_30_40_30">
                                        {cb_msg module="grn.portal" key="GRN_POT-6" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                        <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-37" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        <span class="pLeft10">
                                            {cb_msg module="grn.portal" key="GRN_POT-7" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                            <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-36" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        </span>
                                        <span class="pLeft10">
                                            {cb_msg module="grn.portal" key="GRN_POT-8" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                            <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-37" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        </span>
                                    </label>
                                </span>
                            </td>
                            <td>
                                <span class="portal_layout_item_grn mLeft20">
                                    <span>
                                        <input type="radio" value="30_30_40" id="portal_layout_setting_30_30_40" name="portal_layout" class="mRight3"{if $fixed == 1 && $portal_layout[3] == 40} checked{/if}>
                                    </span>
                                    <label for="portal_layout_setting_30_30_40">
                                        {cb_msg module="grn.portal" key="GRN_POT-6" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                        <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-37" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        <span class="pLeft10">
                                            {cb_msg module="grn.portal" key="GRN_POT-7" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                            <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-37" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        </span>
                                        <span class="pLeft10">
                                            {cb_msg module="grn.portal" key="GRN_POT-8" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                            <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-36" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        </span>
                                    </label>
                                </span>
                                <span class="portal_layout_item_grn mLeft20">
                                    <span>
                                        <input type="radio" value="40_30_30" id="portal_layout_setting_40_30_30" name="portal_layout" class="mRight3"{if $fixed == 1 && $portal_layout[1] == 40 && $portal_layout[2] == 30} checked{/if}>
                                    </span>
                                    <label for="portal_layout_setting_40_30_30">
                                        {cb_msg module="grn.portal" key="GRN_POT-6" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                        <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-36" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        <span class="pLeft10">
                                            {cb_msg module="grn.portal" key="GRN_POT-7" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                            <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-37" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        </span>
                                        <span class="pLeft10">
                                            {cb_msg module="grn.portal" key="GRN_POT-8" replace="true"}{cb_msg module="grn.portal" key="GRN_POT-27" replace="true"}
                                            <span class="portal_layout_width_grn">{cb_msg module="grn.portal" key="GRN_POT-37" replace="true"}</span>{cb_msg module="grn.portal" key="GRN_POT-31" replace="true"}
                                        </span>
                                    </label>
                                </span>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                    <table class="portal_layout_pulldown_base_grn mBottom15" id="no_layout_setting">
                        <tbody>
                        <tr>
                            <td><span class="portal_layout_thumbnail1_grn"></span></td>
                            <td>
                                <span class="portal_layout_item_grn">
                                    <span>
                                        <input type="radio" value="0" id="portal_layout_setting_0" name="portal_layout" class="mRight3"{if $fixed != 1} checked{/if}>
                                    </span>
                                    <label for="portal_layout_setting_0">
                                        <span class="portal_layout_label_grn">{cb_msg module="grn.portal" key="GRN_POT-12" replace="true"}</span>
                                    </label>
                                </span>
                                <div class="mLeft20">{cb_msg module="grn.portal" key="GRN_POT-25"}</div>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <span id="portal_layout_setting_submit" class="button_standard_disable_grn">
                <a href="javascript:void(0);">
                    <span>{cb_msg module="grn.portal" key="GRN_POT-13" replace="true"}</span>
                </a>
            </span>
            {/strip}
        </form>
    </div>
</div>

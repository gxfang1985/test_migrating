{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_load_javascript file="grn/html/component/editable_table.js"}
{grn_load_javascript file="grn/html/page/system/application/external_access_edit.js"}

<div class="mainarea">
    {grn_title title=$page_title class=$page_info.parts[0]}
    {foreach from=$ours_params key=key item=item}
        <input type="hidden" name="{$key}" value="{$item|escape}">
    {/foreach}
    {strip}
        <table class="std_form mTop10">
            <tbody>
            </tbody>
            <colgroup>
                <col style="width: 15em;">
            </colgroup>
            <tbody>
            <tr>
                <th class="nowrap-grn">
                    {cb_msg module='grn.system.application' key='GRN_SY_AP-82' replace='true'}
                </th>
                <td>
                    <span class="radiobutton_base_grn radiobutton_base_block_grn js_radio_check">
                        {capture name='grn_system_application_GRN_SY_AP_86'}{cb_msg module='grn.system.application' key='GRN_SY_AP-86' replace='true'}{/capture}
                        {grn_radio id="not_use" name="external_access_setting" value="0" class="js_setting_selected" caption=$smarty.capture.grn_system_application_GRN_SY_AP_86 checked=$checked_setting.not_use}

                    </span>
                    {if $smarty.const.ON_FOREST!==1}
                        <span class="radiobutton_base_grn radiobutton_base_block_grn js_radio_check">
                        {capture name='grn_system_application_GRN_SY_AP_87'}{cb_msg module='grn.system.application' key='GRN_SY_AP-87' replace='true'}{/capture}
                            {grn_radio id="use_rsm" name="external_access_setting" value="1" class="js_setting_selected" caption=$smarty.capture.grn_system_application_GRN_SY_AP_87 checked=$checked_setting.use_rsm}
                        </span>
                    {/if}
                    <span class="radiobutton_base_grn radiobutton_base_block_grn js_radio_check">
                        {capture name='grn_system_application_GRN_SY_AP_88'}{cb_msg module='grn.system.application' key='GRN_SY_AP-88' replace='true'}{/capture}
                        {grn_radio id="use_internal_address" name="external_access_setting" value="2" class="js_setting_selected" caption=$smarty.capture.grn_system_application_GRN_SY_AP_88 checked=$checked_setting.use_internal_address}
                    </span>
                    <div id="internal_address" class="move_list_grn mTop7 mLeft15">
                    </div>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td>
                    <div>
                        {capture name="grn_system_application_GRN_SY_AP_92"}{cb_msg module='grn.system.application' key='GRN_SY_AP-92' replace='true'}{/capture}
                        {grn_button_submit class='margin js_rows_submit' button_type='submit' caption=$smarty.capture.grn_system_application_GRN_SY_AP_92}
                        {capture name="grn_system_application_GRN_SY_AP_93"}{cb_msg module='grn.system.application' key='GRN_SY_AP-93' replace='true'}{/capture}
                        {grn_button_cancel page='system/application/external_access_detail' caption=$smarty.capture.grn_system_application_GRN_SY_AP_93 }
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    {/strip}
</div>
{include file="grn/system_footer.tpl"}

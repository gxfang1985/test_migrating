{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}

<div class="mainarea">
    {grn_title title=$page_title class=$page_info.parts[0]}
    {foreach from=$ours_params key=key item=item}
        <input type="hidden" name="{$key}" value="{$item|escape}">
    {/foreach}
    <div id="main_menu_part">
        <span class="menu_item">{capture name='grn_system_GRN_SY_AP_79'}{cb_msg module='grn.system.application' key='GRN_SY_AP-79' replace='true'}{/capture}{grn_link image='modify20.gif' page="system/application/external_access_edit" caption=$smarty.capture.grn_system_GRN_SY_AP_79 }</span>
        <span class="menu_item">{capture name='grn_system_GRN_SY_AP_81'}{cb_msg module='grn.system.application' key='GRN_SY_AP-80' replace='true'}{/capture}{grn_link image='import20.gif' page="system/application/ip_address_import1" caption=$smarty.capture.grn_system_GRN_SY_AP_81 disabled=$disable_delete_all}</span>
        <span class="menu_item">{capture name='grn_system_GRN_SY_AP_82'}{cb_msg module='grn.system.application' key='GRN_SY_AP-81' replace='true'}{/capture}{grn_link image='export20.gif' page="system/application/ip_address_export" caption=$smarty.capture.grn_system_GRN_SY_AP_82 disabled=$disable_delete_all}</span>
    </div>
    {strip}
    <table class="view_table">
        <tbody>
        <tr>
            <th class="nowrap-grn">{cb_msg module='grn.system.application' key='GRN_SY_AP-82' replace='true'}</th>
            <td>{strip}
                {$setting_value|escape}
                {if $is_ip_setting}<div class="sub_explanation mTop5">{cb_msg module='grn.system.application' key='GRN_SY_AP-113' replace='true'}</div>{/if}
                {/strip}
            </td>
        </tr>
        <tr>
            <th class="nowrap-grn">{cb_msg module='grn.system.application' key='GRN_SY_AP-84' replace='true'}</th>
            <td>
                <div class="sub_explanation"><span class="attention">
                        {cb_msg module='grn.system.application' key='GRN_SY_AP-85' replace='true'}
                    </span>
                </div>
                <table class="admin_list_table list_column_grn list_column_style3_grn" style="max-width:900px;">
                    <tbody>
                    <tr>
                        <th class="nowrap-grn" style="width:20px;">{cb_msg module='grn.system.application' key='GRN_SY_AP-76' replace='true'}</th>
                        <th class="nowrap-grn" style="width:10px;">/</th>
                        <th class="nowrap-grn" style="width:20px;">{cb_msg module='grn.system.application' key='GRN_SY_AP-77' replace='true'}</th>
                        <th>{cb_msg module='grn.system.application' key='GRN_SY_AP-78' replace='true'}</th>
                    </tr>
                    {foreach from=$internal_ip_address_list item=internal_ip_address}
                        <tr>
                            <td style="width:20px;">{$internal_ip_address->getIpAddress()|escape}</td>
                            <td style="width:10px;">/</td>
                            <td style="width:20px;">{$internal_ip_address->getCidr()}</td>
                            <td class="foldback_grn">{$internal_ip_address->getMemo()|escape}</td>
                        </tr>
                    {/foreach}
                    </tbody>
                </table>
                <div  class="sub_explanation">{cb_msg module='grn.system.application' key='GRN_SY_AP-111' replace='true'}<br />{cb_msg module='grn.system.application' key='GRN_SY_AP-112' replace='true'}</div>
            </td>
        </tr>
        <tr>
        </tr>
        </tbody>
    </table>
    {/strip}
</div>
{include file="grn/system_footer.tpl"}

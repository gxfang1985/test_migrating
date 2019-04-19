{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_load_javascript file="grn/html/page/system/application/change_allow_application.js"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<table style="width:80%;" class="view_table mTop10 mBottom15">
    <tr>
        <th class="nowrap-grn" style="width:20%;">{cb_msg module='grn.system.application' key='GRN_SY_AP-53' replace='true'}:</th>
        <td class="nowrap-grn" style="width:80%;">
        {if $type == 'dynamic_role'}
            {grn_image image='role20.gif'}{$id|escape}
        {elseif $type == 'cb_role'}
            {grn_image image='role20.gif'}{grn_role_name rid=$id}
        {elseif $type == 'cb_group'}
            {capture name='grn_get_group_path_string_eid'}o_{$id}{/capture}
            {grn_organize_name gid=$id}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}
        {elseif $type == 'cb_user'}
            {capture name='grn_get_group_path_string_eid'}u_{$id}{/capture}
            {grn_user_name uid=$id}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}
        {/if}
        </td>
    </tr>
</table>
<div class="mBottom5">{cb_msg module='grn.system.application' key='GRN_SY_AP-54' replace='true'}</div>
{strip}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/application/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <table id="application_list" class="admin_list_table list_column_grn list_column_style3_grn" style="min-width:300px; width:auto">
        <tr>
            <th class="nowrap-grn">{cb_msg module='grn.system.application' key='GRN_SY_AP-53' replace='true'}</th>
            <th class="nowrap-grn" style="width:30%; text-align:center;">{cb_msg module='grn.system.application' key='GRN_SY_AP-103' replace='true'}</th>
            {if $can_use_external_access}
            <th class="nowrap-grn" style="width:30%; text-align:center;">{cb_msg module='grn.system.application' key='GRN_SY_AP-104' replace='true'}</th>
            {/if}
        </tr>
        {foreach from=$app_list key=item_key item=item}
        <tr>
            <td class="nowrap-grn"><div class="{$item.app_id}1"></div>{grn_appname app_id=$item_key}</td>
            <td style="text-align:center;">
                {grn_checkbox name='appIds[]' id=$item.app_id value=$item.app_id checked=$item.allow}
            </td>
            {if $can_use_external_access}
            <td style="text-align:center;">
                {if $item.app_id != 'cellular'}
                    {grn_checkbox name='ext_appIds[]'  id="ext_"|cat:$item.app_id value=$item.app_id checked=$item.ext_allow}
                {/if}
            </td>
            {/if}
        </tr>
        {/foreach}
    </table>
    <input type="hidden" name="id" value="{$id|escape}">
    <input type="hidden" name="type" value="{$type|escape}">
    {capture name='grn_system_GRN_SY_AP_51'}{cb_msg module='grn.system.application' key='GRN_SY_AP-51' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_system_GRN_SY_AP_51}
    {capture name='grn_system_GRN_SY_AP_52'}{cb_msg module='grn.system.application' key='GRN_SY_AP-52' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_GRN_SY_AP_52 page='system/application/availability_user_list'}
</form>
{/strip}
{include file='grn/system_footer.tpl'}

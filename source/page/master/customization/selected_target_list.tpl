{grn_load_javascript file="grn/html/component/member_add.js"}
{grn_load_javascript file="grn/html/component/member_select_list.js"}
<div class="set_sub_menu_part_grn">
    <span class="m_small">{capture name='grn_GRN_GRN_8'}{cb_msg module='grn.grn' key='GRN_GRN-8' replace='true'}{/capture}
        {grn_popup_user_select_link caption=$smarty.capture.grn_GRN_GRN_8
                                    form_name=$form_name
                                    module="customization"
                                    select_name="target_id"
                                    system=true
                                    system_display=false
                                    include_org=true
                                    width="1014"
                                    height="675"
                                    app_id=$app_id
                                    require_role_tab=true
                                    use_new_ui=true
                                    show_group_role=true
                                    require_dynamic_roles=true
                                    require_administrator_role=true
                                    ajax_url="grn/ajax/get_selected_target_list"
                                    selected_tid=$selected_tid}
    </span>
</div>
<table id="target_id" class="list_column">
    <tr class="js_row_header">
        <th style="min-width:505px;">{cb_msg module='grn.grn' key='GRN_GRN-471' replace='true'}</th>
        <th class="move_list_action_grn"></th>
    </tr>
    {foreach from=$customization_targets item=item}
        <tr class="js_row_item">
            {if 'user' == $item.type}
                {capture name='grn_get_group_path_string_eid'}u_{$item.tid}{/capture}
                <td>{grn_user_name uid=$item.tid users_info=$users_info}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}</td>
            {elseif 'group' == $item.type}
                {capture name='grn_get_group_path_string_eid'}o_{$item.tid}{/capture}
                <td>{grn_organize_name gid=$item.tid}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}</td>
            {elseif 'static_role' == $item.type}
                <td>{grn_image image='role20.gif'}{grn_role_name rid=$item.tid}</td>
            {elseif 'dynamic_role' == $item.type}
                <td>{grn_image image='role20.gif'}{$item.tid|escape}</td>
            {/if}
            <td class="move_list_action_grn"></td>
        </tr>
    {/foreach}
</table>
<input type="hidden" name="selected_users_sUID" value="{$customization_targets_value.user}">
<input type="hidden" name="selected_groups_UID" value="{$customization_targets_value.group}">
<input type="hidden" name="selected_roles_UID" value="{$customization_targets_value.static_role}">
<input type="hidden" name="selected_dynamic_roles_UID" value="{$customization_targets_value.dynamic_role}">
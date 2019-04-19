{strip}
    <table width="100%">
        <tr valign="top">
            <td>
                <div class="mBottom5 nowrap-grn">
                    <span class="mRight20">
                        {if $facility_name}
                            {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-621' replace='true'}
                            {grn_image image='facility20.gif'}
                            <span class="bold_grn">{$facility_name|escape}</span>
                        {else}
                            {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-620' replace='true'}
                            {grn_image image='facilitygroup20.gif'}
                            <span class="bold_grn">{$facility_group_name|escape}</span>
                        {/if}
                        {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-622' replace='true'}
                    </span>
                    <a class="icon-blankB-grn" target="_blank" href="{grn_pageurl page='/schedule/system/facility_group_privilege_list' nid=$parent_facility_group_id reset='1'}">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-309' replace='true'}</a>
                </div>
                <table width="100%">
                    <tr valign="top">
                        <td>
                            <table class="admin_list_table">
                                {foreach from=$facility_group_info item=facility_group}
                                    {if count($facility_group.privilege_list) > 0}
                                        <tr>
                                            <th nowrap="">
                                            <span class="font_normal_grn">
                                                {if $facility_group.id == $parent_facility_group_id}
                                                    {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-609' replace='true'}
                                                {else}
                                                    {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-623' replace='true'}
                                                {/if}
                                                <span class="bold_grn">{$facility_group.name|escape}</span>
                                                {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-624' replace='true'}
                                            </span>
                                            </th>
                                        </tr>
                                        {foreach from=$facility_group.privilege_list item=item}
                                            <tr valign="middle">
                                                {if 'user' == $item.type}
                                                    {capture name='grn_get_group_path_string_eid'}u_{$item.tid}{/capture}
                                                    <td class="m_small">{grn_user_name uid=$item.tid users_info=$users_info}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}</td>
                                                {elseif 'group' == $item.type}
                                                    {capture name='grn_get_group_path_string_eid'}o_{$item.tid}{/capture}
                                                    <td class="m_small">{grn_organize_name gid=$item.tid}{grn_get_group_path_string eid=$smarty.capture.grn_get_group_path_string_eid}</td>
                                                {elseif 'static_role' == $item.type}
                                                    <td class="m_small">{grn_image image='role20.gif'}{grn_role_name rid=$item.tid}</td>
                                                {elseif 'dynamic_role' == $item.type}
                                                    <td class="m_small">{grn_image image='role20.gif'}{$item.tid|escape}</td>
                                                {/if}
                                            </tr>
                                        {/foreach}
                                    {/if}
                                {/foreach}
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
{/strip}
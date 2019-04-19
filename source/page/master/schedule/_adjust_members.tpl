{strip}
    {foreach name='member' from=$selected_members key=key item=item}
        {grn_schedule_member_name id=$key groups_info=$groups_info referer_key=$referer_key nolink=TRUE users_info=$users_info}
            {if (mb_substr( $key, 0, 1 ) == 'g' && $group_access_list.$key.add == GRN_SCHD_ACCESS_DENY) || (is_numeric($key) && $user_access_list.$key.add == GRN_SCHD_ACCESS_DENY)}
                <span class="small">
                    <span class="font_red">{cb_msg module='grn.schedule' key='GRN_SCH-521' replace='true'}</span>
                </span>
            {/if}
    {/foreach}
{/strip}
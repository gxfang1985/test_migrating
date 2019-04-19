{if $user_id}
    {cb_msg module='grn.presence.system' key='GRN_PRSC_SY-13' replace='true'}<span class="bold">{grn_user_name uid=$user_id}</span>{cb_msg module='grn.presence.system' key='GRN_PRSC_SY-14' replace='true'}
{else} {**GROUP**}
    {cb_msg module='grn.presence.system' key='GRN_PRSC_SY-15' replace='true'}<span class="bold">{grn_organize_name gid=$org_id}</span>{cb_msg module='grn.presence.system' key='GRN_PRSC_SY-16' replace='true'}
{/if}
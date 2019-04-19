{if $target == 'role'}
{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-44' replace='true'}<span class="bold">{grn_image image='role20.gif'}{grn_role_name rid=$role_id}</span>{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-45' replace='true'}
{elseif $user_id}
{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-46' replace='true'}<span class="bold">{grn_user_name uid=$user_id}</span>{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-47' replace='true'}
{else}
{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-48' replace='true'}<span class="bold">{grn_organize_name gid=$org_id}</span>{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-49' replace='true'}
{/if}

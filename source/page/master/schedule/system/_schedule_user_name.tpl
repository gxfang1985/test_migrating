{if $target == 'facility'}
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-292' replace='true'}<span class="bold">{grn_image image='facility20.gif'}{$facility.name|escape}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-293' replace='true'}
{elseif $target == 'facilitygroup'}
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-294' replace='true'}<span class="bold">{grn_image image='facilitygroup20.gif'}{$facilitygroup.name|escape}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-295' replace='true'}
{elseif $target == 'role'}
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-296' replace='true'}<span class="bold">{grn_image image='role20.gif'}{grn_role_name rid=$role_id}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-297' replace='true'}
{elseif $user_id}
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-298' replace='true'}<span class="bold">{grn_user_name uid=$user_id}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-299' replace='true'}
{else}
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-300' replace='true'}<span class="bold">{grn_organize_name gid=$org_id}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-301' replace='true'}
{/if}

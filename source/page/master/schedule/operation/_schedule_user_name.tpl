{if $target == 'facility'}
{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-116' replace='true'}<span class="bold">{grn_image image='facility20.gif'}{$facility.name|escape}</span>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-117' replace='true'}
{elseif $target == 'role'}
{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-118' replace='true'}<span class="bold">{grn_image image='role20.gif'}{grn_role_name rid=$role_id}</span>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-119' replace='true'}
{elseif $user_id}
{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-120' replace='true'}<span class="bold">{grn_user_name uid=$user_id}</span>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-121' replace='true'}
{elseif $target == 'facilitygroup'}
{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-122' replace='true'}<span class="bold">{grn_image image='facilitygroup20.gif'}{$facilitygroup.name|escape}</span>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-123' replace='true'}
{else}
{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-124' replace='true'}<span class="bold">{grn_organize_name gid=$org_id}</span>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-125' replace='true'}
{/if}

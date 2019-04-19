<div id="main_menu_part" style="margin-top: 5px; margin-bottom: 10px;">

<span class="menu_item">
  {capture name='grn_schedule_operation_GRN_SCH_OP_126'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-126' replace='true'}{/capture}{grn_link image='facility20.gif' page='schedule/operation/facility_add' fagid=$org_id caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_126}
</span>

{if $enable_facility_group_add}
<span class="menu_item">
  {capture name='grn_schedule_operation_GRN_SCH_OP_127'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-127' replace='true'}{/capture}{grn_link class='menu_item' image='facilitygroup20.gif' page='schedule/operation/facility_group_add' fagid=$org_id caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_127}
</span>
{else}
  {grn_image image='facilitygroup20.gif'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-128' replace='true'}
{/if}

{if $enable_facility_order_menu}
  <span class="menu_item">
    {capture name='grn_schedule_operation_GRN_SCH_OP_129'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-129' replace='true'}{/capture}{grn_link image='order20.gif' page='schedule/operation/facility_affiliation_order' fagid=$org_id caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_129}
  </span>
{else}
  {grn_image image='order20.gif'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-130' replace='true'}
{/if}

{if $enable_facility_group_order_menu}
  <span class="menu_item">
    {capture name='grn_schedule_operation_GRN_SCH_OP_131'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-131' replace='true'}{/capture}{grn_link image='order20.gif' page='schedule/operation/facility_group_order' fagid=$org_id caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_131}
  </span>
{else}
  {grn_image image='order20.gif'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-132' replace='true'}
{/if}

</div>

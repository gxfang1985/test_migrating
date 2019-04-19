<div id="main_menu_part" style="margin-top: 5px; margin-bottom: 10px;">

<span class="menu_item">
  {capture name='grn_schedule_system_GRN_SCH_SY_302'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-302' replace='true'}{/capture}{grn_link image='facility20.gif' page='schedule/system/facility_add' fagid=$org_id caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_302 element_id="schedule/system/facility_add"}
</span>

{if $enable_facility_group_add}
<span class="menu_item">
  {capture name='grn_schedule_system_GRN_SCH_SY_303'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-303' replace='true'}{/capture}{grn_link image='facilitygroup20.gif' page='schedule/system/facility_group_add' fagid=$org_id caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_303 element_id="schedule/system/facility_group_add"}
</span>
{else}
<span class="menu_item">
  <nobr>{grn_image image='facilitygroup20.gif'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-304' replace='true'}</nobr>
</span>
{/if}

{if $show_facility_order_menu}
  {if $enable_facility_order_menu}
<span class="menu_item">
  {capture name='grn_schedule_system_GRN_SCH_SY_305'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-305' replace='true'}{/capture}{grn_link image='order20.gif' page='schedule/system/facility_order' fagid=$org_id caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_305 element_id="schedule/system/facility_order"}
</span>
  {else}
<span class="menu_item">
  <nobr>{grn_image image='order20.gif'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-306' replace='true'}</nobr>
</span>
  {/if}
{/if}

{if $show_facility_group_order_menu}
  {if $enable_facility_group_order_menu}
<span class="menu_item">
  {capture name='grn_schedule_system_GRN_SCH_SY_307'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-307' replace='true'}{/capture}{grn_link image='order20.gif' page='schedule/system/facility_group_order' fagid=$org_id caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_307 element_id="schedule/system/facility_order"}
</span>
  {else}
<span class="menu_item">
  <nobr>{grn_image image='order20.gif'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-308' replace='true'}</nobr>
</span>
  {/if}
{/if}

{if $show_operation_menu}
<span class="menu_item">
  {capture name='grn_schedule_system_GRN_SCH_SY_309'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-309' replace='true'}{/capture}{grn_link image='manage20.gif' page='schedule/system/facility_group_privilege_list' nid=$org_id reset=1 caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_309 element_id="schedule/system/facility_group_privilege_list"}
</span>
{/if}

</div>
{if $top}
	{cb_msg module='grn.system.user' key='GRN_SY_US-690' replace='true'}<br>
{/if}

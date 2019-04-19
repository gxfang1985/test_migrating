{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul style="line-height:2em">
<li>{capture name='grn_schedule_system_GRN_SCH_SY_67'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-67' replace='true'}{/capture}{grn_link image='import20.gif' page='schedule/system/import1' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_67}</li>
<li><span class="sub_title">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-68' replace='true'}</span></li>
 <ul>
 <li>{capture name='grn_schedule_system_GRN_SCH_SY_562'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-562' replace='true'}{/capture}{grn_link image='import20.gif' page='schedule/system/facility_import1' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_562}</li>
 <li>{capture name='grn_schedule_system_GRN_SCH_SY_563'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-563' replace='true'}{/capture}{grn_link image='import20.gif' page='schedule/system/facility_name_import1' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_563}</li>
 </ul>
<li><span class="sub_title">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-69' replace='true'}</span></li>
 <ul>
 <li>{capture name='grn_schedule_system_GRN_SCH_SY_564'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-564' replace='true'}{/capture}{grn_link image='import20.gif' page='schedule/system/facilitygroup_import1' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_564}</li>
 <li>{capture name='grn_schedule_system_GRN_SCH_SY_565'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-565' replace='true'}{/capture}{grn_link image='import20.gif' page='schedule/system/facilitygroup_name_import1' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_565}</li>
 </ul>
<!-- IE bug add style="margin:8px 0;" -->
<li style="margin:8px 0;">{capture name='grn_schedule_system_GRN_SCH_SY_70'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-70' replace='true'}{/capture}{grn_link image='import20.gif' page='schedule/system/access_import1' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_70}</li>
<li style="margin:8px 0;">{capture name='grn_schedule_system_GRN_SCH_SY_663'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-663' replace='true'}{/capture}{grn_link image='import20.gif' page='schedule/system/default_public_import1' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_663}</li>
</ul>

{include file="grn/system_footer.tpl"}

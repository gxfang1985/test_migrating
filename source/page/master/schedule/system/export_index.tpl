{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul style="line-height:2em">
<li>{capture name='grn_schedule_system_GRN_SCH_SY_284'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-284' replace='true'}{/capture}{grn_link image='export20.gif' page='schedule/system/export1' reset=1 caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_284}</li>
<li><span class="sub_title">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-285' replace='true'}</span></li>
 <ul>
 <li>{capture name='grn_schedule_system_GRN_SCH_SY_562'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-562' replace='true'}{/capture}{grn_link image='export20.gif' page='schedule/system/facility_export' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_562}</li>
 <li>{capture name='grn_schedule_system_GRN_SCH_SY_563'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-563' replace='true'}{/capture}{grn_link image='export20.gif' page='schedule/system/facility_name_export' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_563}</li>
 </ul>
<li><span class="sub_title">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-286' replace='true'}</span></li>
 <ul>
 <li>{capture name='grn_schedule_system_GRN_SCH_SY_564'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-564' replace='true'}{/capture}{grn_link image='export20.gif' page='schedule/system/facilitygroup_export' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_564}</li>
 <li>{capture name='grn_schedule_system_GRN_SCH_SY_565'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-565' replace='true'}{/capture}{grn_link image='export20.gif' page='schedule/system/facilitygroup_name_export' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_565}</li>
 </ul>
<!-- IE bug add style="margin:8px 0;" -->
<li style="margin:8px 0;">{capture name='grn_schedule_system_GRN_SCH_SY_287'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-287' replace='true'}{/capture}{grn_link image='export20.gif' page='schedule/system/access_export' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_287}</li>
<li style="margin:8px 0;">{capture name='grn_schedule_system_GRN_SCH_SY_669'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-669' replace='true'}{/capture}{grn_link image='export20.gif' page='schedule/system/default_public_export' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_669}</li>
</ul>

{include file="grn/system_footer.tpl"}

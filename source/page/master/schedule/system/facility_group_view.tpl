{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$facility_group.title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_schedule_system_GRN_SCH_SY_480'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-480' replace='true'}{/capture}{grn_link page='schedule/system/facility_group_modify' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_480 image='modify20.gif' fagid=$facility_group.fagid}
<span class="menu_item">{if $is_movable }{capture name='grn_schedule_system_GRN_SCH_SY_481'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-481' replace='true'}{/capture}{grn_link page='schedule/system/facility_group_parent_modify' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_481 image='facilitygroup20.gif' fagid=$facility_group.fagid}{else}{capture name='grn_schedule_system_GRN_SCH_SY_482'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-482' replace='true'}{/capture}{grn_link page='schedule/system/facility_group_parent_modify' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_482 image='facilitygroup20.gif' fagid=$facility_group.fagid disabled=1}{/if}
<span class="menu_item">{capture name='grn_schedule_system_GRN_SCH_SY_483'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-483' replace='true'}{/capture}{grn_link page='schedule/system/facility_group_delete' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_483 image='delete20.gif' fagid=$facility_group.fagid}
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-484' replace='true'}</th>
  <td>{$facility_group.title|escape}</td>
 </tr>

 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-485' replace='true'}
  </th>
  <td>
      {$facility_group.code|escape}
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-486' replace='true'}
  </th>
  <td>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-487' replace='true'}{foreach from=$facility_group.ancestors item=facility} > {grn_sentence caption=$facility.title class='facility20'}{/foreach}<br>
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-488' replace='true'}
  </th>
  <td>
      {$facility_group.memo|escape}
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-489' replace='true'}
  </th>
  <td>
      {foreach from=$facility_group.facility item=facility}{grn_sentence caption=$facility.title class='facility20'}<br>{/foreach}
  </td>
 </tr>
 
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-490' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$facility_group.creator_uid name=$facility_group.creator_name}
       {grn_date_format date=$facility_group.ctime format="DateTimeCompact"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-491' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$facility_group.modify_uid name=$facility_group.modify_name}
       {grn_date_format date=$facility_group.mtime format="DateTimeCompact"}
  </td>
 </tr>
</table>

{include file='grn/system_footer.tpl'}

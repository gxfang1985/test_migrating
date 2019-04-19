{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$facility_group.title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_schedule_operation_GRN_SCH_OP_176'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-176' replace='true'}{/capture}{grn_link page='schedule/operation/facility_group_modify' caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_176 image='modify20.gif' fagid=$facility_group.fagid}
<span class="menu_item">{if $is_movable }{capture name='grn_schedule_operation_GRN_SCH_OP_177'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-177' replace='true'}{/capture}{grn_link page='schedule/operation/facility_group_parent_modify' caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_177 image='facilitygroup20.gif' fagid=$facility_group.fagid}{else}{capture name='grn_schedule_operation_GRN_SCH_OP_178'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-178' replace='true'}{/capture}{grn_link page='schedule/operation/facility_group_parent_modify' caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_178 image='facilitygroup20.gif' fagid=$facility_group.fagid disabled=1}{/if}
<span class="menu_item">{capture name='grn_schedule_operation_GRN_SCH_OP_179'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-179' replace='true'}{/capture}{grn_link page='schedule/operation/access_list' caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_179 image='access20.gif' tid='facilitygroup' reset='1' fagid=$facility_group.fagid}</span>
<span class="menu_item">{capture name='grn_schedule_operation_GRN_SCH_OP_180'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-180' replace='true'}{/capture}{grn_link page='schedule/operation/facility_group_delete' caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_180 image='delete20.gif' tid='facilitygroup' reset='1' fagid=$facility_group.fagid}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-181' replace='true'}</th>
  <td>{$facility_group.title|escape}</td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-182' replace='true'}
  </th>
  <td>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-183' replace='true'}{foreach from=$facility_group.ancestors item=facility} > {grn_sentence caption=$facility.title class='facility20'}{/foreach}<br>
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-184' replace='true'}
  </th>
  <td>
      {$facility_group.memo|escape}
  </td>
 </tr>

 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-185' replace='true'}
  </th>
  <td>
      {foreach from=$facility_group.facility item=facility}{grn_sentence caption=$facility.title class='facility20'}<br>{/foreach}
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-186' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$facility_group.creator_uid name=$facility_group.creator_name}
       {grn_date_format date=$facility_group.ctime format="DateTimeCompact"}
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-187' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$facility_group.modify_uid name=$facility_group.modify_name}
       {grn_date_format date=$facility_group.mtime format="DateTimeCompact"}
  </td>
 </tr>
</table>

{include file='grn/footer.tpl'}

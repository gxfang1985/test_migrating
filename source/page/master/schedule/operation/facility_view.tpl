{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$facility.title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_schedule_operation_GRN_SCH_OP_145'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-145' replace='true'}{/capture}{grn_link page='schedule/operation/facility_modify' caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_145 image='modify20.gif' fagid=$facility.fagid faid=$facility.faid}</span>
<span class="menu_item">{capture name='grn_schedule_operation_GRN_SCH_OP_146'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-146' replace='true'}{/capture}{grn_link page='schedule/operation/access_list' caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_146 image='access20.gif' tid='facility' reset='1' fagid=$facility.fagid faid=$facility.faid}</span>
<span class="menu_item">{capture name='grn_schedule_operation_GRN_SCH_OP_147'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-147' replace='true'}{/capture}{grn_link page='schedule/operation/facility_parent_modify' caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_147 image='facilitygroup20.gif' fid=$facility.faid}
<span class="menu_item">{capture name='grn_schedule_operation_GRN_SCH_OP_148'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-148' replace='true'}{/capture}{grn_link page='schedule/operation/facility_delete' caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_148 image='delete20.gif' fagid=$facility.fagid faid=$facility.faid}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-149' replace='true'}
  </th>
  <td>
      {$facility.title|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-150' replace='true'}
  </th>
  <td>
      {$facility.code|escape}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-151' replace='true'}
  </th>
  <td>
      {grn_format body=$facility.memo}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-152' replace='true'}
  </th>
  <td>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-153' replace='true'}
      {foreach from=$facility.ancestors item=group} &gt; {$group.title} {/foreach}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-154' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$facility.creator_uid name=$facility.creator_name}
       {grn_date_format date=$facility.ctime format="DateTimeCompact"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-155' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$facility.modify_uid name=$facility.modify_name}
       {grn_date_format date=$facility.mtime format="DateTimeCompact"}
  </td>
 </tr>
</table>
{*--- add VCBSCH0010 ---s*}
{if $netmeeting.system_available}
<table class="std_form">
 <tr>
  <td colspan="2"><br><div class="sub_title">{cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-21' replace='true'}</div></td>
 </tr>
</table>
<table class="view_table">
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-22' replace='true'}
  </th>
  <td>
      {if $netmeeting.available}
        {cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-31' replace='true'}
      {else}
        {cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-24' replace='true'}
      {/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.netmeeting' key='GRN_VCB_SY-25' replace='true'}
  </th>
  <td>
    {$netmeeting.guests_normal_limit}
  </td>
 </tr>
</table>
{/if}
{*--- add VCBSCH0010 ---e*}

{include file='grn/footer.tpl'}

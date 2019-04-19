{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$facility.title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_schedule_system_GRN_SCH_SY_336'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-336' replace='true'}{/capture}{grn_link page='schedule/system/facility_modify' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_336 image='modify20.gif' faid=$facility.faid}</span>
<span class="menu_item">{capture name='grn_schedule_system_GRN_SCH_SY_337'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-337' replace='true'}{/capture}{grn_link page='schedule/system/facility_parent_modify' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_337 image='facilitygroup20.gif' fid=$facility.faid}
<span class="menu_item">{capture name='grn_schedule_system_GRN_SCH_SY_338'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-338' replace='true'}{/capture}{grn_link page='schedule/system/facility_delete' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_338 image='delete20.gif' faid=$facility.faid}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-339' replace='true'}
  </th>
  <td>
      {$facility.title|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-340' replace='true'}
  </th>
  <td>
      {$facility.code|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-341' replace='true'}
  </th>
  <td>
      {$facility.memo|escape|nl2br}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-342' replace='true'}
  </th>
  <td>
      {if $facility.ancestors}
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-343' replace='true'}
      {foreach from=$facility.ancestors item=group} &gt; {$group.title} {/foreach}
      {else}
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-344' replace='true'}
      {/if}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-345' replace='true'}
  </th>
  <td>
       {grn_user_name uid=$facility.creator_uid name=$facility.creator_name}
       {grn_date_format date=$facility.ctime format="DateTimeCompact"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-346' replace='true'}
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

{include file="grn/system_footer.tpl"}

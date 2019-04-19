{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$menupage.title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_schedule_system_GRN_SCH_SY_411'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-411' replace='true'}{/capture}{grn_link page='schedule/system/menupage_modify' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_411 image='modify20.gif' menupageid=$menupage.id}</span>
<span class="menu_item">{capture name='grn_schedule_system_GRN_SCH_SY_412'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-412' replace='true'}{/capture}{grn_link page='schedule/system/menupage_delete' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_412 image='delete20.gif' menupageid=$menupage.id}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-413' replace='true'}
  </th>
  <td>
      {$menupage.title|escape}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-414' replace='true'}
  </th>
  <td>
      {$menupage.data|escape|nl2br}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-415' replace='true'}
  </th>
  <td>
      {grn_user_name uid=$menupage.creator_uid name=$menupage.creator_name}
      {* 時間の表示 *}{grn_date_format date=$menupage.ctime}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-416' replace='true'}
  </th>
  <td>
      {grn_user_name uid=$menupage.modify_uid name=$menupage.modify_name}
      {* 時間の表示 *}{grn_date_format date=$menupage.mtime}
  </td>
 </tr>
</table>

{include file='grn/system_footer.tpl'}

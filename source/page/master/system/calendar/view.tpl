{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_calendar_GRN_SY_CA_4'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-4' replace='true'}{/capture}{grn_link image='modify20.gif' page='system/calendar/modify' scid=$calendar.id caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_4}</span>
<span class="menu_item">{capture name='grn_system_calendar_GRN_SY_CA_5'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-5' replace='true'}{/capture}{grn_link image='delete20.gif' page='system/calendar/delete' scid=$calendar.id caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_5}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-6' replace='true'}</th>
  <td>{$calendar.title|escape}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.calendar' key='calendar_code' replace='true'}</th>
  <td>{$calendar.code|escape}</td>
 </tr>

</table>

{include file='grn/system_footer.tpl'}

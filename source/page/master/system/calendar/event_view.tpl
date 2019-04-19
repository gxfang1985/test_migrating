{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_system_calendar_GRN_SY_CA_18'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-18' replace='true'}{/capture}{grn_link page='system/calendar/event_modify' caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_18 image='modify20.gif' event=$calendar.event.id scid=$calendar.id}</span>
<span class="menu_item">{capture name='grn_system_calendar_GRN_SY_CA_19'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-19' replace='true'}{/capture}{grn_link page='system/calendar/event_delete' caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_19 image='delete20.gif' event=$calendar.event.id scid=$calendar.id}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-20' replace='true'}</th>
  <td>{grn_date_format date=$calendar.event.date format="DateLong_YMDW"}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-21' replace='true'}</th>
  <td>{$calendar.event.type|escape}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-22' replace='true'}</th>
  <td>{$calendar.event.detail|escape|nl2br}</td>
 </tr>
</table>

{include file='grn/system_footer.tpl'}

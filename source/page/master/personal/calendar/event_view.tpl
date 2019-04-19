{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
{grn_title title=$page_title class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_personal_calendar_GRN_PRS_CA_36'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-36' replace='true'}{/capture}{grn_link page='personal/calendar/event_modify' caption=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_36 image='modify20.gif' event=$calendar.event.id}</span>
<span class="menu_item" >{capture name='grn_personal_calendar_GRN_PRS_CA_37'}{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-37' replace='true'}{/capture}{grn_link id='lnk_delete' page='personal/calendar/event_delete' caption=$smarty.capture.grn_personal_calendar_GRN_PRS_CA_37 image='delete20.gif' event=$calendar.event.id script="javascript:void(0);"}</span>
</div>

<p>
<table class="view_table">
 <tr>
  <th nowrap>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-38' replace='true'}</th>
  <td>{grn_date_format date=$calendar.event.date format="DateLong_YMDW"}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-39' replace='true'}</th>
  <td>{$calendar.event.type|escape}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-40' replace='true'}</th>
  <td>{$calendar.event.detail|escape|nl2br}</td>
 </tr>
</table>

{include file='grn/personal_footer.tpl'}

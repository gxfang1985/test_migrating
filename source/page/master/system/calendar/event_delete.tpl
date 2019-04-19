{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/calendar/command_event_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-87' replace='true'}<span class="bold">{grn_date_format date=$calendar.event.date format="DateLong_YMDW"}</span>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-88' replace='true'}<span class="bold">{$calendar.event.detail}</span>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-89' replace='true'}</p>
 <p>
  {capture name='grn_system_calendar_GRN_SY_CA_90'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-90' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_90}
  {capture name='grn_system_calendar_GRN_SY_CA_91'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-91' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_91}
 </p>
<input type="hidden" name="scid" value="{$calendar.id}">
<input type="hidden" name="event" value="{$calendar.event.id}">
</form>
{include file='grn/system_footer.tpl'}

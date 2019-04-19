<form name="personal/calendar/event_delete" method="post" action="{grn_pageurl page='personal/calendar/command_event_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-57' replace='true'}<br>
 {cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-58' replace='true'}<span class="bold">{grn_date_format date=$calendar.event.date format="DateLong_YMDW"}</span><br>
 {cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-59' replace='true'}<span class="bold">{$calendar.event.detail}</span><br>
 </p>
 <input type="hidden" name="event" value="{$calendar.event.id}">
</form>

<form name="personal/calendar/event_delete_all" method="post" action="{grn_pageurl page='personal/calendar/command_event_delete_all'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="bdate" value="{$bdate}">
 <p>{cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-1' replace='true'}<br>
 {cb_msg module='grn.personal.calendar' key='GRN_PRS_CA-2' replace='true'}<span class="bold delete_count"></span><br>
 </p>
</form>

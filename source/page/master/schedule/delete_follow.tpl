<form name="schedule/delete_follow" method="post" action="{grn_pageurl page='schedule/command_delete_follow'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn' key='grn.comment.delete.confirm' replace='true'}<br>
 {cb_msg module='grn.schedule' key='GRN_SCH-216' replace='true'}<span class="bold" id="msgbox_follow"></span>{cb_msg module='grn.schedule' key='GRN_SCH-217' replace='true'}
 </p>
<input type="hidden" name="event" value="{$schedule_event.event_id}">
<input type="hidden" name="uid" value="{$schedule_event.user_id}">
<input type="hidden" name="gid" value="{$group_id}">
<input type="hidden" name="bdate" value="{$bdate}">
<input type="hidden" name="referer_key" value="{$referer_key}">
</form>

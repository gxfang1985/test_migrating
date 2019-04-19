{* GTM-1136 *}
<form name="schedule/file_delete" method="post" action="{grn_pageurl page='schedule/command_file_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.schedule' key='GRN_SCH-947' replace='true'}<br>
 {grn_sentence caption=$file.filename|cb_mb_truncate image='file20.gif' class='bold'}<br>
 </p>
<input type="hidden" name="event" value="{$event_id}">
<input type="hidden" name="fid" value="{$file.id}">
</form>
<form name="file/delete" method="post" action="{grn_pageurl page='space/command_file_delete'}">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>{cb_msg module='grn.space.file' key='GRN_SP_FILE-11' replace='true'}<br>
{grn_image image='file20.gif'}<span class="bold">{$title|cb_mb_truncate|escape}</span></p>
<input type="hidden" name="spid" value="{$space_id}">
<input type="hidden" name="tid"  value="{$thread_id}">
<input type="hidden" name="tdid" value="{$todo_id}">
<input type="hidden" name="fid"  value="{$file_id}">
<input type="hidden" name="type" value="{$file_type}">
<input type="hidden" name="from" value="{$from}">
</form>
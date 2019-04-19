<form name="message/file_delete" method="post" action="{grn_pageurl page='message/command_file_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>{cb_msg module='grn.message' key='GRN_MSG-77' replace='true'}<br>
{grn_sentence caption=$file.filename|cb_mb_truncate image='file20.gif' class='bold'}
</p>
<input type="hidden" name="cid" value="{$cid}">
<input type="hidden" name="rid" value="{$rid}">
<input type="hidden" name="mid" value="{$mid}">
<input type="hidden" name="rfid" value="{$rfid}">
<input type="hidden" name="frm" value="{$frm}">
</form>

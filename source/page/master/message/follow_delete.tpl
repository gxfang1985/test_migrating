<form name="message/follow_delete" method="post" action="{grn_pageurl page='message/command_follow_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn' key='grn.comment.delete.confirm' replace='true'}</p>
 <p>
 {cb_msg module='grn.message' key='GRN_MSG-75' replace='true'}<span class="bold" id="msgbox_follow"></span>{cb_msg module='grn.message' key='GRN_MSG-76' replace='true'}</p>
<input type="hidden" name="cid" value="{$cid}">
<input type="hidden" name="rid" value="{$rid}">
<input type="hidden" name="mid" value="{$mid}">
</form>

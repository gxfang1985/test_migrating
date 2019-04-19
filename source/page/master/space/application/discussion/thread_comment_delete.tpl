<form name="thread/comment_delete" method="post" action="{grn_pageurl page='space/application/discussion/command_comment_delete'}">
  <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <input type="hidden" id="cmid" name="cmid" value="{$comment.id}">
  <input type="hidden" id="threadid" name="tid" value="{$thread_id}">
  <input type="hidden" id="spaceid" name="spid" value="{$space_id}">
  {cb_msg module='grn.space.discussion' key='GRN_SP_DISC-25' replace='true'}<br>
  <span id="msgbox_follow" class="bold"></span>
</form>
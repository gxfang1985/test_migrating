<form name="todo/comment_delete" method="post" action="{grn_pageurl page='space/application/todo/command_comment_delete'}">
  <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
  <input type="hidden" id="cmid" name="cmid" value="{$comment.id}">
  <input type="hidden" id="tdid" name="tdid" value="{$comment.todo_id}">
  <input type="hidden" id="spaceid" name="spid" value="{$space_id}">
  <input type="hidden" name="from" value="{$from}">
  {cb_msg module='grn.space.todo' key='GRN_SP_TOD-55' replace='true'}<br>
  <span id="msgbox_follow" class="bold"></span>
</form>
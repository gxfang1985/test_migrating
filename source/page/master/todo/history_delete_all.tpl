<form name="todo/history_delete_all" method="post" action="{grn_pageurl page='todo/command_history_delete_all'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.todo' key='GRN_TOD-63' replace='true'}</p>
<input type="hidden" name="tid" value="{$todo.tid}">
</form>

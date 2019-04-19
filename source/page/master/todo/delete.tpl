<form name="todo/delete" method="post" action="{grn_pageurl page='todo/command_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.todo' key='GRN_TOD-28' replace='true'}<br>
 {grn_image image='todo20.gif'}<span class="bold">{$todo.title|cb_mb_truncate|escape}</span>
 </p>
<input type="hidden" name="tid" value="{$todo.tid}">
</form>

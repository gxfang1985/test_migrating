<form name="todo/delete" method="post" action="{grn_pageurl page='space/application/todo/command_delete'}">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>{cb_msg module='grn.space.todo' key='GRN_SP_TOD-16' replace='true'}<br>
{grn_image image='spaceTodo20.png'}<span class="bold">{$title|cb_mb_truncate|escape}</span></p>
<input type="hidden" name="spid" value="{$space_id}">
<input type="hidden" name="tid"  value="{$tid}">
<input type="hidden" name="tdid" value="{$todo_id}">
<input type="hidden" name="from"  value="{$from}">
</form>
 {foreach from=$expiredPersonalTodo item=todo}
   <div class="schedule_expired_todo normalEventElement" {if !$show_expired_todos }style="display:none;"{/if}> 
     {grn_image image="image-app-schedule/todoPersonalInScheduleLate16.png"}<a href="{grn_pageurl page='todo/view' tid=$todo.id}">{$todo.title|escape}</a>
   </div>
 {/foreach}
 {foreach from=$expiredSharedTodo item=todo}
    <div class="schedule_expired_todo normalEventElement" {if !$show_expired_todos }style="display:none;"{/if}>
     {grn_image image="image-app-schedule/todoShareInScheduleLate16.png"}<a href="{grn_pageurl page='space/application/todo/view' spid=$todo.space_id tdid=$todo.todo_id}">{$todo.title|escape}</a>
    </div>
 {/foreach}

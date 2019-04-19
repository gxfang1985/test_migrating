{if $event.todos}
   {foreach from=$event.todos item=todo}
      <div class="schedule_todo normalEventElement" {if !$show_todos} style="display:none;"{/if}>
          {grn_image image="image-app-schedule/todoPersonalInSchedule16.png"}<a href="{grn_pageurl page='todo/view' tid=$todo.tid}">{$todo.title|grn_noescape}</a>
       </div>
   {/foreach}
{/if}

{if $event.shared_todos}
   {foreach from=$event.shared_todos item=todo}
       <div class="schedule_todo normalEventElement" {if !$show_todos} style="display:none;"{/if}>{grn_image image="image-app-schedule/todoShareInSchedule16.png"}<a href="{grn_pageurl page='space/application/todo/view' spid=$todo.space_id tdid=$todo.todo_id}">{$todo.title|escape}</a>
       </div>
   {/foreach}
{/if}

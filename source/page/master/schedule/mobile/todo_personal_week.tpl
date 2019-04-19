{strip}
{if $show_todos}
   {foreach from=$event.todos item=todo}
      <li data-icon="false" class="mobile_list_todo_grn" >
        <span class="mobile_img_todo_share_schedule_grn"></span>
        {*no link,spec*}
        {$todo.title|grn_noescape}
       </li>
   {/foreach}
   {foreach from=$event.shared_todos item=todo}
       <li data-icon="false" class="mobile_list_todo_grn">
        <span class="mobile_img_todo_share_schedule_grn"></span>
        {*no link, spec*}
        {$todo.title|escape}
       </li>
   {/foreach}
{/if}
{/strip}

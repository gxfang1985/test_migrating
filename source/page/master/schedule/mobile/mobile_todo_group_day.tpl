{strip}
{if $show_todos}
    <ul data-role="listview" data-theme="c" class="mobile-ul-top-grn mobile-ul-bottom-grn mobile_list_normal_padding_grn">
        {if $event.todos}
           {foreach from=$event.todos item=todo}
              <li data-icon="false" class="mobile_list_todo_grn">
                <span class="mobile_img_todo_share_schedule_grn"></span>
                {$todo.title|grn_noescape}{*no link,spec*}
               </li>
           {/foreach}
        {/if}
        {if $event.shared_todos}
           {foreach from=$event.shared_todos item=todo}
               <li data-icon="false" class="mobile_list_todo_grn">
                <span class="mobile_img_todo_share_schedule_grn"></span>
                {$todo.title|escape}{*no link, spec*}
               </li>
           {/foreach}
        {/if}
        
    </ul>
{/if}
{/strip}
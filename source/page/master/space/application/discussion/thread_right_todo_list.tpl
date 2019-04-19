{if ! $todo_prefix}{assign var='todo_prefix' value='space/application/todo'}{/if}
{if $write_auth || $has_privilege}
<div class="space-addToDoBtn-grn">
  <a class="icon-add-grn" href="javascript:void(0);" onClick="grn.page.space.todo.todo.openTodoAddDialog(1);"><span>{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-10' replace='true'}</span></a>
</div>
{/if}
<ul class="space-threadRightList-todo-grn">
  {foreach from=$todo_list item=todo}
  <li class="space-todo-{$todo.status}-grn">
    <a class="space-threadRightList-cutString-grn" href="{grn_pageurl page=$todo_prefix|cat:'/view' spid=$space_id tdid=$todo.id}">
      <span class="space-threadRightList-smallFont-grn">{grn_date_format date=$todo.deadline_date format='DateShort_MD'}</span><br>
      {$todo.title|escape}
    </a>
  </li>
  {/foreach}
  <li>{capture name='grn_space_GRN_SP_DISC_18'}{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-18' replace='true'}{/capture}{grn_link page=$todo_prefix|cat:'/index' caption=$smarty.capture.grn_space_GRN_SP_DISC_18 spid=$space_id tid=$thread_id}</li>
</ul>

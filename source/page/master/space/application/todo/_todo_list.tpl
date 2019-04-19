{if $todos}
  <div class="space-todo-pager-grn">
    {capture name="navi_right"}{include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}{/capture}
    {include file="grn/smart_word_navi_350.tpl" navi=$navi.navi navi_right=$smarty.capture.navi_right}
  </div>

<div class="space-todoList-listColumn-grn">
  <table id="todos_list" width="100%">
    <colgroup>
      <col width="10px">
      <col width="20%">
      <col width="25%">
      <col width="20%">
      <col width="35%">
    </colgroup>
    <tr>
      <th nowrap align="left"></th>
      <th nowrap align="left">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-3' replace='true'}</th>
      <th nowrap align="left">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-35' replace='true'}</th>
      <th nowrap align="left">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-4' replace='true'}</th>
      {if $thread_id == null}
      <th nowrap align="left">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-56' replace='true'}</th>
      {else}
      <th nowrap align="left">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-37' replace='true'}</th>
      {/if}
    </tr>
    {foreach from=$todos item=todo}
    <tr class="{cycle values='linetwo,lineone'}">
      <td {if $todo_status != $is_completed}class="space-todo-{$todo.status}-grn"{/if}></td>
      <td {if $todo_status != $is_completed}class="space-todo-list-{$todo.status}-grn"{/if}>{if $todo.deadline != null}{grn_date_format date=$todo.deadline format='DateShort_MD'}{else}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-42' replace='true'}{/if}</td>
      <td {if $todo_status != $is_completed}class="space-todo-list-{$todo.status}-grn"{/if}><a href="{grn_pageurl page=$todo_prefix|cat:'/view' spid=$space_id tdid=$todo.id from=$from_todo_index}" id="todo_{$todo.id}" class="">{$todo.title|escape}</a></td>
      <td>{if $todo.user_number < 0}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-47' replace='true'}{else}{grn_space_user_link user=$todo.user}{if $todo.user_number > 0}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-43' replace='true'}{$todo.user_number}{if $todo.user_number > 1}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-59' replace='true'}{else}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-61' replace='true'}{/if}{/if}{/if}</td>
      {if $thread_id == null}
      <td><a href="{grn_pageurl page=$discussion_prefix|cat:'/index' spid=$space_id fragment='tid='|cat:$todo.thread_id}" id="thread_{$todo.thread_id}" name="system_thread" class="">{$todo.thread_name|escape}</a></td>
      {else}
      <td>{$todo.content|escape}</td>
      {/if}
    </tr>
    {/foreach}
  </table>
</div>

  <div class="space-todo-pager-grn">
    {capture name="navi_right"}{include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}{/capture}
    {include file="grn/smart_word_navi_350.tpl" navi=$navi.navi navi_right=$smarty.capture.navi_right}
  </div>
{/if}

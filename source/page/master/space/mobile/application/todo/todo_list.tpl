{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var='is_completed' value='1'}
{foreach from=$todos item=todo}
  {if $todo_status == $is_completed}
    {assign var=date_class value=mobile-label-normal-grn}
    {assign var=title_class value=mobile-label-normal-grn}
  {else}
    {if $todo.status == 'late'}
      {assign var=date_class value=mobile-label-late-grn}
      {assign var=title_class value=mobile-label-late-grn}
    {elseif $todo.status == 'noTerm'}
      {assign var=date_class value=mobile-label-small-grn}
      {assign var=title_class value=mobile-label-normal-grn}
    {else}
      {assign var=date_class value=mobile-label-normal-grn}
      {assign var=title_class value=mobile-label-normal-grn}
    {/if}
  {/if}
  <li data-icon="false" class="mobile-a-list-grn ui-btn ui-btn-up-{$data_theme}" data-theme="{$data_theme}">
    <div class="mobile-todo-list-inner-grn">
      <span class="mobile-colorboard-grn {if $todo_status != $is_completed}mobile-colorboard-{$todo.status}-grn{/if}"></span>
      {if $todo.isMember_login}
        <a href="javascript:void(0);" data-id="checkbox_{$todo.id}" class="mobile-checkbox{if !$todo.isComplete_login}Off{/if}-todo-grn" onclick="grn.page.space.mobile.todo.detail.complete('{$space_id}','{$todo.id}','{$csrf_ticket}')"></a>
      {/if}
      <a href="{grn_pageurl page='space/mobile/application/todo/detail' spid=$space_id tdid=$todo.id}">
        <span class="mobile-list-contents-todo-grn">
          <div class="mobile-date-todo-grn {$date_class}">{if $todo.deadline != null}{grn_date_format date=$todo.deadline format='DateShort_MD'}{else}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-42' replace='true'}{/if}</div>
          <div class="mobile-user-todo-grn mobile-label-small-grn">{if $todo.user_number < 0}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-47' replace='true'}{else}{$todo.user->getDisplayName()|escape}{if $todo.user_number > 0}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-43' replace='true'}{$todo.user_number}{if $todo.user_number > 1}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-59' replace='true'}{else}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-61' replace='true'}{/if}{/if}{/if}</div>
          <div class="mobile-title-todo-grn {$title_class}">{$todo.title|escape}</div>
        </span>
        <span class="mobile-array-todo-grn"></span>
      </a>
    </div>
  </li>
{/foreach}
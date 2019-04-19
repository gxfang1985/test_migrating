{if $is_there_uncompleted_user}
<div class="mobile-separation-grn"></div>
<div class="mobile-list-todoDetail-grn">
  <div class="mobile-label-small-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-30' replace='true'}</div>
  <div class="mobile-contents-todoDetail-grn" id="uncompleteUsers">
    {include file="space/mobile/application/todo/_todo_users.tpl" space_member_collection=$todo_uncomplete_user_array.space_members}
  </div>
  {include file="space/mobile/application/todo/todo_users_no_space_member.tpl" name="todo_uncomplete_user"
                                                                               no_space_mamber_collection=$todo_uncomplete_user_array.no_space_members}
</div>
{/if}
{if $is_there_completed_user}
<div class="mobile-separation-grn"></div>
<div class="mobile-list-todoDetail-grn">
  <div class="mobile-label-small-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-29' replace='true'}</div>
  <div class="mobile-contents-todoDetail-grn" id="completeUsers">
    {include file="space/mobile/application/todo/_todo_users.tpl" space_member_collection=$todo_complete_user_array.space_members}
  </div>
    {include file="space/mobile/application/todo/todo_users_no_space_member.tpl" name="todo_complete_user"
                                                                                 no_space_mamber_collection=$todo_complete_user_array.no_space_members}
</div>
{/if}

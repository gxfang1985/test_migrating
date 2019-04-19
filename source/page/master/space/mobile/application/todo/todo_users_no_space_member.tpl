{*********************************************************
  @ para:$name                       string
  @ para:$no_space_mamber_collection SpaceMemberCollection
**********************************************************}
{if $no_space_mamber_collection && $no_space_mamber_collection|@count>0}

    {capture name='todo_users_no_space_member_title'}
        {cb_msg module='grn.space.todo' key='no_space_member.label' replace='true'}
    {/capture}
    {capture name='todo_users_no_space_member_contents'}
        {include file="space/mobile/application/todo/_todo_users.tpl" space_member_collection=$no_space_mamber_collection}
    {/capture}

    <div class="mobile_todo_detail_inline_grn">
        {include file="grn/mobile_expand.tpl" name=$name
                                              title=$smarty.capture.todo_users_no_space_member_title
                                              contents=$smarty.capture.todo_users_no_space_member_contents
                                              contents_class="mobile-contents-todoDetail-grn"
                                              default="close"}
    </div>

{/if}
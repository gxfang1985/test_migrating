{grn_load_javascript file="grn/html/component/space/todo_members.js"}
<script language="JavaScript" type="text/javascript">
    <!--
    new grn.component.space.todo_members.TodoMembers("{$name}");
    //-->
</script>

{if count($todo_members) > 0 }
    <div id="{$name}">
        <span class="mRight7">{$todo_members_subtotal_text}</span>
        {grn_space_todo_member_names spaceMemberCollection = $todo_members
                                     limit_display_count   = 10
                                     id                    = $name
                                     append_script_file    = false
        }
    </div>
{/if}

{if count($todo_members_no_space_members) > 0 }
    <div id="{$name}_no_space_member">
        <div class="mTop7 mBottom2">
            <span class="action_text_grn">
                <a id="{$name}_no_space_member_opener" href="javascript:void(0);">
                    {** Do not break a line for design **}
                    <span id="{$name}_no_space_member_icon_inline" class="icon_inline_grn icon_show_element_b_grn"></span><span>{cb_msg module='grn.space.todo' key='no_space_member.label' replace='true'}</span>
                </a>
            </span>
        </div>
        <div id="{$name}_no_space_member_users">
            <span class="mRight7">{$todo_members_no_space_members_subtotal_text}</span>
            {grn_space_todo_member_names spaceMemberCollection = $todo_members_no_space_members
                                         limit_display_count   = 10
                                         id                    = $name_no_space_members
                                         append_script_file    = false
            }
        </div>
    </div>
{/if}
{grn_load_javascript file="grn/html/component/space/todo_out_of_members.js"}
<script language="JavaScript" type="text/javascript">
    <!--
    new grn.component.space.todo_out_of_members.TodoOutOfMembers("{$name}","{$space_id}");
    //-->
</script>

<div id="{$name}">
    <div class="border_partition_common_dashed_grn mTop15"></div>
    <a id="{$name}_opener" href="javascript:void(0);" class="show_element_grn">
        {cb_msg module='grn.space.todo' key='no_space_member.label' replace='true'}
    </a>
    <div id="{$name}_spinner" style="width:180px; text-align:center;">
        {grn_image image='spinner.gif'}
    </div>
    <ul id="{$name}_left_member_list">

    </ul>
</div>
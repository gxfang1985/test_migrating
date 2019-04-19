{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
<!--delete-->
{grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
<!--delete-->
<!--menubar-->
<div id="main_menu_part">
    <span class="float_left nowrap-grn">
        <form name="top_finish" method="post" action="{grn_pageurl page='todo/command_view'}" class="inline_block_grn">
            <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <input type="hidden" name="tid" value="{$todo.tid}">
            <input type="hidden" name="cid" value="{$category_id}">
            <span class="aButtonStandard-grn"><button id="complete-todo-submit" type="button" tabindex="0" title="{cb_msg module='grn.todo' key='GRN_TOD-51' replace='true'}" aria-label="{cb_msg module='grn.todo' key='GRN_TOD-51' replace='true'}" class="mRight10" onclick="submit(this.form);">{cb_msg module='grn.todo' key='GRN_TOD-51' replace='true'}</button></span>
        </form>
        <span class="menu_item">{capture name='grn_todo_GRN_TOD_52'}{cb_msg module='grn.todo' key='GRN_TOD-52' replace='true'}{/capture}{grn_link page='todo/modify' caption=$smarty.capture.grn_todo_GRN_TOD_52 image='modify20.gif' tid=$todo.tid cid=$category_id alt=''}</span>
        <span class="menu_item">{capture name='grn_todo_GRN_TOD_53'}{cb_msg module='grn.todo' key='GRN_TOD-53' replace='true'}{/capture}{grn_link page='todo/delete' caption=$smarty.capture.grn_todo_GRN_TOD_53 image='delete20.gif' id='lnk_delete' script='javascript:void(0);' alt=''}</span>
    </span>
    <span class="float_right nowrap-grn mBottom2">
        <div class="moveButtonBlock-grn">
            {grn_previous_next_navi previous=$navi.prev next=$navi.next}
        </div>
    </span>
    <div class="clear_both_0px"></div>
 </div>
 <!--menubar_end-->
{grn_title title=$todo.title class=$page_info.parts[0]|cat:' inline_block_grn mBottom10' no_style=1}

<table class="view_table" width="80%">
    <colgroup>
        <col width="20%">
        <col width="80%">
    </colgroup>
    <tr>
        <th>{cb_msg module='grn.todo' key='GRN_TOD-54' replace='true'}</th>
        <td id="todo-category">{$todo.category|escape:"html"}</td>
    </tr>
    <tr>
        <th>{cb_msg module='grn.todo' key='GRN_TOD-55' replace='true'}</th>
        <td id="todo-title">{$todo.title|escape}</td>
    </tr>
    <tr>
        <th>{cb_msg module='grn.todo' key='GRN_TOD-56' replace='true'}</th>
        <td id="todo-limit">{if $todo.ldate}{grn_date_format date=$todo.ldate format='DateLong_YMDW'}{else}{cb_msg module='grn.todo' key='GRN_TOD-57' replace='true'}{/if}</td>
    </tr>
    <tr>
        <th>{cb_msg module='grn.todo' key='GRN_TOD-58' replace='true'}</th>
        <td>{* priorityマーク取得 *}{include file='todo/_display_priority.tpl' priority=$todo.priority}</td>
    </tr>
    <tr valign="top">
        <th>{cb_msg module='grn.todo' key='GRN_TOD-62' replace='true'}</th>
        <td id="todo-memo">{grn_format body=$todo.memo}</td>
    </tr>
</table>
{include file="grn/footer.tpl"}

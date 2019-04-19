{assign var="form_name" value="todo_add"}
{if !$ajax_load}
{grn_load_javascript file="grn/html/component/validator.js"}
{grn_load_javascript file="grn/html/page/space/todo/todo_edit.js"}
{/if}
{literal}
<script language="JavaScript" text="text/javascript">
(function()
{
    var G = grn.page.space.todo.todo_edit;
    G.ERRMSG_TITLE_IS_REQUIRED = '{/literal}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-2' replace='true'}{literal}';
    G.ERRMSG_INVALID_START_DATE = '{/literal}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-21' replace='true'}{literal}';
    G.display_item = function()
    {
        var item_display = "table-row"
        var browser_type = '{/literal}{$browser.type}{literal}';
        var browser_ver_major = '{/literal}{$browser.ver_major}{literal}';
        var memo = document.getElementById('space-todo-addDialog-memo-row');
        if (memo.style.display != 'table-row')
        {
            memo.style.display = item_display;
            document.getElementById('space-todo-addDialog-attach-row').style.display = item_display;
            document.getElementById('space-todo-addDialog-displayOn-row').style.display = 'none';
            document.getElementById('space-todo-addDialog-displayOff-row').style.display = item_display;
            grn.page.space.todo.todo.setPosition('auto');
        }
        else
        {
            memo.style.display = 'none';
            document.getElementById('space-todo-addDialog-attach-row').style.display = 'none';
            document.getElementById('space-todo-addDialog-displayOn-row').style.display = item_display;
            document.getElementById('space-todo-addDialog-displayOff-row').style.display = 'none';
            grn.page.space.todo.todo.setPosition('auto');
        }
    }
    YAHOO.util.Event.onDOMReady(function()
    {
        var dialog = document.getElementById('todo_add_dialog');
        var body = document.getElementsByTagName('body')[0];
        dialog.parentNode.removeChild(dialog);
        body.appendChild(dialog);
    });
})();
</script>
{/literal}
<div class="msgbox" id="todo_add_dialog" style="display:none;">
    <form name="{$form_name}" id="{$form_name}" method="post"  enctype="multipart/form-data" action="{grn_pageurl page='space/application/todo/command_add'}" onsubmit="return grn.page.space.todo.todo.submit('{grn_pageurl page="space/application/todo/ajax/command_add"}');">
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <input type='hidden' name='spid' value="{$space_id}">
        <input type='hidden' name='tid' value="{$thread_id}" id="tid_todo">
        <input type='hidden' name='from' value="" id="todo_add_from">
        <div id="space-addTodo-overlayScreen-grn"></div>
        <div id="space-addTodo-overlayWindow-grn">
            <div id="todo_add_title" class="space-addTodo-overlayTitle-grn">
                {cb_msg module='grn.space.todo' key='GRN_SP_TOD-19' replace='true'}
                <a id="close_todo_add" style="position: absolute; right: 5px;top:5px;text-decoration:none;" onclick="grn.page.space.todo.todo.closeTodoAddDialog();" href="javascript:;">{grn_image image="close20.gif"}</a>
            </div>
            <div class="space-addTodo-overlayBody-grn">
                <div class="space-addTodo-todoOuter-grn">
                    {include file="grn/show_validation_errors.tpl"}
                    <div id="FieldToShowErrorMessage"></div>
                    <table class="space-addTodo-input-grn">
                        <tbody>
                            <tr>
                                <th width="15%">{capture name='grn_space_GRN_SP_TOD_1'}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-1' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_space_GRN_SP_TOD_1 necessary=TRUE}</th>
                                <td>{capture name='grn_space_GRN_SP_TOD_2'}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-2' replace='true'}{/capture}{grn_text name='title' id='space-todo-addDialog-name' value=$title size='50' disable_return_key=true}</td>
                            </tr>
                            <tr>
                                <th width="15%">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-3' replace='true'}</th>
                                <td id="space-todo-addDialog-date-col">
                                    {include file="space/application/todo/_todo_date.tpl" form_name=$form_name}
                                </td>
                            </tr>
                            <tr>
                                <th width="15%">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-4' replace='true'}</th>
                                <td id="space-todo-addDialog-assignees-col">
                                    {grn_member_add name                   = 'todo_assignees'
                                                    form_name              = $form_name
                                                    app_id                 = 'space'
                                                    search_box_options     = $todo_search_box_options
                                                    pulldown_parts_options = $todo_pulldown_parts_options
                                                    order_parts_options    = $todo_order_parts_options
                                                    sUID                   = 'todo_sUID'
                                                    CID                    = 'todo_CID'
                                    }
                                </td>
                            </tr>
                            <tr id="space-todo-addDialog-displayOn-row" >
                                <td colspan="2"><a href="javascript:void(0);" onclick = "grn.page.space.todo.todo_edit.display_item()" class="space-addTodo-inputMoreInfoLink-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-22' replace='true'}</a></td>
                            </tr>
                            <tr id="space-todo-addDialog-displayOff-row" class="display: none" >
                                <td colspan="2"><a href="javascript:void(0);" onclick = "grn.page.space.todo.todo_edit.display_item()" class="space-addTodo-inputMoreInfoLink-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-23' replace='true'}</a></td>
                            </tr>
                            <tr id="space-todo-addDialog-memo-row" class="display: none">
                                <th width="15%">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-5' replace='true'}</th>
                                <td><textarea id='space-todo-addDialog-memo' name='memo' rows='10' cols="50" style='width:535px; height:80px'></textarea></td>
                            </tr>
                            <tr id="space-todo-addDialog-attach-row" class="display: none">
                                <th width="15%">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-6' replace='true'}</th>
                                <td>
                                    <div style="width:540px;height:120px;overflow-y:scroll">
                                        {include file="grn/attach_file35.tpl" upload_ticket=$todo_upload_ticket fbox_id="todo_add"  filename_width=200 progressbar_width=180}
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="space-addTodo-overlayBtn-grn">
                {strip}
                    {capture name="grn_space_todo_GRN_SP_TOD_20"}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-20' replace='true'}{/capture}
                    {grn_button id='todo_add_submit' action='submit' ui='main' auto_disable=false caption=$smarty.capture.grn_space_todo_GRN_SP_TOD_20 spacing='normal'}
                    {capture name="grn_space_todo_GRN_SP_TOD_62"}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-62' replace='true'}{/capture}
                    {grn_button action='cancel' caption=$smarty.capture.grn_space_todo_GRN_SP_TOD_62 onclick="grn.page.space.todo.todo.closeTodoAddDialog();"}
                {/strip}
            </div>
        </div>
    </form>
</div>

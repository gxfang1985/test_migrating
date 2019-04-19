{grn_load_javascript file="grn/html/page/space/todo/todo_detail.js"}
{grn_load_javascript file="grn/html/component/validator.js"}
{if ! $page_prefix}{assign var='page_prefix' value='space/application'}{/if}
{if ! $thread_prefix}{assign var='thread_prefix' value=$page_prefix|cat:'/discussion'}{/if}
{if ! $file_prefix}{assign var='file_prefix' value='space/application/todo'}{/if}
{if ! $file_dpage}{assign var='file_dpage' value='space/file_download'}{/if}
{if ! $file_vpage}{assign var='file_vpage' value=$file_prefix|cat:'/file_view'}{/if}
{assign var="form_name" value=$smarty.template|basename}
{assign var='ajax_prefix' value=$page_prefix|cat:'/todo/ajax'}
{assign var='todo_comment_height' value='130'}
{assign var='todo_comment_width' value='700'}
{literal}
<script language="JavaScript" text="text/javascript">
var __thisPage = grn.page.space.todo.todo_detail;
    __thisPage.todoView = {/literal}'{grn_pageurl page=$page_prefix|cat:"/todo/view"}'{literal}; 
    __thisPage.spid = {/literal}'{$space_id}'{literal};
    __thisPage.tdid = {/literal}'{$todo->getId()}'{literal};
    __thisPage.from = {/literal}'{$from}'{literal};
    __thisPage.todoCommentUrl = {/literal}'{grn_pageurl page=$ajax_prefix|cat:"/todo_comment"}'{literal};
    __thisPage.todoCommentAddUrl = {/literal}'{grn_pageurl page=$ajax_prefix|cat:"/command_todo_comment_add"}'{literal};
    __thisPage.todoCommentListUrl = {/literal}'{grn_pageurl page=$ajax_prefix|cat:"/comment_list"}'{literal};
    __thisPage.last_comment_no = '';
    __thisPage.reply_comment_num = '';
    __thisPage.sp = {/literal}'{$sp}'{literal};
    __thisPage.cmno = {/literal}'{$cmno}'{literal};
    __thisPage.cmid = {/literal}'{$cmid}'{literal};
    __thisPage.spinnerImage = {/literal}'{$app_path}/grn/image/cybozu/spinner.gif?{$build_date}'{literal};
    __thisPage.ERRMSG_COMMENT_CONTENTS_IS_REQUIRED = {/literal}"{cb_msg module='grn.space.todo' key='GRN_SP_TOD-46' replace='true'}"{literal};
    __thisPage.textareaHeight = {/literal}{$todo_comment_height}{literal};
    __thisPage.textareaWidth = {/literal}{$todo_comment_width}{literal};
</script>
{/literal}
{if $isOperator || $hasPrivilege}
    <div class="space_todo_menu_grn">
        <div id="main_menu_part">
            {if $isTodoUser}
                <form class="inline_block_grn" name="{$form_name}" method="post" action="{grn_pageurl page='space/application/todo/command_completed'}">
                    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
                    {if $loginUserComplete}
                        <span class="aButtonStandard-grn"><button type="button" tabindex="0" title="{cb_msg module='grn.space.todo' key='GRN_SP_TOD-25' replace='true'}" aria-label="{cb_msg module='grn.space.todo' key='GRN_SP_TOD-25' replace='true'}" class="mRight10" onclick="this.form.submit();">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-25' replace='true'}</button></span>
                    {else}
                        <span class="aButtonStandard-grn"><button type="button" tabindex="0" title="{cb_msg module='grn.space.todo' key='GRN_SP_TOD-24' replace='true'}" aria-label="{cb_msg module='grn.space.todo' key='GRN_SP_TOD-24' replace='true'}" class="mRight10" onclick="this.form.submit();">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-24' replace='true'}</button></span>
                    {/if}
                    <input type="hidden" name="spid" value="{$space_id}">
                    <input type="hidden" name="tid" value="{$thread->getId()}">
                    <input type="hidden" name="tdid" value="{$todo->getId()}">
                    <input type="hidden" name="from" value="{$from}">
                </form>
            {/if}
            {if $can_edit}
                <span class="menu_item">
                    {capture name='grn_space_GRN_SP_TOD_8'}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-8' replace='true'}{/capture}{grn_link page='space/application/todo/modify' caption=$smarty.capture.grn_space_GRN_SP_TOD_8 class="icon-edit-grn" spid=$space_id tdid=$todo->getId() from=$from}
                </span>
                <span class="menu_item">
                    {grn_delete title=$delete_info.title page=$delete_info.page no_confirm=$delete_info.no_confirm data=$delete_info.data handler=$delete_info.handler}
                    {capture name='grn_space_GRN_SP_TOD_17'}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-17' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_space_GRN_SP_TOD_17 element_id='lnk_delete' script='javascript:void(0)' image='delete20.gif' alt=''}
                </span>
            {/if}
        </div>
    </div>
{/if}
<div class="space_todo_content_grn">
<div class="spaceTodoTitle-grn">
    <h2 class="space inline_block_grn">{$todo->getTitle()|escape}</h2>
    {if not $todo->isComplete()}
        <span class="space-todo-uncomplete-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-34' replace='true'}</span>
    {/if}
    <span class="mLeft15 nowrap-grn">
        {grn_link page=$thread_prefix|cat:'/index' caption=$thread->getTitle() spid=$space_id fragment='tid='|cat:$thread->getId() class='icon-spaceDiscussion16-grn' br=true}
    </span>
    <span class="mLeft15 space-todo-comment-footer-grn">
      {include file="grn/_favour.tpl"}
    </span>
</div>
{*Todo body start*}
<table class="view_table margin_top" width="80%">
    <colgroup>
        <col width="20%">
        <col width="80%">
    </colgroup>
    <tbody>
        <tr>
            <th>{cb_msg module='grn.space.todo' key='GRN_SP_TOD-28' replace='true'}</th>
            <td>
                {if $start_date}
                    {grn_date_format date=$start_date format="DateLong_YMDW"}
                    {cb_msg module='grn.space.todo' key='GRN_SP_TOD-33' replace='true'}
                {/if}
                {if $end_date}
                    {grn_date_format date=$end_date format="DateLong_YMDW"}
                {/if}
                {if $start_date || $end_date}
                    {if $current_timezone != $todo->getTimezone()}
                        <span class="space-todo-timezone-grn">{cb_msg module='fw.timezone' key=$todo->getTimezone()}</span>
                    {/if}
                {/if}
            </td>
        </tr>
        <tr>
            <th>{cb_msg module='grn.space.todo' key='GRN_SP_TOD-30' replace='true'}</th>
            <td>
                {grn_space_todo_members name            = 'uncomplete_todo_users'
                                        todo_user_array = $todo_uncomplete_user_array
                }
            </td>
        </tr>
        <tr>
            <th>{cb_msg module='grn.space.todo' key='GRN_SP_TOD-29' replace='true'}</th>
            <td>
                {grn_space_todo_members name            = 'complete_todo_users'
                                        todo_user_array = $todo_complete_user_array
                }
            </td>
        </tr>
        <tr>
            <th>{cb_msg module='grn.space.todo' key='GRN_SP_TOD-5' replace='true'}</th>
            <td>{grn_format body=$todo->getContent()}</td>
        </tr>
        <tr>
            <th>{cb_msg module='grn.space.todo' key='GRN_SP_TOD-6' replace='true'}</th>
            <td>
                {foreach from=$attachedFiles item=file}
                    <div>
                        {grn_space_attach_file_link name=$file.name dpage=$file_dpage vpage=$file_vpage mime=$file.mime size=$file.size fid=$file.id hash=$file.hash tid=$thread->getId() spid=$space_id from=$from inline=$inline upload=($isOperator||$hasPrivilege) upage=$file_prefix|cat:'/file_upload'}
                    </div>
                {/foreach}
            </td>
        </tr>
        <tr>
            <th>{cb_msg module='grn.space.todo' key='GRN_SP_TOD-63' replace='true'}</th>
            <td>{grn_space_user_link user=$todo->getCreator()} {$todo->getCreateDisplayDatetime()|escape}</td>
        </tr>
        <tr>
            <th>{cb_msg module='grn.space.todo' key='GRN_SP_TOD-32' replace='true'}</th>
            <td>{grn_space_user_link user=$todo->getModifier()} {$todo->getModifyDisplayDatetime()|escape}</td>
        </tr>
    </tbody>
</table>
</div>
{*Todo body end*}

{*Todo comment start*}
<div class="comment_std_grn detail_comment_grn">
<form id="follow_form_todo_comment" name="follow_form" method="post" enctype="multipart/form-data" action="{grn_pageurl page=space/application/todo/command_comment_add}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <input type="hidden" name="spid" value="{$space_id}">
    <input type="hidden" name="tdid" value="{$todo->getId()}">
    <input type="hidden" name="from" value="{$from}">
    <div id="error_msg_todo_comment"></div>
    <div class="mBottom10">
        {assign var="ed_name" value="todo_comment_add"}
        {assign var="ed_switch_name" value="todo_comment_add_editor"}
        {include file="grn/richeditor.tpl" enable=1 name=$ed_name switch_name=$ed_switch_name
                 height=$todo_comment_height width=$todo_comment_width comment="true" class="form_textarea_grn"}
        {include file="grn/attach_file35.tpl" upload_ticket=$upload_ticket fbox_id="todo_comment" isFollow=TRUE}
        <div class="mTop5">
            {strip}
                {capture name="grn_space_todo_GRN_SP_TOD_27"}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-27' replace='true'}{/capture}
                {grn_button id='todo_comment_button' ui='main' auto_disable=false caption=$smarty.capture.grn_space_todo_GRN_SP_TOD_27
                onclick="__thisPage.todoCommentAdd('todo_comment');"}
            {/strip}
        </div>
    </div>
</form>
</div>
<a name="follow"></a>
<div id="todo_comments" class="space-todo-comments-grn"></div>
{*Todo comment end*}
{include file="grn/_show_popup_fixed_link.tpl"}

<!-- reply comment -->
{capture name=form_fields}
    <input type="hidden" name="spid" value="{$space_id}">
    <input type="hidden" name="tdid" value="{$todo->getId()}">
    <input type="hidden" name="from" value="{$from}">
{/capture}
{include file="grn/_reply_comment.tpl"
    on_submit="__thisPage.todoCommentAdd('reply_comment');"
    form_action="space/application/todo/command_comment_add"
    input_name="todo_comment_add"
    enable_mention=false
    form_fields=$smarty.capture.form_fields
}
<!-- end reply comment -->

{include file="grn/_favour_common.tpl"}
{if ! $page_prefix}{assign var='page_prefix' value='space/application'}{/if}
{if ! $todo_prefix}{assign var='todo_prefix' value=$page_prefix|cat:'/todo'}{/if}
{if ! $file_prefix}{assign var='file_prefix' value=$page_prefix|cat:'/file'}{/if}
{if ! $file_dpage}{assign var='file_dpage' value='space'|cat:'/file_download'}{/if}
{if ! $file_vpage}{assign var='file_vpage' value=$todo_prefix|cat:'/file_view'}{/if}
{if $todo_comments}
<div class="space-todo-pager-grn">
  {include file="space/application/todo/word_navi.tpl" navi=$navi ajax_flag=1}
</div>
{foreach from=$todo_comments item=comment}
    <div class="comment_main_grn space-todo-follow-grn {if $comment.unread}unread_color{/if} js_comment"
         id="{'todo_comment_'|cat:$comment.comment_no}"
         onmouseenter="__thisPage.selectComment({$comment.comment_no})"
         onmouseleave="__thisPage.unselectComment({$comment.comment_no})"
         onclick="javascript:mouseClick('space_todo', {$comment.comment_no})"
         data-comment-no="{$comment.comment_no}"
         data-comment-id="{$comment.id}">

        {assign var='userId' value=$comment.creator_id}
        <div class="profileImageBase-grn">
    {if $imageIcon}
            <table class="comment_base_grn">
                <tr>
                    <td class="vAlignTop-grn sub_grn" style="width:1%;">
                        {grn_user_image_icon userInfo=$users_info.$userId  photoUrl=$users_info.$userId.photoUrl userId=$userId loginId=$loginId size=$iconSize alt=$comment.creator_name}
                    </td>
                    <td class="vAlignTop-grn">
    {/if}
                        <table class="comment_base_grn">
                            <tr>
                                <td class="vAlignTop-grn sub_grn">
    {if $imageIcon}
                                    <span class="commentNum-grn">{$comment.comment_no|escape}:</span><span class="username_grn">{grn_space_user_link user=$comment.creator noUserIcon='true'}</span><span class="commentDate-grn">{$comment.ctime|escape}</span>
    {else}
                                    <span class="space-todo-followNum-grn">{$comment.comment_no|escape}:</span><span class="username_grn">{grn_space_user_link user=$comment.creator}</span><span class="space-datetime-grn">{$comment.ctime|escape}</span>
    {/if}
                                </td>
                                <td class="comment-grn vAlignTop-grn" style="width:15%;">
                                    <div class="comment-grn">
                                        {if $comment.deletable}
                                            <div id={'todoCommentDelete'|cat:$comment.comment_no} style="display:none">{include file="space/application/todo/todo_comment_delete.tpl"}</div>
                                            <a class="icon-delete-grn js_delete_link" id={'lnk_delete_comment_'|cat:$comment.comment_no} href="javascript:__thisPage.deleteTodoComment('{$delete_info.title}', {$comment.comment_no});">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-48' replace='true'}</a>
                                        {/if}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="vAlignTop-grn" colspan="2">
                                    <div class="space-todo-comment-content-grn">
                                        {if $comment.parent_no}
                                            {capture name='link_to_parent'}{cb_msg module='grn.space.todo' key='GRN_SP_TOD-49' replace='true'}{$comment.parent_no}{/capture}
                                            {grn_format body=$smarty.capture.link_to_parent todo_follow_autolink=$comment.todo_id spid=$space_id from=$from}<br>
                                        {/if}
                                        <div id="todo_comment_content_{$comment.comment_no}">
                                            {if $comment.is_rich_text}
                                                {$comment.data|grn_noescape}
                                            {else}
                                                {grn_format body=$comment.data todo_follow_autolink=$comment.todo_id spid=$space_id from=$from}
                                            {/if}
                                        </div>
                                        {if $comment.attach_files}
                                            <div class="space-todo-attachedFile-grn">
                                                <ul>
                                                    {foreach from=$comment.attach_files item=file}
                                                        <li>{grn_space_attach_file_link name=$file.name dpage=$file_dpage vpage=$file_vpage mime=$file.mime size=$file.size fid=$file.id tid=$thread_id spid=$space_id from=$from inline=$inline}</li>
                                                    {/foreach}
                                                </ul>
                                            </div>
                                        {/if}
                                    </div>
                                </td>
                            </tr>
                        </table>
    {if $imageIcon}
                    </td>
                </tr>
            </table>
    {/if}
        </div>
        <div class='space-todo-comment-footer-grn' style="width:100%">
            <table style="width:100%">
                <tr>
                    <td width="85%">
                        {if $imageIcon}
                            <div style="margin-left:40px;">
                        {else}
                            <div>
                        {/if}
                            <span class="mRight15">
                                {include file="grn/_favour.tpl" favour_info=$comment.favour_info}
                            </span>
                            <span class="mRight15">
                                <a id='lnk_url_tip_{$comment.comment_no}'
                                   class='icon-reply-grn js_reply_button'
                                   href="javascript:">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-50' replace='true'}
                                </a>
                            </span>
                            <span id="fixed_link_{$comment.comment_no}">
                                <a id="lnk_url_tip_{$comment.comment_no}"
                                   class="icon-urlTip-grn js_permalink"
                                   href="javascript:void(0);"
                                   onclick="javascript:showFixedLink(this,'{$comment.full_url}');">
                                    {cb_msg module='grn.space.todo' key='GRN_SP_TOD-51' replace='true'}
                                </a>
                            </span>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </div>
{/foreach}
<div class="space-todo-pager-grn">
  {include file="space/application/todo/word_navi.tpl" navi=$navi ajax_flag=1}
</div>
{/if}

{literal}
    <script>
        (function () {
            var reply_dialog = new grn.js.component.common.ui.comment.ReplyDialog();
            reply_dialog.bindToCommentList("#todo_comments");
        })();
    </script>
{/literal}

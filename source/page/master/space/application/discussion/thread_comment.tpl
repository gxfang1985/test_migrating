{if ! $page_prefix}{assign var='page_prefix' value='space/application'}{/if}
{if ! $todo_prefix}{assign var='todo_prefix' value=$page_prefix|cat:'/todo'}{/if}
{if ! $file_prefix}{assign var='file_prefix' value=$page_prefix}{/if}
{if ! $file_dpage}{assign var='file_dpage' value='space/file_download'}{/if}
{if ! $file_vpage}{assign var='discussion_file_vpage' value=$file_prefix|cat:'/discussion/file_view'}{/if}
{if ! $file_vpage}{assign var='todo_file_vpage' value=$file_prefix|cat:'/todo/file_view'}{/if}

{if $thread_comments}
    <div class="space-thread-pager-grn space-thread-pager-top-grn">
        {include file="space/application/word_navi.tpl" navi=$navi ajax_flag=1}
    </div>
    <a class="space-thread-checkNotification-grn" href="javascript:void(0);" onclick="__thisPage.getCommentList()" id="realtime" style="display:none"></a>
    {foreach from=$thread_comments item=comment}
        <div class="comment_main_grn space-thread-follow-grn {if $comment.unread}unread_color{/if} js_comment"
             id="{'thread_comment_'|cat:$comment.comment_no}"
             onmouseenter="__thisPage.selectComment({$comment.comment_no})"
             onmouseleave="__thisPage.unselectComment({$comment.comment_no})"
             onclick="javascript:mouseClick('space_discussion', {$comment.comment_no})"
             data-comment-no="{$comment.comment_no}"
             data-comment-id="{$comment.id}"
             data-is-to-do="{$comment.is_todo_cmnt}"
             data-to-do-id="{$comment.todo_id}">

            {assign var='userId' value=$comment.creator_id}
            <div class="comment_main_grn profileImageBase-grn">
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
            {strip}
                                        <span class="commentNum-grn">{$comment.comment_no|escape}:</span>
                                        <span class="username_grn" data-user-id="{$userId}">
                                            {grn_space_user_link user=$comment.creator noUserIcon="true"}
                                        </span>
                                        <span class="commentDate-grn">{$comment.ctime|escape}</span>
            {/strip}
        {else}
                                        <span class="space-thread-followNum-grn">{$comment.comment_no|escape}:</span><span class="username_grn">{grn_space_user_link user=$comment.creator}</span><span class="space-datetime-grn">{$comment.ctime|escape}</span>
        {/if}
                                    </td>
                                    <td class="comment-grn vAlignTop-grn" style="width:15%;">
                                        <div style="font-size:85%;">
                                            {if $comment.deletable}
                                                <div id={'threadCommentDelete'|cat:$comment.comment_no} style="display:none">{include file="space/application/discussion/thread_comment_delete.tpl"}</div>
                                                <a class="icon-delete-grn js_delete_link"
                                                   id={'lnk_delete_comment_'|cat:$comment.comment_no}
                                                   href="javascript:__thisPage.deleteThreadComment('{$delete_info.title}', {$comment.comment_no});"
                                                   role="button">
                                                {cb_msg module='grn.space.discussion' key='GRN_SP_DISC-19' replace='true'}
                                                </a>
                                            {/if}
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="vAlignTop-grn" colspan="2">
                                        {if $comment.is_todo_cmnt}
                                            <div class="space-thread-comment-event-grn">
                                                <div class='icon-space-todoStatus-grn'>{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-30' replace='true'}</div><br>
                                                <div>
                                                    <a href="{grn_pageurl page=$todo_prefix|cat:'/view' spid=$space_id tdid=$comment.todo_id}">
                                                        {if $comment.parent_date != null}
                                                            <span style="margin-right: 5px;">
                                                                {grn_date_format date=$comment.parent_date format='DateShort_MD'}
                                                            </span>
                                                        {/if}
                                                        {$comment.parent_title|escape}
                                                    </a>
                                                </div>
                                            </div>
                                        {/if}
                                        <div class="space-thread-comment-content-grn">
                                            {capture name=comment_parent_number}
                                                {strip}
                                                    {if $comment.parent_no}
                                                        {capture name='link_to_parent'}{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-21' replace='true'}{$comment.parent_no}{/capture}
                                                        {grn_format body=$smarty.capture.link_to_parent thread_follow_autolink=$thread_id spid=$space_id}<br>
                                                    {/if}
                                                {/strip}
                                            {/capture}
                                            {capture name=comment_mention}
                                                {strip}
                                                    {if $mention_list[$comment.id]}
                                                        <div class="mention_comment_base_grn">
                                                            {grn_members_name_with_dialog_for_mention app_id='space' members=$mention_list[$comment.id] total_member=$mention_total[$comment.id]}
                                                        </div>
                                                    {/if}
                                                {/strip}
                                            {/capture}
                                            <div class="space-thread-comment-main-grn">
                                                {if $comment.is_cut}
                                                    <div id="thread_comment_content_{$comment.comment_no}">
                                                        {$smarty.capture.comment_mention|grn_noescape}
                                                        {$smarty.capture.comment_parent_number|grn_noescape}
                                                        <div class="js_thread_comment_body">
                                                            {grn_format body=$comment.data thread_follow_autolink=$thread_id spid=$space_id}
                                                        </div>
                                                    </div>
                                                    {if $comment.is_rich_text}
                                                        <div style="display:none" id="thread_comment_entire_content_{$comment.comment_no}">{$comment.entire_data|grn_noescape}</div>
                                                    {else}
                                                        <div style="display:none" id="thread_comment_entire_content_{$comment.comment_no}">{grn_format body=$comment.entire_data thread_follow_autolink=$thread_id spid=$space_id}</div>
                                                    {/if}
                                                    <a id='lnk_url_more_{$comment.comment_no}' class='show-more-grn' href="javascript:void(0);" onclick="javascript:__thisPage.showEntireComment('{$comment.comment_no}')">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-32' replace='true'}</a>
                                                {else}
                                                    <div id="thread_comment_content_{$comment.comment_no}">
                                                        {$smarty.capture.comment_mention|grn_noescape}
                                                        {$smarty.capture.comment_parent_number|grn_noescape}
                                                        <div class="js_thread_comment_body">
                                                            {if $comment.is_rich_text}
                                                                {$comment.data|grn_noescape}
                                                            {else}
                                                                {grn_format body=$comment.data thread_follow_autolink=$thread_id spid=$space_id}
                                                            {/if}
                                                        </div>
                                                    </div>
                                                {/if}
                                            </div>
                                            {if $comment.attach_files}
                                                <div class="space-thread-attachedFile-grn">
                                                    <ul>
                                                        {foreach from=$comment.attach_files item=file}
                                                            {if $comment.is_todo_cmnt}
                                                                <li>{grn_space_attach_file_link name=$file.name dpage=$file_dpage vpage=$todo_file_vpage mime=$file.mime size=$file.size fid=$file.id tid=$thread_id spid=$space_id from=$from_discussion_index inline=$inline}</li>
                                                            {else}
                                                                <li>{grn_space_attach_file_link name=$file.name dpage=$file_dpage vpage=$discussion_file_vpage mime=$file.mime size=$file.size fid=$file.id tid=$thread_id spid=$space_id inline=$inline}</li>
                                                            {/if}
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
            <div class='space-thread-comment-footer-grn' style="width:100%">
                <table style="width:100%;">
                    <tr>
                        <td>
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
                                       class='js_reply_button icon-reply-grn'
                                       role="button"
                                       href="javascript:">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-22' replace='true'}
                                    </a>
                                </span>
                                {if !$comment.is_todo_cmnt}
                                    <span class="mRight15">
                                        <a id='lnk_url_tip_{$comment.comment_no}'
                                           class='icon_reply_all_sub_grn icon_inline_grn icon_hover_item_grn js_reply_all_button'
                                           role="button"
                                           href="javascript:">{cb_msg module='grn.grn' key='GRN_GRN-1583' replace='true'}
                                        </a>
                                    </span>
                                {/if}
                                <span id="fixed_link_{$comment.comment_no}" {if $imageIcon}style="margin-left:5px;"{/if}>
                                    <a id="lnk_url_tip_{$comment.comment_no}"
                                       class="icon-urlTip-grn js_permalink"
                                       href="javascript:"
                                       onclick="javascript:showFixedLink(this,'{$comment.full_url}');"
                                       role="button">
                                        {cb_msg module='grn.space.discussion' key='GRN_SP_DISC-23' replace='true'}
                                    </a>
                                </span>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    {/foreach}

    <div class="space-thread-pager-grn">
        {include file="space/application/word_navi.tpl" navi=$navi ajax_flag=1}
    </div>
{else}
    <a class="space-thread-checkNotification-grn" href="javascript:void(0);" onclick="__thisPage.getCommentList()" id="realtime" style="display:none"></a>
{/if}

{literal}
<script>
    (function () {
        var settings = {
            mentionReply: {
                urlGetMembers: "grn/space/ajax/get_members_of_mention",
            }
        };
        var reply_dialog = new grn.js.component.common.ui.comment.ReplyDialog(settings);
        reply_dialog.bindToCommentList("#thread_comments");
    })();
</script>
{/literal}

{include file='grn/ajax/mobile_member_list_dialog.tpl'}
{grn_load_javascript file="grn/html/component/validator_mobile.js"}
{grn_load_javascript file="js/dist/space_mobile.js"}
{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{if ! $page_prefix}{assign var='page_prefix' value='space/mobile/application'}{/if}
{if ! $discussion_prefix}{assign var='discussion_prefix' value=$page_prefix|cat:'/discussion'}{/if}
{if ! $todo_prefix}{assign var='todo_prefix' value=$page_prefix|cat:'/todo'}{/if}
{assign var="form_name" value=$smarty.template|basename}
{if $comment.creator_type == 'login_user'}
  {assign var='li_class' value='mobile-list-login-grn'}
  {assign var='div_class' value='mobile-listHeader-login-grn'}
{else}
  {assign var='div_class' value='mobile-listHeader-unlogin-grn'}
  {if $comment.creator_type == 'invalid_user'}
    {assign var='li_class' value='mobile-userInvalid-grn'}
  {elseif $comment.creator_type == 'invalidApp_user'}
    {assign var='li_class' value='mobile-userInvalidApp-grn'}
  {else}
    {assign var='li_class' value='mobile-list-unlogin-grn'}
  {/if}
{/if}
{assign var='li_class' value=$li_class|cat:' mobile-cmt-operate-grn'}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-grn mobile-content-padding-grn">
    {include file='grn/mobile_breadcrumb.tpl' not_need_withList=true}
    <div class="mobile-cmt-input-grn">
        <span class="mobile-num-writeback-grn js_reply_num">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-21' replace='true'}{$comment.comment_no}</span>
        <form name="{$form_name}" method="post" enctype="multipart/form-data" data-ajax="false"
              action="{grn_pageurl page='space/mobile/application/discussion/command_comment_add'}">
            <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
            <input type="hidden" id="spid" name="spid" value="{$comment.space_id}">
            <input type="hidden" id="tid" name="tid" value="{$comment.thread_id}">
            <input type="hidden" id="reply_comment_id" name="reply_comment_id" value="{$comment.id}">
            <input type="hidden" id="reply_comment_istodo" name="reply_comment_istodo" value="{$comment.is_todo_cmnt}">
            <input type="hidden" id="reply_comment_todo_id" name="reply_comment_todo_id" value="{$comment.todo_id}">
            <input type="hidden" name="mention"/>
            <div id="errorMessageField"></div>
            {include file="grn/mobile_comment_add.tpl"
                name=thread_reply_comment_add
                mention=TRUE
                mention_params=$mention_params
                mention_access_plugin_encoded=$mention_access_plugin_encoded
            }
            <div class="mobile-buttonArea-grn">
                <div class="mobile-buttonMain-grn mobile-button-left-grn mobile_show_overlay_js">
                    <input type="button" class="js_submit_button" name="send" data-inline="true" data-theme="{$data_theme}"
                           value="{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-35' replace='true'}"/>
                </div>
                <div class="mobile-buttonNormal-grn mobile-button-right-grn mobile_show_overlay_js">
                    <input type="button" data-inline="true" data-theme="{$data_theme}"
                           value="{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-41' replace='true'}"
                           onclick='location.href="{grn_pageurl page='space/mobile/application/discussion/detail' spid=$comment.space_id tid=$comment.thread_id}";'/>
                </div>
            </div>
        </form>
    </div>
    <div class="mobile-cmt-dArray-grn"></div>
    <div id="comment_container">
        <div class="{$li_class} js_comment" data-comment-id="{$comment.id}">
          <div class="{$div_class}">
            <span class="mobile-num-list-grn">{$comment.comment_no|escape}</span>
            <div class="mobile-user-list-grn js_comment_creator" data-user-id="{$comment.creator_id}" data-user-url="{$comment.creator_url}">
              <span></span>{$comment.creator|escape}</div>
            <div class="mobile-date-list-grn">
              <span>{$comment.ctime|escape}</span></div>
          </div>
          {if $comment.is_todo_cmnt}
            <div class="mobile-commentLink-noArray-grn">
              <a href="{grn_pageurl page=$todo_prefix|cat:'/detail' spid=$comment.space_id tdid=$comment.todo_id}" class="mobile-a-ellipsis-grn">
              <span class="mobile-commentLink-normal-grn ">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-42' replace='true'}</span>
              <span class="mobile-icon-commentLink-todo-grn"></span>{$comment.todo_title|escape}</a>
            </div>
          {/if}
          {if $comment.parent_no}
            {cb_msg module='grn.space.discussion' key='GRN_SP_DISC-21' replace='true'}{$comment.parent_no}<br>
          {/if}
          {if $comment.mention}
            {capture name=comment_mention}
              {strip}
                <div class="mobile_mention_comment_base_grn">
                  {grn_members_name_with_dialog_for_mention
                  app_id='space'
                  members=$comment.mention
                  total_member=$comment.mention_count
                  ul_attribute='class="mobile_ul_style_off_grn"'
                  is_mobile=true}
                </div>
              {/strip}
            {/capture}
            {$smarty.capture.comment_mention|grn_noescape}
          {/if}
          <div class="mobile-todo-content-nomark-grn">
          {if $comment.is_rich_text}
            {$comment.data|grn_mobile_link_format}
          {else}
            {grn_mobile_format body=$comment.data}
          {/if}
          </div>
          {if $comment.attach_files}
          <div class="mobile-btn-list-grn">
            {foreach from=$comment.attach_files item=file}
              {grn_mobile_attach_file_link name=$file.name dpage="space/mobile/file_download" spid=$comment.space_id tid=$comment.thread_id fid=$file.id}
            {/foreach}
          </div>
          {/if}
        </div>
    </div>
</div>
<!-- end of content-->
{literal}
<script>
    $(document).on( "ready", function( event )
    {
        // Initialize Mention component
        var settings = {
            {/literal}
            name: "thread_reply_comment_add_mention",
            formName: "{$form_name}",
            commentId: "{$comment.id}",
            commentContainer: "#comment_container",
            isReplyAll: "{$comment.is_reply_all}"
            {literal}
        };
        new grn.js.page.space.mobile.application.discussion.CommentAdd(settings);

        $(".js_comment").each(function () {
            var settings = {
                element: $(this),
                params: {comment_id: $(this).data("comment-id")},
                url: "grn/space/ajax/get_remaining_members_of_mention"
            };
            new grn.js.component.common.ui.show_more.mobile.MobileMemberListShowMore(settings).render();
        });

        var MemberDialogSettings = {
            {/literal}
            accessPluginEncoded: "{$mention_access_plugin_encoded}",
            {literal}
        };
        var dialog = new grn.js.component.common.ui.dialog.MobileMemberListDialog(MemberDialogSettings);
        dialog.render();
        dialog.bindDialogToMembersContainer("#comment_container");

    });
</script>
{/literal}
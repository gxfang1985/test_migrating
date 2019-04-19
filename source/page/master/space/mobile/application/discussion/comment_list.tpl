{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var='discussion_prefix' value='space/mobile/application/discussion'}
{assign var='todo_prefix' value='space/mobile/application/todo'}
{foreach from=$comments item=comment}
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
  {if $comment.unread}
    {assign var='li_class' value=$li_class|cat:' mobile-list-unread-grn'}
  {else}
    {assign var='li_class' value=$li_class|cat:' mobile-list-normal-grn'}
  {/if}
{**
 * @see http://issues.dev.cybozu.co.jp/browse/GRN2-7155
 * @see http://issues.dev.cybozu.co.jp/browse/GRN2-7149
 *  onclick="grn.component.space_mobile($url);" : $url means
 *  if $comment.is_todo_comment
 *      url of todo comment detail.
 *      (ex) /g/space/mobile/application/todo/comment_detail.csp?spid=1&tdid=1&cmid=4
 *  else
 *      url of discussion comment detail.
 *      (ex) /g/space/mobile/application/discussion/comment_detail.csp?spid=1&tid=1&cmid=2
 *}
<li data-icon="false" class="{$li_class} js_comment" data-comment-id="{$comment.id}">
  <div class="{$div_class}">
    <span class="mobile-num-list-grn">{$comment.number|escape}</span>
    <div class="mobile-user-list-grn">
      <span></span>{$comment.creator_name|escape}
    </div>
    <div class="mobile-date-list-grn">
      <span>{$comment.ctime|escape}</span>
    </div>
  </div>
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
{if $comment.is_todo_comment}
  <div class="mobile-commentLink-todo-grn">
    <a href="{grn_pageurl page=$todo_prefix|cat:'/detail' spid=$space_id tdid=$comment.todo_id}" class="mobile-a-ellipsis-grn">
      <span class="mobile-commentLink-normal-grn ">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-42' replace='true'}</span>
      <span class="mobile-icon-commentLink-todo-grn"></span><span>{$comment.todo_title|escape}</span>
    </a>
  </div>
  {if $comment.content || $comment.parent_no}
  <div class="mobile-commentLink-todo-content-grn">
    {if $comment.parent_no}
      {cb_msg module='grn.space.discussion' key='GRN_SP_DISC-21' replace='true'}{$comment.parent_no}<br>
    {/if}
    {if $comment.is_rich_text}
      {$comment.content|grn_mobile_link_format}
    {else}
      {grn_mobile_format body=$comment.content}
    {/if}
  </div>
  {/if}
{else}
  {if $comment.content || $comment.parent_no}
  <div class="mobile-todo-content-grn">
    {if $comment.parent_no}
      {cb_msg module='grn.space.discussion' key='GRN_SP_DISC-21' replace='true'}{$comment.parent_no}<br>
    {/if}
    {if $comment.is_rich_text}
      {$comment.content|grn_mobile_link_format}
    {else}
      {grn_mobile_format body=$comment.content}
    {/if}
  </div>
  {/if}
{/if}
  {if $comment.attachment}
  <div class="mobile-btn-list-grn mobile-li-PersonInCharge-grn">
    {foreach from=$comment.attachment item=file}
      {grn_mobile_attach_file_link name=$file.name dpage="space/mobile/file_download" spid=$space_id tid=$discussion_id fid=$file.id}
    {/foreach}
  </div>
  {/if}
  {capture name="reply_url"}
    {if $comment.is_todo_comment}
      {grn_pageurl page=$todo_prefix|cat:'/comment_detail' spid=$space_id tdid=$comment.todo_id cmid=$comment.id}
    {else}
      {grn_pageurl page=$discussion_prefix|cat:'/comment_detail' spid=$space_id tid=$discussion_id cmid=$comment.id}
    {/if}
  {/capture}

  {capture name="reply_all_url"}{strip}
    {if !$comment.is_todo_comment}
      {grn_pageurl page=$discussion_prefix|cat:'/comment_detail' spid=$space_id tid=$discussion_id cmid=$comment.id is_reply_all=true}
    {/if}
  {/strip}{/capture}

  {capture name="delete_url"}
  {if $comment.is_todo_comment}
    {grn_pageurl page=$todo_prefix|cat:"/comment_delete" spid=$space_id tdid=$comment.todo_id cmid=$comment.id}
  {else}
    {grn_pageurl page=$discussion_prefix|cat:"/comment_delete" spid=$space_id tid=$discussion_id cmid=$comment.id}
  {/if}
  {/capture}
  {include file="grn/mobile_comment_operating.tpl" favour_info=$comment.favour_info deletable=$comment.deletable}
</li>
{/foreach}

<script>
    {literal}
    $(".js_comment").each(function () {
        var settings = {
            element: $(this),
            params: {comment_id: $(this).data('comment-id')},
            url: "grn/space/ajax/get_remaining_members_of_mention"
        };
        new grn.js.component.common.ui.show_more.mobile.MobileMemberListShowMore(settings).render();
    })
    {/literal}
</script>
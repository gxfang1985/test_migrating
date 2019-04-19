{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{if ! $page_prefix}{assign var='page_prefix' value='space/mobile/application'}{/if}
{if ! $todo_prefix}{assign var='todo_prefix' value=$page_prefix|cat:'/todo'}{/if}
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
{assign var="form_name" value=$smarty.template|basename}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-padding-grn">
    {include file='grn/mobile_breadcrumb.tpl' not_need_withList=true}
    <div class="mobile-cmt-input-grn">
      <span class="mobile-num-writeback-grn">{cb_msg module='grn.space.todo' key='GRN_SP_TOD-49' replace='true'}{$comment.comment_no}</span>
        <form class="mobile_comment_form_grn" name="{$form_name}" method="post" enctype="multipart/form-data" data-ajax="false" action="{grn_pageurl page='space/mobile/application/todo/command_comment_add'}">
          <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
          <input type="hidden" id="spid" name="spid" value="{$comment.space_id}">
          <input type="hidden" id="tdid" name="tdid" value="{$comment.todo_id}">
          <input type="hidden" id="reply_comment_id" name="reply_comment_id" value="{$comment.id}">
          {include file="grn/mobile_comment_add.tpl" form_name=$form_name}
          <div class="mobile-buttonArea-grn">
            <div class="mobile-buttonMain-grn mobile-button-left-grn mobile_show_overlay_js">
              <input type="submit" name="send" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-35' replace='true'}" />
            </div>
            <div class="mobile-buttonNormal-grn mobile-button-right-grn mobile_show_overlay_js">
              <input type="button" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-41' replace='true'}"
                 onclick='location.href="{grn_pageurl page='space/mobile/application/todo/detail' spid=$comment.space_id tdid=$comment.todo_id}";' />
            </div>
          </div>
        </form>
    </div>
    <div class="mobile-cmt-dArray-grn"></div>
    <div class="{$li_class}">
      <div class="{$div_class}">
        <span class="mobile-num-list-grn">{$comment.comment_no|escape}</span>
        <div class="mobile-user-list-grn">
          <span></span>{$comment.creator|escape}</div>
        <div class="mobile-date-list-grn">
          <span>{$comment.ctime|escape}</span></div>
      </div>
      {if $comment.parent_no}
        {cb_msg module='grn.space.todo' key='GRN_SP_TOD-49' replace='true'}{$comment.parent_no}<br>
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
<!-- end of content-->
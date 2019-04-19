{assign var='todo_prefix' value='space/mobile/application/todo'}
{foreach from=$todo_comments item=comment}
  {assign var='li_class' value=''}
  {if $comment.unread}
    {assign var='li_class' value='mobile-list-unread-grn'}
  {else}
    {assign var='li_class' value='mobile-list-normal-grn'}
  {/if}
  {if $comment.creator_type == 'login_user'}
    {assign var='li_class' value=$li_class|cat:' mobile-list-login-grn'}
    {assign var='div_class' value='mobile-listHeader-login-grn'}
  {else}
    {assign var='div_class' value='mobile-listHeader-unlogin-grn'}
    {if $comment.creator_type == 'invalid_user'}
      {assign var='li_class' value=$li_class|cat:' mobile-userInvalid-grn'}
    {elseif $comment.creator_type == 'invalidApp_user'}
      {assign var='li_class' value=$li_class|cat:' mobile-userInvalidApp-grn'}
    {else}
      {assign var='li_class' value=$li_class|cat:' mobile-list-unlogin-grn'}
    {/if}
  {/if}
  <li data-icon="false" class="{$li_class}">
      <div class="{$div_class}">
        <span class="mobile-num-list-grn">{$comment.comment_no|escape}</span>
        <div class="mobile-user-list-grn"><span></span>{$comment.creator->getDisplayName()|escape}</div>
        <div class="mobile-date-list-grn"><span>{$comment.ctime|escape}</span></div>
      </div>
      <div class="mobile-todo-content-grn">
      {if $comment.parent_no}
        {cb_msg module='grn.space.discussion' key='GRN_SP_DISC-21' replace='true'}{$comment.parent_no}<br>
      {/if}
      {if $comment.is_rich_text}
        {$comment.data|grn_mobile_link_format}
      {else}
        {grn_mobile_format body=$comment.data}
      {/if}</div>
      {if $comment.attach_files}
      <div class="mobile-btn-list-grn mobile-attachmentButton-grn">
        {foreach from=$comment.attach_files item=file}
          {grn_mobile_attach_file_link name=$file.name dpage="space/mobile/file_download" fid=$file.id tid=$thread->getId() spid=$space_id}
        {/foreach}
      </div>
      {/if}
      {capture name="reply_url"}
        {grn_pageurl page=$todo_prefix|cat:'/comment_detail' spid=$space_id tdid=$todo->getId() cmid=$comment.id}
      {/capture}
      {capture name="delete_url"}
        {grn_pageurl page=$todo_prefix|cat:"/comment_delete" spid=$space_id tdid=$todo->getId() cmid=$comment.id}
      {/capture}
      {include file="grn/mobile_comment_operating.tpl" favour_info=$comment.favour_info deletable=$comment.deletable}
  </li>
{/foreach}
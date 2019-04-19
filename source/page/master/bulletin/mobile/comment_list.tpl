{assign var='bulletin_prefix' value='bulletin/mobile'}
{if ! $file_dpage}{assign var='file_dpage' value='bulletin/mobile/file_download'}{/if}
{foreach from=$article.follows item=follow}
  {assign var='li_class' value=''}
  {if $follow.unread}
    {assign var='li_class' value='mobile-list-unread-grn'}
  {else}
    {assign var='li_class' value='mobile-list-normal-grn'}
  {/if}
  {if $follow.creator_type == 'login_user'}
    {assign var='li_class' value=$li_class|cat:' mobile-list-login-grn'}
    {assign var='div_class' value='mobile-listHeader-login-grn'}
  {else}
    {assign var='div_class' value='mobile-listHeader-unlogin-grn'}
    {if $follow.creator_type == 'invalid_user'}
      {assign var='li_class' value=$li_class|cat:' mobile-userInvalid-grn'}
    {elseif $follow.creator_type == 'invalidApp_user'}
      {assign var='li_class' value=$li_class|cat:' mobile-userInvalidApp-grn'}
    {else}
      {assign var='li_class' value=$li_class|cat:' mobile-list-unlogin-grn'}
    {/if}
  {/if}
  <li data-icon="false" class="{$li_class}">
      <div class="{$div_class}">
        <span class="mobile-num-list-grn">{$follow.id|escape}</span>
        <div class="mobile-user-list-grn"><span></span>{grn_user_name uid=$follow.creator_uid only_text=true name=$follow.creator_name users_info=$users_info}</div>
        <div class="mobile-date-list-grn"><span>{grn_date_format date=$follow.ctime format='DateTimeMiddle_YMDW_HM'}</span></div>
      </div>
      <div class="mobile-todo-content-grn">
          {grn_mobile_format body=$follow.data}
      </div>
      {if $follow.attach_files}
      <div class="mobile-btn-list-grn mobile-attachmentButton-grn">
        {foreach from=$follow.attach_files item=file}
          {grn_mobile_attach_file_link name=$file.name dpage=$file_dpage fid=$file.id cid=$article.cid aid=$article.aid}
        {/foreach}
      </div>
      {/if}
      {if $article.can_follow && $article.auth.follow}
        {capture name="reply_url"}
          {grn_pageurl page=$bulletin_prefix|cat:'/comment_detail' cid=$article.cid aid=$article.aid follow_id=$follow.follow_id}
        {/capture}
      {/if}
      {capture name="delete_url"}
        {grn_pageurl page=$bulletin_prefix|cat:"/comment_delete" cid=$article.cid aid=$article.aid follow_id=$follow.follow_id}
      {/capture}
      {include file="grn/mobile_comment_operating.tpl" favour_info=$follow.favour_info deletable=$follow.deletable}
  </li>
{/foreach}

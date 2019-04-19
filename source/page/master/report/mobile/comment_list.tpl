{assign var='report_prefix' value='report/mobile'}
{if ! $file_dpage}{assign var='file_dpage' value='report/mobile/file_download'}{/if}
{foreach from=$follow_list item=follow}
  {if $readstatus && $follow.ctime->unix_ts > $readstatus.last_timestamp}
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
      <span class="mobile-num-list-grn">{$follow.follow_id|escape}</span>
      <div class="mobile-user-list-grn"><span></span>{grn_user_name uid=$follow.creator only_text=true name=$follow.creator_name users_info=$users_info}</div>
      <div class="mobile-date-list-grn"><span>{grn_date_format date=$follow.ctime format='DateTimeMiddle_YMDW_HM'}</span></div>
    </div>
    <div class="mobile-todo-content-grn">
        {grn_mobile_format body=$follow.data}
    </div>
    {if $follow.attach_files}
    <div class="mobile-btn-list-grn mobile-attachmentButton-grn">
      {foreach from=$follow.attach_files item=file}
        {grn_mobile_attach_file_link name=$file.file_info.name dpage=$file_dpage fid=$file.file rid=$report_id}
      {/foreach}
    </div>
    {/if}
    {if $report.enable_follow}
      {capture name="reply_url"}
        {grn_pageurl page=$report_prefix|cat:'/comment_detail' rid=$report_id follow_id=$follow.id}
      {/capture}
    {/if}
    {capture name="delete_url"}
      {grn_pageurl page=$report_prefix|cat:'/comment_delete' rid=$report_id follow_id=$follow.id}
    {/capture}
    {include file="grn/mobile_comment_operating.tpl" deletable=$follow.deletable}
  </li>
{/foreach}
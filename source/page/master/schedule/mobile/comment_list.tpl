{assign var='schedule_prefix' value='schedule/mobile'}
{foreach from=$follow_list item=follow}
  {assign var='li_class' value='mobile-list-normal-grn'}
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
      <div class="mobile-user-list-grn"><span></span>{grn_user_name uid=$follow.creator_uid only_text=true name=$follow.creator_name users_info=$users_info}</div>
      <div class="mobile-date-list-grn"><span>{grn_date_format date=$follow.ctime format='DateTimeMiddle_YMDW_HM'}</span></div>
    </div>
    <div class="mobile-todo-content-grn">
        {grn_mobile_format body=$follow.data}
    </div>
    {capture name="delete_url"}
      {grn_pageurl page=$schedule_prefix|cat:"/comment_delete" event=$event_id bdate=$bdate uid=$user_id gid=$group_id follow_id=$follow.follow_id referer_key=$referer_key}
    {/capture}
    {include file="grn/mobile_comment_operating.tpl" deletable=$follow.deletable}
  </li>
{/foreach}
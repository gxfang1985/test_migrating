{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var='schedule_prefix' value='schedule/mobile'}
{if $follow.creator_type == 'login_user'}
  {assign var='li_class' value='mobile-list-login-grn'}
  {assign var='div_class' value='mobile-listHeader-login-grn'}
{else}
  {assign var='div_class' value='mobile-listHeader-unlogin-grn'}
  {if $follow.creator_type == 'invalid_user'}
    {assign var='li_class' value='mobile-userInvalid-grn'}
  {elseif $follow.creator_type == 'invalidApp_user'}
    {assign var='li_class' value='mobile-userInvalidApp-grn'}
  {else}
    {assign var='li_class' value='mobile-list-unlogin-grn'}
  {/if}
{/if}
{assign var='li_class' value=$li_class|cat:' mobile-cmt-operate-grn'}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-padding-grn">
{include file="grn/mobile_breadcrumb.tpl" not_need_withList=true}
  <div class="{$li_class}">
    <div class="{$div_class}">
      <span class="mobile-num-list-grn">{$follow.follow_id|escape}</span>
      <div class="mobile-user-list-grn"><span></span>{grn_user_name uid=$follow.creator_id only_text=true name=$follow.creator_name users_info=$user_info}</div>
      <div class="mobile-date-list-grn"><span>{grn_date_format date=$follow.ctime format='DateTimeMiddle_YMDW_HM'}</span></div>
    </div>
    <div class="mobile-todo-content-nomark-grn">
        {grn_mobile_format body=$follow.data}
    </div>
  </div>
</div>
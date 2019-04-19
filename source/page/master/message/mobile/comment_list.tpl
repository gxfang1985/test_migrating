{assign var='message_prefix' value='message/mobile'}
{if ! $file_dpage}{assign var='file_dpage' value='message/mobile/file_download'}{/if}
{foreach from=$message.follow item=follow}
  {assign var='li_class' value=''}
  {if $follow.update eq "0"}
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
  <li data-icon="false" class="{$li_class} js_comment" data-comment-id="{$follow.follow_id}">
      <div class="{$div_class}">
        <span class="mobile-num-list-grn">{$follow.id|escape}</span>
        <div class="mobile-user-list-grn"><span></span>{grn_user_name uid=$follow.creator_uid only_text=true name=$follow.creator_name users_info=$users_info}</div>
        <div class="mobile-date-list-grn"><span>{grn_date_format date=$follow.ctime format='DateTimeMiddle_YMDW_HM'}</span></div>
      </div>
      {if $follow.mention}
          {capture name=comment_mention}
              {strip}
                  <div class="mobile_mention_comment_base_grn">
                      {grn_members_name_with_dialog_for_mention
                      app_id='message'
                      members=$follow.mention
                      total_member=$follow.mention_count
                      ul_attribute='class="mobile_ul_style_off_grn"'
                      is_mobile=true}
                  </div>
              {/strip}
          {/capture}
          {$smarty.capture.comment_mention|grn_noescape}
      {/if}
      <div class="mobile-todo-content-grn">
          {grn_mobile_format body=$follow.data}
      </div>
      {if $follow.attach_files}
      <div class="mobile-btn-list-grn mobile-attachmentButton-grn">
        {foreach from=$follow.attach_files item=file}
          {grn_mobile_attach_file_link name=$file.name dpage=$file_dpage cid=$message.cid rid=$rid mid=$message.mid rfid=$file.rfid}
        {/foreach}
      </div>
      {/if}
      {if $can_follow}
        {capture name="reply_url"}
          {grn_pageurl page=$message_prefix|cat:'/comment_detail' cid=$message.cid rid=$rid mid=$message.mid follow_id=$follow.follow_id}
        {/capture}
        {capture name="reply_all_url"}{strip}
          {grn_pageurl page=$message_prefix|cat:'/comment_detail' cid=$message.cid rid=$rid mid=$message.mid follow_id=$follow.follow_id is_reply_all=1}
        {/strip}{/capture}
          {assign var='favour_info' value=$follow.favour_info}
      {else}
          {assign var='favour_info' value=""}
      {/if}
      {capture name="delete_url"}
        {grn_pageurl page=$message_prefix|cat:'/comment_delete' cid=$message.cid rid=$rid mid=$message.mid follow_id=$follow.follow_id}
      {/capture}
      {include file="grn/mobile_comment_operating.tpl" favour_info=$favour_info deletable=$follow.deletable}
  </li>
{/foreach}
<script>
    {literal}
    $(".js_comment").each(function () {
        var settings = {
            element: $(this),
            params: {follow_id: $(this).data("comment-id")},
            url: "grn/message/ajax/get_remaining_members_of_mention"
        };
        new grn.js.component.common.ui.show_more.mobile.MobileMemberListShowMore(settings).render();
    });
    {/literal}
</script>

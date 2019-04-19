{include file='grn/ajax/mobile_member_list_dialog.tpl'}
{grn_load_javascript file="grn/html/component/validator_mobile.js"}
{grn_load_javascript file="js/dist/message_mobile.js"}
{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var='message_prefix' value='message/mobile'}
{if ! $file_dpage}{assign var='file_dpage' value='message/mobile/file_download'}{/if}
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
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-grn mobile-content-padding-grn">
  {include file="grn/mobile_breadcrumb.tpl" not_need_withList=true}
  {if $comment.can_follow}
  <div class="mobile-cmt-input-grn">
    <span class="mobile-num-writeback-grn js_reply_num">{cb_msg module='grn.grn' key='GRN_GRN-1537' replace='true'}{$comment.id|escape}</span>
      <form name="{$form_name}" method="post" enctype="multipart/form-data" data-ajax="false" action="{grn_pageurl page='message/mobile/command_comment_add'}" class="mobile_comment_form_grn">
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <input type="hidden" id="cid" name="cid" value="{$comment.cid}">
        <input type="hidden" id="rid" name="rid" value="{$comment.rid}">
        <input type="hidden" id="mid" name="mid" value="{$comment.mid}">
        <input type="hidden" id="follow_id" name="follow_id" value="{$comment.follow_id}">
        <input type="hidden" name="mention"/>
        <div id="error_message_field"></div>
        {include file="grn/mobile_comment_add.tpl"
          name=message_reply_comment_add
          mention=TRUE
          mention_params=$mention_params
          mention_access_plugin_encoded=$mention_access_plugin_encoded
        }
        <div class="mobile-buttonArea-grn">
          <div class="mobile-buttonMain-grn mobile-button-left-grn mobile_show_overlay_js">
            <input type="button" class="js_submit_button" name="send" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.message' key='GRN_MSG-417' replace='true'}" />
          </div>
          <div class="mobile-buttonNormal-grn mobile-button-right-grn mobile_show_overlay_js">
            <input type="button" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.message' key='GRN_MSG-418' replace='true'}"
              onclick='location.href="{grn_pageurl page='message/mobile/view' cid=$comment.cid rid=$comment.rid mid=$comment.mid}";' />
          </div>
        </div>
      </form>
  </div>
  <div class="mobile-cmt-dArray-grn"></div>
  {/if}
  <div id="comment_container">
    <div class="{$li_class} js_comment" data-comment-id="{$comment.follow_id}">
      <div class="{$div_class}">
        <span class="mobile-num-list-grn">{$comment.id|escape}</span>
        <div class="mobile-user-list-grn js_comment_creator" data-user-id="{$comment.creator_id}" data-user-url="{$comment.creator_url}"><span></span>{grn_user_name uid=$comment.creator_id only_text=true name=$comment.creator_name users_info=$users_info}</div>
        <div class="mobile-date-list-grn"><span>{grn_date_format date=$comment.ctime format='DateTimeMiddle_YMDW_HM'}</span></div>
      </div>
      {if $comment.mention}
          {capture name=comment_mention}
              {strip}
                <div class="mobile_mention_comment_base_grn">
                    {grn_members_name_with_dialog_for_mention
                    app_id='message'
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
          {grn_mobile_format body=$comment.data}
      </div>
      {if count($comment.files) gt 0}
      <div class="mobile-btn-list-grn mobile-attachmentButton-grn">
        {foreach from=$comment.files key=file_id item=file}
          {grn_mobile_attach_file_link name=$file.name dpage=$file_dpage rfid=$file_id cid=$comment.cid rid=$comment.rid mid=$comment.mid}
        {/foreach}
      </div>
      {/if}
    </div>
  </div>
</div>
<!-- end of content-->
{literal}
<script>
    $(document).on("ready", function (event) {
        // Initialize Mention component
        let settings = {
            {/literal}
            name: "message_reply_comment_add_mention",
            formName: "{$form_name}",
            commentId: "{$comment.follow_id}",
            accessPluginEncoded: "{$mention_access_plugin_encoded}",
            commentContainer: "#comment_container",
            isReplyAll: "{$comment.is_reply_all}",
            {literal}
        };
        new grn.js.page.message.mobile.CommentDetail(settings);
    });
</script>
{/literal}
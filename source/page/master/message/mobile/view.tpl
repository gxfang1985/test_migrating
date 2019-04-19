{grn_load_javascript file="grn/html/component/i18n.js"}
{grn_load_javascript_resource}
{include file='favour/mobile/_favour_common.tpl'}
{include file='grn/ajax/mobile_member_list_dialog.tpl'}
{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var='message_prefix' value='message/mobile'}
{if ! $file_dpage}{assign var='file_dpage' value='message/mobile/file_download'}{/if}
{literal}
<script language="JavaScript" text="text/javascript">
(function(){{/literal}
    var GS = grn.component.mobile_common;
    GS.comment_add_url = '{grn_pageurl page=$message_prefix|cat:"/comment_add"}';
    GS.add_comment_args = {ldelim}'cid' : '{$message.cid}',
                                  'rid' : '{$rid}',
                                  'mid' : '{$message.mid}',
                                  'sp'  : '{$sp}'{rdelim};
{literal}
})()
</script>
{/literal}
<div data-role="content" data-theme="{$data_theme}" class="mobile-content-padding-grn">
  {include file="grn/mobile_breadcrumb.tpl" not_need_withList=true}
  {if $message.is_snapshot neq '1' and $folder_type neq '4'}
    {if $message.type neq '1' and $message.need_confirm eq '1' and $message.confirmed neq '1'}
    <form name="follow_form" method="post" action="{grn_pageurl page='message/mobile/command_view'}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <div class="mobile-cmt-operate-grn">
            <div class="mobile_button_detail_grn">
              <div data-theme="{$data_theme}" class="mobile_button_area_grn">
                <div class="mobile_cancel_grn">
               <input type="submit" value="{cb_msg module='grn.message' key='GRN_MSG-423' replace='true'}" data-inline="true" data-theme="{$data_theme}" onclick="cmd.value='confirm';"/></div>
               </div>
            </div>
        </div><!--mobile-cmt-operate-grn-->
        <input type="hidden" name="cmd">
        <input type="hidden" name="cid" value="{$message.cid}">
        <input type="hidden" name="rid" value="{$rid}">
        <input type="hidden" name="mid" value="{$message.mid}">
    </form>
    {/if}
  {/if}
  <ul data-role="none" class="mobile-ul-withStar-grn mobile-textspace-withStar-grn mobile-detailTitle-grn">
    <li>
      {strip}
        {if $use_star}
            {include file="grn/mobile_star_init.tpl"}
            {grn_mobile_star_icon module="grn.message" star_infos=$star_infos unique_id=$message.mid mid=$message.mid cid=$message.cid rid=$rid}
        {/if}
        <span>{$message.subject}</span>
      {/strip}
    </li>
  </ul>
  <div class="mobile-list-login-grn mobile-cmt-operate-grn mobile-todoBodyText-grn">
    <div class="mobile-separation-grn"></div>
    <div class="mobile-list-todoDetail-grn">
      <div class="mobile-label-small-grn">{cb_msg module='grn.message' key='GRN_MSG-106' replace='true'}</div>
      <div class="mobile-contents-todoDetail-grn mobile_todo_username_grn">{grn_user_name uid=$message.creator_uid name=$message.creator_name users_info=$users_info only_text=true}<span class="mobile-date-list-grn">{grn_date_format date=$message.ctime format="DateTimeMiddle_YMDW_HM"}</span></div>
    </div>
    <ul data-role="listview" data-theme="{$data_theme}" class="mobile-li-PersonInCharge-grn mobile-div-title-grn">
        <div class="mobile-separation-grn"></div>
        <li data-icon="false">
            {if $message.addressee_num gt 0}
            <a href="{grn_pageurl page=$message_prefix|cat:'/addressee_list' cid=$message.cid rid=$rid mid=$message.mid sp=$sp}">
              <div class="mobile-label-small-grn">{cb_msg module='grn.message' key='GRN_MSG-110' replace='true'}</div>
              <div class="mobile_for_totalnumber_grn">
                {foreach from=$message.addressee item=attendee_name}
                  <div class="mobile-font-warp-grn">{grn_user_name uid=$attendee_name.id name=$attendee_name.name users_info=$users_info only_text=true}</div>
                {/foreach}
              </div><!--mobile_for_totalnumber_grn-->
              <span class="totalNumber-grn">{$message.addressee_num}</span>
              <span class="mobile-array-todo-grn"></span>
            </a>
            {else}
            <div class="mobile-label-small-grn">{cb_msg module='grn.message' key='GRN_MSG-110' replace='true'}</div>
            {/if}
        </li>
        <div class="mobile-separation-grn"></div>
    </ul>
    <div class="mobile-list-todoDetail-grn">
        {if $message.update eq "0"}
        <div class="mobile-textspace-unread-grn">
        {elseif $message.data || $message.attach_files}
            <div class="mobile-textspace-div-grn">
        {/if}
            <div class="mobile-label-small-grn">{cb_msg module='grn.message' key='GRN_MSG-15' replace='true'}</div>
        {if $message.data || $message.attach_files}<div class="mobile-contents-todoDetail-grn">{/if}
        {if $message.data}
            <span class="mobile-font-normal-grn">{grn_mobile_format body=$message.data}</span>
        {/if}
        {if $message.attach_files}
            <div class="mobile-attachmentButton-grn">
            {foreach from=$message.attach_files item=file}
                {grn_mobile_attach_file_link name=$file.name dpage=$file_dpage cid=$message.cid rid=$rid mid=$message.mid rfid=$file.rfid}
            {/foreach}
            </div>
        {/if}
        {if $message.data || $message.attach_files}</div>{/if}
        {if $message.update eq "0" || $message.data || $message.attach_files}
            </div>
        {/if}
            {if $can_follow}
                <div class="mobile-list-todoDetail-grn">
                    {include file="favour/mobile/_favour.tpl"}
                </div>
            {/if}
    </div>
    {if $message.modifier_uid neq ''}
        <div class="mobile-separation-grn"></div>
        <div class="mobile-list-todoDetail-grn">
            <div class="mobile-label-small-grn">{cb_msg module='grn.message' key='GRN_MSG-108' replace='true'}</div>
            <div class="mobile-contents-todoDetail-grn mobile_todo_username_grn">{grn_user_name uid=$message.modifier_uid name=$message.modifier_name users_info=$users_info only_text=true}<span class="mobile-date-list-grn">{grn_date_format date=$message.mtime format="DateTimeMiddle_YMDW_HM"}</span></div>
        </div>
    {/if}
  </div>
{if $message.is_snapshot neq '1' and $folder_type neq '4'}
    {if $message.type neq '1' and $message.need_confirm eq '1' and $message.confirmed neq '1'}
    <div class="mobile-addCommentDisable-grn" id="comment_top"></div>
    {else}
  <div class="mobile-separation-grn"></div>
  <div class="mobile-comment-grn mobile-todoAddComment-grn" id="comment_top">
    <input type="text" name="title" value="{cb_msg module='grn.message' key='GRN_MSG-419' replace='true'}" readonly="readonly" onclick="javascript:grn.component.mobile_common.toAddComment();"/>
  </div>
    {/if}
{else}
    <div class="mobile-addCommentDisable-grn" id="comment_top"></div>
{/if}
{if count($message.follow) gt 0}
  <div class="mobile_comment_list_grn">
    <ul data-role="listview" data-theme="{$data_theme}" class="mobile-ul-bottom-grn mobile-padding-leftright-grn" id="comment_list">
      {include file=$message_prefix|cat:'/comment_list.tpl'}
    </ul>
  </div>
{/if}
  {include file='grn/mobile_list_more_view.tpl' request_page=$message_prefix|cat:'/ajax/comment_list' list_id='comment_list' trigger_create=true}
</div><!--content-->
{literal}
<script>
    (function () {
        var settings = {
            {/literal}
            accessPluginEncoded: "{$mention_access_plugin_encoded}",
            {literal}
        };
        var dialog = new grn.js.component.common.ui.dialog.MobileMemberListDialog(settings);
        dialog.render();
        dialog.bindDialogToMembersContainer("#comment_list");
    })();
</script>
{/literal}

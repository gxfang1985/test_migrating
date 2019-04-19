{if ! $data_theme}{assign var='data_theme' value='c'}{/if}
{assign var='bulletin_prefix' value='bulletin/mobile'}
{if ! $file_dpage}{assign var='file_dpage' value='bulletin/mobile/file_download'}{/if}
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
  {include file="grn/mobile_breadcrumb.tpl" not_need_withList=true}
  {if $comment.can_follow && $comment.auth.follow}
  <div class="mobile-cmt-input-grn">
    <span class="mobile-num-writeback-grn">{cb_msg module='grn.grn' key='GRN_GRN-1537' replace='true'}{$comment.id|escape}</span>
      <form class="mobile_comment_form_grn" name="{$form_name}" method="post" enctype="multipart/form-data" data-ajax="false" action="{grn_pageurl page='bulletin/mobile/command_comment_add'}">
        <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
        <input type="hidden" id="cid" name="cid" value="{$comment.cid}">
        <input type="hidden" id="aid" name="aid" value="{$comment.aid}">
        <input type="hidden" id="follow_id" name="follow_id" value="{$comment.follow_id}">
        {include file="grn/mobile_comment_add.tpl" form_name=$form_name}
        <div class="mobile-buttonArea-grn">
          <div class="mobile-buttonMain-grn mobile-button-left-grn mobile_show_overlay_js">
            <input type="submit" name="send" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-152' replace='true'}" />
          </div>
          <div class="mobile-buttonNormal-grn mobile-button-right-grn mobile_show_overlay_js">
            <input type="button" data-inline="true" data-theme="{$data_theme}" value="{cb_msg module='grn.bulletin' key='GRN_BLLT-598' replace='true'}"
               onclick='location.href="{grn_pageurl page='bulletin/mobile/view' cid=$comment.cid aid=$comment.aid}";' />
          </div>
        </div>
    </form>
  </div>
  <div class="mobile-cmt-dArray-grn"></div>
  {/if}
  <div class="{$li_class}">
    <div class="{$div_class}">
      <span class="mobile-num-list-grn">{$comment.id|escape}</span>
      <div class="mobile-user-list-grn"><span></span>{grn_user_name uid=$comment.creator_uid only_text=true name=$comment.creator_name users_info=$users_info}</div>
      <div class="mobile-date-list-grn"><span>{grn_date_format date=$comment.ctime format='DateTimeMiddle_YMDW_HM'}</span></div>
    </div>
    <div class="mobile-todo-content-nomark-grn">
        {grn_mobile_format body=$comment.data}
    </div>
    {if $comment.attach_files}
    <div class="mobile-btn-list-grn mobile-attachmentButton-grn">
      {foreach from=$comment.attach_files item=file}
        {grn_mobile_attach_file_link name=$file.name dpage=$file_dpage fid=$file.id cid=$comment.cid aid=$comment.aid}
      {/foreach}
    </div>
    {/if}
  </div>
</div>

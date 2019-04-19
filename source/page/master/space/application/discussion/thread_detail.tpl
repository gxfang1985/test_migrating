{if ! $page_prefix}{assign var='page_prefix' value='space/application'}{/if}
{if ! $discussion_prefix}{assign var='discussion_prefix' value=$page_prefix|cat:'/discussion'}{/if}
{if ! $file_prefix}{assign var='file_prefix' value='space/application/discussion'}{/if}
{if ! $file_dpage}{assign var='file_dpage' value='space/file_download'}{/if}
{if ! $file_vpage}{assign var='file_vpage' value=$file_prefix|cat:'/file_view'}{/if}
<div id="threadDeleteDlg-grn" style="display:none">{include file="space/application/discussion/thread_delete.tpl"}</div>

{if $thread_write_auth || $thread_read_auth || $has_privilege}
<div class="space-threadTextBody-menu-grn">
  <div id="thread_operation" class="space-thread-operations-grn" style="display:none">
    <ul>
      {if $thread_write_auth || $has_privilege}
        <li>
          {capture name='grn_space_GRN_SP_DISC_11'}{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-11' replace='true'}{/capture}
          {grn_link id="thread_edit_link" page=$discussion_prefix|cat:'/modify' caption=$smarty.capture.grn_space_GRN_SP_DISC_11 class="icon-edit-grn" spid=$space_id tid=$thread_obj->getId()}
        </li>
        {if $deletable}
          <li>
            <a class="icon-delete-grn" id="lnk_delete" href="javascript:__thisPage.deleteThread('{$delete_info.title|escape}', jQuery('#threadDeleteDlg-grn').html());">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-12' replace='true'}</a>
          </li>
        {/if}
      {/if}
      {if $thread_read_auth}
        <li>
          {include file="space/application/discussion/notification_user_list_dialog_link.tpl" spid=$space_id tid=$thread_obj->getId()}
        </li>
      {/if}
    </ul>
  </div>
  {if $thread_read_auth}
    <span id="thread_follow_loading"></span>
    <div id="follow_button" class="{if $subscribe}buttonFollowOn-grn{else}buttonFollowOff-grn{/if}">
      <a id="follow_link" href="javascript:void(0);" onclick="javascript:__thisPage.subscribe();">
        {if $subscribe}
          {cb_msg module='grn.space.discussion' key='GRN_SP_DISC-49' replace='true'}
        {else}
          {cb_msg module='grn.space.discussion' key='GRN_SP_DISC-51' replace='true'}
        {/if}
      </a>
    </div>
  {/if}
  <span id="thread_menu" class="icon-showMenu-grn">{grn_image image="image-common/menu_a16.png" height=16 width=16}</span>
</div>
{/if}

<h3>
{if $use_star}
<div id="thread_star_list" >{grn_star_icon module="grn.space" star_infos=$star_infos submdl=$sub_module unique_id=$thread_obj->getId() spid=$space_id tid=$thread_obj->getId() height=20 width=20}
{/if}
{$thread_obj->getTitle()|escape}
{if $use_star}
</div>
{/if}
</h3>

<div class="clear_both"></div>
<div class="space-threadTextBody-border-grn"></div>
{if $thread_obj->getContent() || $attached_files}
{if $thread_obj->isUnread()}
<div class="unread_color">
{/if}
  <div class="mLeft10">
    {if $thread_obj->isRichText()}{$thread_obj->getContent()|grn_noescape}{else}{grn_format body=$thread_obj->getContent()}{/if}
  </div>
  {if $attached_files}
  <div class="space-thread-attachedFile-grn">
    <ul>
      {foreach from=$attached_files item=file}
      <li>{grn_space_attach_file_link name=$file.name dpage=$file_dpage vpage=$file_vpage mime=$file.mime size=$file.size fid=$file.id tid=$thread_obj->getId() spid=$space_id inline=$inline hash=$file.hash upload=$thread_write_auth||$has_privilege upage=$file_prefix|cat:'/file_upload'}
      </li>
      {/foreach}
    </ul>
  </div>
  {/if}
  <div class="space-threadTextBody-info-grn mLeft3">
    <span class="space-itemlabel-grn">{cb_msg module='grn.space.discussion' key='GRN_SP_DISC-15' replace='true'}</span>
    {grn_space_user_link user=$thread_obj->getModifier()}
    <span class="space-datetime-grn">{$thread_obj->getModifyDisplayDatetime()|escape}</span>
  </div>
{if $thread_obj->isUnread()}
</div>
{/if}
{/if}

<div class="bodytext_footer_grn mLeft10 mTop5">
  {include file="grn/_favour.tpl"}
</div>

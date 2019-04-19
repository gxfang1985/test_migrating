{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{include file='grn/window_simple_dialog.tpl'}
{grn_load_javascript file="grn/html/component/member_list_dialog.js"}
{grn_load_javascript file="js/dist/message.js"}
{grn_title title=$message.subject class=$page_info.parts[0]}

<div id="main_menu_part">
<span class="menu_item">{capture name='grn_message_system_GRN_MSG_SY_58'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-58' replace='true'}{/capture}{grn_link page='message/system/inspection_export' postfix='notitle.txt' caption=$smarty.capture.grn_message_system_GRN_MSG_SY_58 image='disk20.gif' mid=$message.mid}</span>
<span class="menu_item">{capture name='grn_message_system_GRN_MSG_SY_59'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-59' replace='true'}{/capture}{grn_link page='message/system/inspection_accessory' caption=$smarty.capture.grn_message_system_GRN_MSG_SY_59 image='file20.gif' mid=$message.mid sort='1'}</span>
</div>

<p>
<table>
 <tr>
  <td nowrap>{cb_msg module='grn.message.system' key='GRN_MSG_SY-60' replace='true'}</td><td nowrap>&nbsp;{cb_msg module='grn.message.system' key='GRN_MSG_SY-61' replace='true'}&nbsp;</td>
  <td nowrap>
       {grn_user_name uid=$message.creator_uid name=$message.creator_name}
       {grn_date_format date=$message.ctime format="DateTimeMiddle_YMDW_HM"}
  </td>
 </tr>
{if $message.mtime neq '' && $message.modifier_uid neq ''}
 <tr>
  <td nowrap>{cb_msg module='grn.message.system' key='GRN_MSG_SY-62' replace='true'}</td><td nowrap>&nbsp;{cb_msg module='grn.message.system' key='GRN_MSG_SY-63' replace='true'}&nbsp;</td>
  <td nowrap>
       {grn_user_name uid=$message.modifier_uid name=$message.modifier_name}
       {grn_date_format date=$message.mtime format="DateTimeMiddle_YMDW_HM"}
  </td>
 </tr>
{/if}
 <tr>
  <td nowrap>{cb_msg module='grn.message.system' key='GRN_MSG_SY-64' replace='true'}</td><td nowrap>&nbsp;{cb_msg module='grn.message.system' key='GRN_MSG_SY-65' replace='true'}&nbsp;</td>
  <td>
       {grn_message_addressee message=$message}
  </td>
 </tr>
 <tr>
  <td></td>
  <td></td>
  <td>
     <small><div>
       {capture name='grn_message_GRN_MSG_379'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-109' replace='true'}{/capture}{grn_link page='message/system/detail_address' caption=$smarty.capture.grn_message_GRN_MSG_379 image='detail20.gif' mid=$message.mid}
     </div></small>
  </td>
 </tr>
</table>
<hr size="1">
     {if $message.update eq "0"}<div class="contents_color">{else}<div class="contents bodytext_base_grn">{/if}
        <div class="margin_all">
      {if $message.format_type eq "0"}
       {grn_format body=$message.data}
      {else}
       {$message.data|grn_noescape}
      {/if}
        </div>
{if $message.attach_files}
 {foreach from=$message.attach_files item=attach_file}
       <br>{grn_attach_file_link name=$attach_file.name dpage="message/system/inspection_file_download" vpage="message/system/inspection_file_view" tpage="message/system/inspection_file_image_view" size=$attach_file.size mime=$attach_file.mime cid=$message.cid rid=$rid mid=$message.mid rfid=$attach_file.rfid frm='vw' hash=$attach_file.hash inline=$inline}
 {/foreach}
{/if}
{if $message.del_file_num gt 0}
       <p>
       {cb_msg module='grn.message.system' key='GRN_MSG_SY-70' replace='true'}&nbsp;<span class="bold">{$message.del_file_num}</span>&nbsp;{cb_msg module='grn.message.system' key='GRN_MSG_SY-71' replace='true'}
{/if}
        <div class="bodytext_footer_grn mLeft10 mTop5">
            {include file="grn/_favour.tpl" disable_link=TRUE}
        </div>
     </div>

{if $message.follow}
<hr size="1">
<a name="follow"></a>
     <div class="word_navi">
      {include file="grn/word_navi.tpl" navi=$navi_info.navi}
     </div>
<div id="message_comments">
 {foreach from=$message.follow item=follow}
<hr size="1">
    <a name="follow_{$follow.id}">{$follow.id}&nbsp;:</a>
    {grn_user_name uid=$follow.creator_uid name=$follow.creator_name|cb_mb_truncate:$name_width users_info=$users_info}
    {grn_date_format date=$follow.ctime format="DateTimeMiddle_YMDW_HM"}

    <div class="{if $follow.update eq "0"}contents_child_color{else}contents_child{/if} js_comment"
        id="thread_comment_{$follow.follow_id}"
        data-comment-no="{$follow.id}"
        data-comment-id="{$follow.follow_id}">
    {capture name=comment_mention}
        {strip}
            {if $mention_list[$follow.follow_id]}
                <div class="mention_comment_base_grn">
                    {grn_members_name_with_dialog_for_mention app_id='message' members=$mention_list[$follow.follow_id] total_member=$mention_count[$follow.follow_id]}
                </div>
            {/if}
        {/strip}
    {/capture}
    {$smarty.capture.comment_mention|grn_noescape}

         <div class="margin_all">
  {if $follow.format_type eq "0"}
   {grn_format body=$follow.data}
  {else}
   {$follow.data|grn_noescape}
  {/if}
         </div>
         <div class="bodytext_footer_grn mLeft10 mTop5">
  {if $follow.attach_files}
   {foreach from=$follow.attach_files item=attach_file}
    {if strlen($attach_file.name)}{grn_attach_file_link name=$attach_file.name dpage="message/system/inspection_file_download" vpage="message/system/inspection_file_view" tpage="message/system/inspection_file_image_view" size=$attach_file.size mime=$attach_file.mime mid=$message.mid rfid=$attach_file.rfid frm='vw' hash=$attach_file.hash inline=$inline}<br>
    {/if}
   {/foreach}
  {/if}
  {if $follow.del_file_num gt 0}
       {cb_msg module='grn.message.system' key='GRN_MSG_SY-72' replace='true'}&nbsp;<span class="bold">{$follow.del_file_num}</span>&nbsp;{cb_msg module='grn.message.system' key='GRN_MSG_SY-73' replace='true'}
  {/if}
         </div>
     </div>
         <div class="bodytext_footer_grn mLeft10 mTop5">
             <span class="mRight15">
                 {include file="grn/_favour.tpl" disable_link=TRUE favour_info=$follow.favour_info}
             </span>
         </div>


 {/foreach}
</div>
<hr size="1">
     <div class="word_navi">
      {include file="grn/word_navi.tpl" navi=$navi_info.navi}
     </div>
{/if}
{include file="grn/_favour_common.tpl"}
{include file="grn/system_footer.tpl"}
{literal}
    <script>
        (function () {
            var settings = {
                accessPluginEncoded: {/literal}"{$mention_access_plugin_encoded}"{literal}
            };
            new grn.js.page.message.system.InspectionView(settings);
        })();
    </script>
{/literal}
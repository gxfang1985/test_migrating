{if $portlet.settings.font_size == "large"}
 {assign var="font_size" value='font-size:140%;'}
 {assign var="fontsize" value='font-size:110%;'}
{elseif $portlet.settings.font_size == "normal"}
 {assign var="font_size" value=''}
 {assign var="fontsize" value='font-size:80%;'}
{elseif $portlet.settings.font_size == "small"}
 {assign var="font_size" value='font-size:70%;'}
 {assign var="fontsize" value='font-size:60%;'}
{else}
 {assign var="fontsize" value='font-size:80%;'}
{/if}
{if $use_star && $has_messages}
{literal}
<script type="text/javascript">
function grn_message_on_update_star(star_ele, params)
{
    var status = GRN_StarList.getStatus(star_ele);
    var mid = params.mid;
    GRN_StarList.getItems('message_list{/literal}{$portlet.plid}{literal}').each(function(){
        var item_params = GRN_StarList.parseParam(this);
        if(item_params.mid == mid){
          GRN_StarList.setStatus(this, status);
        }
    });
}
</script>
{/literal}
{/if}
<table class="top_title">{strip}
    <tbody>
    <tr>
        <td>
            <span class="portlet_title_grn">
                {if $settings.folder_name}
                    <a href="{grn_pageurl page='message/index' cid=$cid}">
                        <span class="portlet_title_name_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$page_title}</span>
                        <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">&nbsp;-&nbsp;</span>
                        <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-30' replace='true'}</span>
                        {$settings.folder_name|escape}
                        <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-31' replace='true'}</span>
                    </a>
                {else}
                    <a href="{grn_pageurl page='message/index'}">
                        <span class="portlet_title_name_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">{$page_title}</span>
                        <span class="portlet_title_symbol_grn" style="display: {if $display_name_mode == 'normal'}visible{else}none{/if};">&nbsp;-&nbsp;</span>
                        {cb_msg module='grn.message.portlet' key='GRN_MSG_PO-32' replace='true'}
                    </a>
                {/if}
            </span>
        </td>
    </tr>
    </tbody>
</table>{/strip}

<div class="portal_frame portal_frame_message_grn">
{if $has_messages}
{include file="star/star_init.tpl" list_id="message_list"|cat:$portlet.plid on_update="grn_message_on_update_star"}
<table class="list_column" style="{$font_size}" id="message_list{$portlet.plid}">
 <colgroup>
  {if $use_star}
  <col width="1%">
  {/if}
  <col width="40%">
  {if $settings.sender}
  <col width="20%">
  {/if}
  {if $settings.time}
  <col width="20%">
  {/if}
  {if $settings.remarks}
  <col width="20%">
  {/if}
 </colgroup>
 <tr>
  {if $use_star}
  <th nowrap><br /></th>
  {/if}
  <th nowrap>{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-33' replace='true'}</th>
{if $settings.sender}
    {if $settings.folder_type eq '2'}  {* 送信箱 *}
        <th nowrap>{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-34' replace='true'}</th>
   {else}
        <th nowrap>{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-35' replace='true'}</th>
   {/if}
{/if}
{if $settings.time}
  <th nowrap>{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-36' replace='true'}</th>
{/if}
{if $settings.remarks}
  <th nowrap>{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-37' replace='true'}</th>
{/if}
 </tr>
{foreach from=$messages.message key=rid item=message}
 <tr>
  {if $use_star}
  <td>{grn_star_icon module="grn.message" star_infos=$star_infos unique_id=$message.mid mid=$message.mid rid=$rid cid=$cid type=$message.type}</td>
  {/if}
  <td nowrap>
{if $message.type eq '0'} {* 受信メッセージ *}
 {if $message.attach_file} {* 添付ファイル付き *}
     {if $message.update}
         {grn_link page='message/view' caption=$message.subject image='msg20_u_clip8.gif' unread=$message.unread cid=$cid rid=$rid mid=$message.mid truncated_caption=$subject_width}
     {else}
         {grn_link page='message/view' caption=$message.subject image='msg20_clip8.gif' unread=$message.unread cid=$cid rid=$rid mid=$message.mid truncated_caption=$subject_width}
     {/if}
 {else}                    {* 添付ファイルなし *}
     {if $message.update}
         {grn_link page='message/view' caption=$message.subject image='msg20_u.gif' unread=$message.unread cid=$cid rid=$rid mid=$message.mid truncated_caption=$subject_width}
     {else}
         {grn_link page='message/view' caption=$message.subject image='msg20.gif' unread=$message.unread cid=$cid rid=$rid mid=$message.mid truncated_caption=$subject_width}
     {/if}
 {/if}
{elseif $message.type eq '1'} {* 送信メッセージ *}
 {if $message.attach_file} {* 添付ファイル付き *}
  {if $message.update}
   {grn_link page='message/view' caption=$message.subject image='msg20_su_clip8.gif' cid=$cid rid=$rid mid=$message.mid truncated_caption=$subject_width}
  {else}
   {grn_link page='message/view' caption=$message.subject image='msg20_s_clip8.gif' cid=$cid rid=$rid mid=$message.mid truncated_caption=$subject_width}
  {/if}
 {else}                    {* 添付ファイルなし *}
  {if $message.update}
   {grn_link page='message/view' caption=$message.subject image='msg20_su.gif' cid=$cid rid=$rid mid=$message.mid truncated_caption=$subject_width}
  {else}
   {grn_link page='message/view' caption=$message.subject image='msg20_s.gif' cid=$cid rid=$rid mid=$message.mid truncated_caption=$subject_width}
  {/if}
 {/if}
{else}                                            {* 下書き *}
 {if $message.attach_file}
  {grn_link page='message/draft_view' caption=$message.subject image='draft_clip30x20.gif' cid=$cid rid=$rid mid=$message.mid truncated_caption=$subject_width}
 {else}
  {grn_link page='message/draft_view' caption=$message.subject image='draft20.gif' cid=$cid rid=$rid mid=$message.mid truncated_caption=$subject_width}
 {/if}
{/if}
  </td>
{if $settings.sender}
  <td nowrap style="{$fontsize}">{grn_user_name uid=$message.creator_id name=$message.creator_name users_info=$users_info truncated=$name_width}</td>
{/if}
{if $settings.time}
  <td nowrap style="{$fontsize}">{grn_date_format date=$message.time}</td>
{/if}
{if $settings.remarks}
  <td nowrap style="{$fontsize}">
 {if $message.type eq '0'}          {* 受信メッセージ *}
  {if $message.need_confirm eq '1'} {* 確認が必要なメッセージ *}
   {if $message.confirmed neq '1'}  {* 未確認状態 *}
{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-38' replace='true'}
   {/if}
   {if $category.is_subscribed eq '1'}  {* フォルダ更新通知中 *}
    {if $message.is_subscribed neq '1'} {* メッセージ更新通知解除中 *}
   <div class="notify_off">{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-39' replace='true'}</div>
    {/if}
   {/if}
  {else}                                {* 確認が不必要なメッセージ *}
   {if $category.is_subscribed eq '1'}  {* フォルダ更新通知中 *}
    {if $message.is_subscribed neq '1'} {* メッセージ更新通知解除中 *}
   <div class="notify_off">{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-40' replace='true'}</div>
    {/if}
   {else}
&nbsp;
   {/if}
  {/if}
 {elseif $message.type eq '2'}      {* 下書き *}
  {if $message.attach_file}
{grn_format_filesize size=$message.attach_files_size unit="KB"}
  {else}
&nbsp;
  {/if}
 {else}                             {* 送信メッセージ *}
  {if $message.need_confirm eq '1'}     {* 確認が必要なメッセージ *}
{capture name='grn_message_portlet_GRN_MSG_PO_41'}{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-41' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_message_portlet_GRN_MSG_PO_41 page='message/read_status' cid=$cid rid=$rid mid=$message.mid}
   {if $category.is_subscribed eq '1'}  {* フォルダ更新通知中 *}
    {if $message.is_subscribed neq '1'} {* メッセージ更新通知解除中 *}
   <div class="notify_off">{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-42' replace='true'}</div>
    {/if}
   {/if}
  {else}                                {* 確認が不必要なメッセージ *}
   {if $category.is_subscribed eq '1'}  {* フォルダ更新通知中 *}
    {if $message.is_subscribed neq '1'} {* メッセージ更新通知解除中 *}
   <div class="notify_off">{cb_msg module='grn.message.portlet' key='GRN_MSG_PO-43' replace='true'}</div>
    {/if}
   {else}
&nbsp;
   {/if}
  {/if}
 {/if}
  </td>
{/if}
 </tr>
{/foreach}
</table>
{/if}
</div> <!--end of portal_frame -->

{include file="grn/head.tpl"}
{*GRN35-129*}
{include file='grn/header_no_siteposition.tpl'}
<table class="global_navi_title" cellpadding="0" cellmargin="0" style="padding:0px;"><tbody><tr><td width="100%" valign="bottom" nowrap>
{grn_image image="msg20.gif"}{$page_title}
</table>
<div class="mainarea">
{*GRN35-129*}
{capture name="navi_right"}{include file="grn/smart_data_count_310.tpl" start_num=$navi_info.start_count end_num=$navi_info.end_count all_num=$navi_info.count}{/capture}
  {include file="grn/smart_word_navi_310.tpl" navi=$navi_info.navi navi_right=$smarty.capture.navi_right}

<table class="list_column">
 <colgroup>
  <col width="40%">
  <col width="20%">
  <col width="20%">
  <col width="20%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-49' replace='true'}</th>
  <th nowrap>{capture name='grn_message_GRN_MSG_50'}{cb_msg module='grn.message' key='GRN_MSG-50' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_50 page=$page_info.all sort='creator' reverse=$sort_params.creator.reverse disable=$sort_params.creator.disable}</th>
  <th nowrap>{capture name='grn_message_GRN_MSG_51'}{cb_msg module='grn.message' key='GRN_MSG-51' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_51 page=$page_info.all sort='last_mtime' reverse=$sort_params.last_mtime.reverse disable=$sort_params.last_mtime.disable}</th>
  <th nowrap>{capture name='grn_message_GRN_MSG_52'}{cb_msg module='grn.message' key='GRN_MSG-52' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_52 page=$page_info.all sort='folder' reverse=$sort_params.folder.reverse disable=$sort_params.folder.disable}</th>
 </tr>
{foreach from=$messages item=message}
 <tr class="{cycle values='linetwo,lineone'}">
  <td nowrap>
{if $message.has_files}
 {assign var="class_clip" value="_clip8"}
{else}
 {assign var="class_clip" value=''}
{/if}
{if $message.status eq 0}               {* unread *}
 {assign var="unread" value="1"}
 {assign var="class_update" value=''}
{else}
 {assign var="unread" value="0"}
 {if $message.status eq 1}              {* update *}
  {assign var="class_update" value="_u"}
 {else}                                 {* read *}
  {assign var="class_update" value=''}
 {/if}
{/if}
   {grn_link page='message/view' caption=$message.subject|cb_mb_truncate:$subject_width image="msg20`$class_update``$class_clip`.gif" unread=$unread cid=$message.cid rid=$message.rid mid=$message.mid}
  </td>
  <td nowrap>{grn_user_name uid=$message.creator_id users_info=$users_info name=$message.creator_name|cb_mb_truncate:$name_width}</td>
  <td nowrap>{grn_date_format date=$message.time}</td>
  <td nowrap>{$message.folder_name|escape}</td>
 </tr>
{/foreach}
</table>
<div class="navi"><nobr>{include file="grn/word_navi.tpl" navi=$navi_info.navi}</nobr></div>

{include file="grn/footer.tpl"}

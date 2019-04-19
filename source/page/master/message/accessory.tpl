{include file="grn/head.tpl"}
{include file="grn/header.tpl"}

{grn_title title=$page_title class=$page_info.parts[0]}
<div class="sub_title">{cb_msg module='grn.message' key='GRN_MSG-28' replace='true'}{grn_sentence caption=$message.subject image='msg20.gif'}{cb_msg module='grn.message' key='GRN_MSG-29' replace='true'}</div>
<table class="list_column">
 <colgroup>
  <col width="20%">
  <col width="20%">
  <col width="30%">
  <col width="15%">
  <col width="15%">
 </colgroup>
 <tr>
  <th nowrap>
  {capture name='grn_message_GRN_MSG_30'}{cb_msg module='grn.message' key='GRN_MSG-30' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_30 page='message/accessory' cid=$message.cid rid=$message.rid mid=$message.mid sort='ftd' reverse=$sort_params.ftd.reverse disable=$sort_params.ftd.disable}
  </th>
  <th nowrap>
  {capture name='grn_message_GRN_MSG_31'}{cb_msg module='grn.message' key='GRN_MSG-31' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_GRN_MSG_31 page='message/accessory' cid=$message.cid rid=$message.rid mid=$message.mid sort='fnd' reverse=$sort_params.fnd.reverse disable=$sort_params.fnd.disable}
  </th>
  <th nowrap>{cb_msg module='grn' key='grn.comment.body.and.comment' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.message' key='GRN_MSG-33' replace='true'}</th>
  <th nowrap>
 {if $sort_params.accessory_time_sort eq 'ctime'}
  {capture name='grn_message_GRN_MSG_34'}{cb_msg module='grn.message' key='GRN_MSG-34' replace='true'}{/capture}{grn_title_sort_switch title=$smarty.capture.grn_message_GRN_MSG_34 page='message/accessory' button_params=$button_params sort_params=$switch_params reverse=$sort_params.time.reverse disable=$sort_params.time.disable}
 {else}
  {capture name='grn_message_GRN_MSG_35'}{cb_msg module='grn.message' key='GRN_MSG-35' replace='true'}{/capture}{grn_title_sort_switch title=$smarty.capture.grn_message_GRN_MSG_35 page='message/accessory' button_params=$button_params sort_params=$switch_params reverse=$sort_params.time.reverse disable=$sort_params.time.disable}
 {/if}

 {** grn_title_sort title='日時' page='message/accessory' cid=$message.cid rid=$message.rid mid=$message.mid sort=$sort reverse=$sort **}
 </th>
 </tr>
{foreach from=$message.all_attach_files item=item}
 <tr class="{cycle values='linetwo,lineone'}">
  <td nowrap>{grn_link page='message/file_view' image='file20.gif' cid=$message.cid rid=$message.rid mid=$message.mid rfid=$item.rfid frm=$message.frm caption=$item.title}</td>
  <td nowrap>{grn_link page='message/file_download' image='disk20.gif' cid=$message.cid rid=$message.rid mid=$message.mid rfid=$item.rfid frm=$message.frm caption=$item.filename postfix=$item.filename ticket=$download_ticket}</td>
  <td nowrap>
{if $message.from_draft neq '1'}
 {if $item.follow_id}
   {grn_link page='message/view' caption=$item.abstract|cb_mb_truncate:$truncate_width cid=$message.cid rid =$message.rid mid=$message.mid follow_id=$item.follow_id fragment='follow'}
 {else}
   {grn_link page='message/view' caption=$item.abstract|cb_mb_truncate:$truncate_width cid=$message.cid rid =$message.rid mid=$message.mid}
 {/if}
{else}
   {grn_link page='message/draft_view' caption=$item.abstract|cb_mb_truncate:$truncate_width cid=$message.cid rid =$message.rid mid=$message.mid}
{/if}
  </td>
  <td nowrap>{grn_user_name uid=$item.creator_uid users_info=$users_info name=$item.creator_name|cb_mb_truncate:$name_width}</td>
  <td nowrap>{grn_date_format date=$item.ctime format="DateTimeCompact"}</td>
 </tr>
{/foreach}
</table>

{include file="grn/footer.tpl"}

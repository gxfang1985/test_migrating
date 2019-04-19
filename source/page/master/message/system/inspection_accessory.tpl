{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
<div class="sub_title">{cb_msg module='grn.message.system' key='GRN_MSG_SY-74' replace='true'}{$message.subject|escape:"html"}{cb_msg module='grn.message.system' key='GRN_MSG_SY-75' replace='true'}</div>
<table class="list_column">
 <colgroup>
  <col width="20%">
  <col width="20%">
  <col width="30%">
  <col width="10%">
  <col width="10%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.message.system' key='GRN_MSG_SY-76' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.message.system' key='GRN_MSG_SY-77' replace='true'}</th>
  <th nowrap>{cb_msg module='grn' key='grn.comment.body.and.comment' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.message.system' key='GRN_MSG_SY-79' replace='true'}</th>
  <th nowrap>{capture name='grn_message_system_GRN_MSG_SY_80'}{cb_msg module='grn.message.system' key='GRN_MSG_SY-80' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_message_system_GRN_MSG_SY_80 page='message/system/inspection_accessory' mid=$message.mid sort=$sort reverse=$sort}</th>
 </tr>
{foreach from=$message.all_attach_files item=item}
 <tr>
  <td nowrap>{grn_link image='file20.gif' caption=$item.title page='message/system/inspection_file_view' mid=$message.mid rfid=$item.rfid frm='ac'}</td>
  <td nowrap>{grn_link image='disk20.gif' caption=$item.filename page='message/system/inspection_file_download' mid=$message.mid rfid=$item.rfid frm='ac' ticket=$download_ticket}</td>
  <td nowrap> 
  {if $item.follow_id}
    {grn_link page='message/system/inspection_view' caption=$item.abstract|cb_mb_truncate:$truncate_width mid=$message.mid follow_id=$item.follow_id fragment='follow'}
  {else}
    {grn_link page='message/system/inspection_view' caption=$item.abstract|cb_mb_truncate:$truncate_width mid=$message.mid}
  {/if}
  </td>
  <td nowrap>{grn_user_name uid=$item.creator_uid name=$item.creator_name|cb_mb_truncate:$name_width users_info=$users_info}</td>
  <td nowrap>{grn_date_format date=$item.ctime format="DateTimeCompact"}</td>
 </tr>
{/foreach}
</table>

{include file="grn/system_footer.tpl"}

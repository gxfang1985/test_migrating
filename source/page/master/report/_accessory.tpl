{grn_title title=$page_title class=$page_info.parts[0]}
<div class="sub_title">{cb_msg module='grn.report' key='GRN_RPRT-68' replace='true'}{grn_sentence caption=$report->getSubject() image='report20.gif'}{cb_msg module='grn.report' key='GRN_RPRT-69' replace='true'}</div>
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
  {capture name='grn_report_GRN_RPRT_70'}{cb_msg module='grn.report' key='GRN_RPRT-70' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_GRN_RPRT_70 page=$page_prefix|cat:'/accessory' cid=$report->getCategory() fid=$report->getForm() rid=$report->getId() sort='ftd' reverse=$sort_params.ftd.reverse disable=$sort_params.ftd.disable}
  </th>
  <th nowrap>
  {capture name='grn_report_GRN_RPRT_71'}{cb_msg module='grn.report' key='GRN_RPRT-71' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_report_GRN_RPRT_71 page=$page_prefix|cat:'/accessory' cid=$report->getCategory() fid=$report->getForm() rid=$report->getId() sort='fnd' reverse=$sort_params.fnd.reverse disable=$sort_params.fnd.disable}
  </th>
  <th nowrap>{cb_msg module='grn' key='grn.comment.body.and.comment' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.report' key='GRN_RPRT-73' replace='true'}</th>
  <th nowrap>
 {if $sort_params.accessory_time_sort eq 'ctime'}
  {capture name='grn_report_GRN_RPRT_74'}{cb_msg module='grn.report' key='GRN_RPRT-74' replace='true'}{/capture}{grn_title_sort_switch title=$smarty.capture.grn_report_GRN_RPRT_74 page=$page_prefix|cat:'/accessory' button_params=$button_params sort_params=$switch_params reverse=$sort_params.time.reverse disable=$sort_params.time.disable}
 {else}
  {capture name='grn_report_GRN_RPRT_75'}{cb_msg module='grn.report' key='GRN_RPRT-75' replace='true'}{/capture}{grn_title_sort_switch title=$smarty.capture.grn_report_GRN_RPRT_75 page=$page_prefix|cat:'/accessory' button_params=$button_params sort_params=$switch_params reverse=$sort_params.time.reverse disable=$sort_params.time.disable}
 {/if}

 </th>
 </tr>
{foreach from=$all_attach_files key=key item=item}
 <tr>
  <td nowrap>{grn_link page=$page_prefix|cat:'/file_view' image='file20.gif' rid=$report->getId() fid=$key frm=$report->getForm() caption=$item.title}</td>
  <td nowrap>{grn_link page=$page_prefix|cat:'/file_download' image='disk20.gif' rid=$report->getId() fid=$key frm=$report->getForm() caption=$item.filename postfix=$item.filename ticket=$download_ticket}</td>
  <td nowrap>
{if $report->getDraft() neq '1'}
 {if $item.follow_id}
   {grn_link page=$page_prefix|cat:'/'|cat:$view_page caption=$item.abstract|cb_mb_truncate:$config.truncate_width cid=$report->getCategory() fid=$report->getForm() rid=$report->getId() follow_id=$item.follow_id fragment='follow'}
 {else}
   {grn_link page=$page_prefix|cat:'/'|cat:$view_page caption=$item.abstract|cb_mb_truncate:$config.truncate_width cid=$report->getCategory() fid=$report->getForm() rid=$report->getId()}
 {/if}
{else}
   {grn_link page=$page_prefix|cat:'/draft_view' caption=$item.abstract|cb_mb_truncate:$config.truncate_width rid =$report->getId() rid=$report->getId()}
{/if}
  </td>
  <td nowrap>{grn_user_name uid=$item.creator_uid users_info=$users_info name=$item.creator_name|cb_mb_truncate:$config.name_width}</td>
  <td nowrap>{grn_date_format date=$item.ctime format="DateTimeCompact"}</td>
 </tr>
{/foreach}
</table>

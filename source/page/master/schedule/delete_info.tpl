{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$schedule_event.title class=$page_info.parts[0]}
 <p>
 {if $schedule_event.modify_uid or $schedule_event.modify_name}
 <table class="view_table" width="100%">
  <colgroup>
   <col width="20%">
   <col width="80%">
  </colgroup>
  <tr>
   <th>{cb_msg module='grn.schedule' key='GRN_SCH-826' replace='true'}</th>
   <td>{grn_schedule_member_name id=$schedule_event.modify_uid name=$schedule_event.modify_name}&nbsp;{grn_date_format date=$schedule_event.mtime format="DateTimeMiddle_YMDW_HM"}</td>
  </tr>
 </table>
 {/if}
 <p><div class="attention">&nbsp;{cb_msg module='grn.schedule' key='GRN_SCH-827' replace='true'}</div></p>
 </p>

{include file='grn/footer.tpl'}

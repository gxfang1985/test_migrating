{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
<form name="schedule_relation" method="post" action="{grn_pageurl page='report/system/command_report_schedule_relation'}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}" />
 <input type="hidden" name="rid" value="{$report_id}" />
 <input type="hidden" name="cid" value="{$category_id}" />
 <input type="hidden" name="fid" value="{$form_id}" />
 <input type="hidden" name="eid" value="{$event_id}" />
 <input type="hidden" name="date" value="{$event_date}" />
 <input type="hidden" name="addFlg" value="0" />
 <input type="hidden" name="from" value="modify" />
 <p>
  {cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-23' replace='true'}<br>
  {grn_sentence caption=$title image='report20.gif' class='bold'}
 </p>
 <p>
  {capture name='grn_report_system_GRN_RPRT_SY_244'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-244' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_244}
  {capture name='grn_report_system_GRN_RPRT_SY_245'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-245' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_245}
 </p>
</form>
{include file='grn/system_footer.tpl'}
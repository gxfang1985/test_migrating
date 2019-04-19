<form name="report/delete" method="post" action="{grn_pageurl page='report/command_report_schedule_relation'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="rid" value="{$rid}">
<input type="hidden" name="eid" value="{$eid}"/>
<input type="hidden" name="date" value="{$date}"/>
<input type="hidden" name="from" value="schedule" />
<input type="hidden" name="addFlg" value="0"/>
<p>
{cb_msg module='grn.report.schedule' key='GRN_RPRT_SCH-23' replace='true'}<br>
{grn_sentence caption=$report.name|cb_mb_truncate:30 image='report20.gif' class='bold'}
</div>
</p>
</form>

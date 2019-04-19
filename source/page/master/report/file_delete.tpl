<form name="report/file_delete" method="post" action="{grn_pageurl page='report/command_file_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.report' key='GRN_RPRT-9' replace='true'}<br>
 {grn_sentence caption=$file.filename|cb_mb_truncate image='file20.gif' class='bold'}<br>
 <div class="attention">{cb_msg module='grn.report' key='GRN_RPRT-10' replace='true'}</div>
 </p>
<input type="hidden" name="fid" value="{$file.id}">
<input type="hidden" name="rid" value="{$report_id}">
<input type="hidden" name="follow_id" value="{$follow_id}">
</form>

 <p>{cb_msg module='grn' key='grn.comment.delete.confirm' replace='true'}<br>
 {cb_msg module='grn.report' key='GRN_RPRT-97' replace='true'}<span class="bold">{$report.follow_data|escape:"html"}</span>{cb_msg module='grn.report' key='GRN_RPRT-98' replace='true'}
 </p>
 <p>
  {capture name='grn_report_GRN_RPRT_99'}{cb_msg module='grn.report' key='GRN_RPRT-99' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_report_GRN_RPRT_99}
  {capture name='grn_report_GRN_RPRT_100'}{cb_msg module='grn.report' key='GRN_RPRT-100' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_report_GRN_RPRT_100}
 </p>
<input type="hidden" name="cid" value="{$report.cid}">
<input type="hidden" name="fid" value="{$report.fid}">
<input type="hidden" name="rid" value="{$report.rid}">
<input type="hidden" name="follow_id" value="{$report.follow_id}">

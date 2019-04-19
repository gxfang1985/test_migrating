<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.report.system' key='GRN_RPRT_SY-504' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.report.system' key='GRN_RPRT_SY-505' replace='true'}
  </th>
  <td>
      {capture name='grn_report_system_GRN_RPRT_SY_506'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-506' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_506   checked=0}&nbsp;{capture name='grn_report_system_GRN_RPRT_SY_507'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-507' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_507 checked=1}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_report_system_GRN_RPRT_SY_508'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-508' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_report_system_GRN_RPRT_SY_508}
       {grn_button_cancel page="report/system/export_index"}
  </td>
 </tr>
</table>

<hr>
<p>
{include file='grn/csv_columns.tpl' column_explanation=$column_explanation type='export'}

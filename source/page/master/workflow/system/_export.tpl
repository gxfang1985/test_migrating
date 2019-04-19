<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.workflow.system' key='w_char_code_y' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.workflow.system' key='w_export_top_line_y' replace='true'}
  </th>
  <td>
      {capture name='grn_workflow_system_w_yes'}{cb_msg module='grn.workflow.system' key='w_yes' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_workflow_system_w_yes   checked=0}&nbsp;{capture name='grn_workflow_system_w_no'}{cb_msg module='grn.workflow.system' key='w_no' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_workflow_system_w_no checked=1}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_workflow_system_w_export_y'}{cb_msg module='grn.workflow.system' key='w_export_y' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_workflow_system_w_export_y}
       {grn_button_cancel page="workflow/system/export_index"}
  </td>
 </tr>
</table>

<hr>
<p>
{include file='grn/csv_columns.tpl' column_explanation=$column_explanation type='export'}

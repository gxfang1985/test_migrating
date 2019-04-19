<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.space.system' key='export-1' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.space.system' key='export-2' replace='true'}
  </th>
  <td>
      {capture name='tmp'}{cb_msg module='grn.space.system' key='export-3' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.tmp checked=0}&nbsp;{capture name='tmp'}{cb_msg module='grn.space.system' key='export-4' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.tmp checked=1}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='tmp'}{cb_msg module='grn.space.system' key='export-5' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.tmp}
       {grn_button_cancel page="space/system/export_index"}
  </td>
 </tr>
</table>

<hr>
<p>
{include file='grn/csv_columns.tpl' column_explanation=$column_explanation type='export'}

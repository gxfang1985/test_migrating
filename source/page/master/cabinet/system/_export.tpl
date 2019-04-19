<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-76' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-77' replace='true'}
  </th>
  <td>
      {capture name='grn_cabinet_system_GRN_CAB_SY_78'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-78' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_78   checked=0}&nbsp;{capture name='grn_cabinet_system_GRN_CAB_SY_79'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-79' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_79 checked=1}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_cabinet_system_GRN_CAB_SY_80'}{cb_msg module='grn.cabinet.system' key='GRN_CAB_SY-80' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_cabinet_system_GRN_CAB_SY_80}
       {grn_button_cancel page="cabinet/system/export_index"}
  </td>
 </tr>
</table>

<hr>
<p>
{include file='grn/csv_columns.tpl' column_explanation=$column_explanation type='export'}

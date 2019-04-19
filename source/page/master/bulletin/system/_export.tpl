<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-94' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-95' replace='true'}
  </th>
  <td>
      {capture name='grn_bulletin_system_GRN_BLLT_SYS_96'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-96' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_96   checked=0}&nbsp;{capture name='grn_bulletin_system_GRN_BLLT_SYS_97'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-97' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_97 checked=1}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_bulletin_system_GRN_BLLT_SYS_98'}{cb_msg module='grn.bulletin.system' key='GRN_BLLT_SYS-98' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_bulletin_system_GRN_BLLT_SYS_98}
       {grn_button_cancel page="bulletin/system/export_index"}
  </td>
 </tr>
</table>

<hr>
<p>
{include file='grn/csv_columns.tpl' column_explanation=$column_explanation type='export'}

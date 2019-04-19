<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.link.operation' key='GRN_LNK_OP-99' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.link.operation' key='GRN_LNK_OP-100' replace='true'}
  </th>
  <td>
      {capture name='grn_link_operation_GRN_LNK_OP_101'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-101' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_101   checked=0}&nbsp;{capture name='grn_link_operation_GRN_LNK_OP_102'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-102' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_102 checked=1}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {include file=$button_file}
  </td>
 </tr>
</table>

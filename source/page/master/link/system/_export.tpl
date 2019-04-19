<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.link.system' key='GRN_LNK_SY-181' replace='true'}
  </th>
  <td>
      {grn_charset name="charset" bom='TRUE'}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.link.system' key='GRN_LNK_SY-182' replace='true'}
  </th>
  <td>
      {capture name='grn_link_system_GRN_LNK_SY_183'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-183' replace='true'}{/capture}{grn_radio name="item_name" id="yes" value="1" caption=$smarty.capture.grn_link_system_GRN_LNK_SY_183   checked=0}&nbsp;{capture name='grn_link_system_GRN_LNK_SY_184'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-184' replace='true'}{/capture}{grn_radio name="item_name" id="no" value="0" caption=$smarty.capture.grn_link_system_GRN_LNK_SY_184 checked=1}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {include file=$button_file}
  </td>
 </tr>
</table>

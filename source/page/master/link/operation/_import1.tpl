{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_link_operation_GRN_LNK_OP_29'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-29' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_link_operation_GRN_LNK_OP_29 necessary=1}</th>
  <td>{capture name='grn_link_operation_GRN_LNK_OP_30'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-30' replace='true'}{/capture}{validate form=$form_name field='file:file' criteria='grn_notFileEmpty' message=$smarty.capture.grn_link_operation_GRN_LNK_OP_30 append='validation_errors'}{grn_file name="file" size="50" necessary=1 disable_return_key=1}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-31' replace='true'}</th>
  <td>{grn_charset name="charset" default=$charset}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-32' replace='true'}</th>
  <td>
      {if $skip}
       {capture name='grn_link_operation_GRN_LNK_OP_33'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-33' replace='true'}{/capture}{grn_radio name="skip" id="yes" value="1" caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_33   checked=1}&nbsp;{capture name='grn_link_operation_GRN_LNK_OP_34'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-34' replace='true'}{/capture}{grn_radio name="skip" id="no" value="0" caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_34 checked=0}
      {else}
       {capture name='grn_link_operation_GRN_LNK_OP_35'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-35' replace='true'}{/capture}{grn_radio name="skip" id="yes" value="1" caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_35   checked=0}&nbsp;{capture name='grn_link_operation_GRN_LNK_OP_36'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-36' replace='true'}{/capture}{grn_radio name="skip" id="no" value="0" caption=$smarty.capture.grn_link_operation_GRN_LNK_OP_36 checked=1}
      {/if}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {include file=$button_file}
  </td>
 </tr>
</table>

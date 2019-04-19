{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_link_system_GRN_LNK_SY_55'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-55' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_link_system_GRN_LNK_SY_55 necessary=1}</th>
  <td>{capture name='grn_link_system_GRN_LNK_SY_56'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-56' replace='true'}{/capture}{validate form=$form_name field='file:file' criteria='grn_notFileEmpty' message=$smarty.capture.grn_link_system_GRN_LNK_SY_56 append='validation_errors'}{grn_file name="file" size="50" necessary=1 disable_return_key=1}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.link.system' key='GRN_LNK_SY-57' replace='true'}</th>
  <td>{grn_charset name="charset" default=$charset}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.link.system' key='GRN_LNK_SY-58' replace='true'}</th>
  <td>
      {if $skip}
       {capture name='grn_link_system_GRN_LNK_SY_59'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-59' replace='true'}{/capture}{grn_radio name="skip" id="yes" value="1" caption=$smarty.capture.grn_link_system_GRN_LNK_SY_59   checked=1}&nbsp;{capture name='grn_link_system_GRN_LNK_SY_60'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-60' replace='true'}{/capture}{grn_radio name="skip" id="no" value="0" caption=$smarty.capture.grn_link_system_GRN_LNK_SY_60 checked=0}
      {else}
       {capture name='grn_link_system_GRN_LNK_SY_61'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-61' replace='true'}{/capture}{grn_radio name="skip" id="yes" value="1" caption=$smarty.capture.grn_link_system_GRN_LNK_SY_61   checked=0}&nbsp;{capture name='grn_link_system_GRN_LNK_SY_62'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-62' replace='true'}{/capture}{grn_radio name="skip" id="no" value="0" caption=$smarty.capture.grn_link_system_GRN_LNK_SY_62 checked=1}
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

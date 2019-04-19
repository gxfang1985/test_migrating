<table class="std_form">
 <tr>
  <th>{cb_msg module='grn.link' key='GRN_LNK-13' replace='true'}</th>
  <td>{grn_image image='category20.gif'}{$category.parent_category.title|escape:"html"}</td>
 </tr>
 <tr>
  <th>{capture name='grn_link_GRN_LNK_14'}{cb_msg module='grn.link' key='GRN_LNK-14' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_link_GRN_LNK_14 necessary=1}</th>
  <td>{capture name='grn_link_GRN_LNK_15'}{cb_msg module='grn.link' key='GRN_LNK-15' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty"  transform="cb_trim" message=$smarty.capture.grn_link_GRN_LNK_15 append="validation_errors"}{grn_text name="title" size="30" necessary=1 value=$category.title}</td>
 </tr>
 <tr valign="top">
  <th>{capture name='grn_link_GRN_LNK_16'}{cb_msg module='grn.link' key='GRN_LNK-16' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_link_GRN_LNK_16 necessary=1}</th>
  <td>{capture name='grn_link_GRN_LNK_17'}{cb_msg module='grn.link' key='GRN_LNK-17' replace='true'}{/capture}{validate form=$form_name field="foreign_key" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_link_GRN_LNK_17 append="validation_errors"}{grn_text name="foreign_key" size="30" value=$category.foreign_key}<br>
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.link' key='GRN_LNK-18' replace='true'}</div>
  </td>
 </tr>

 <tr valign="top">
  <th>{cb_msg module='grn.link' key='GRN_LNK-19' replace='true'}</th>
  <td>{grn_textarea name="memo" rows="9" value=$category.memo}</td>
 </tr>
 <tr>
  <td></td>
  <td>
   {include file="$button_file"}
  </td>
 </tr>
</table>
<input type="hidden" name="pcid" value="{$category.parent_category.cid}">

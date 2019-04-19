<table class="std_form">
 <tr>
  <th>{cb_msg module='grn.link' key='GRN_LNK-156' replace='true'}</th>
  <td>{grn_image image='category20.gif'}{$category.title|escape:"html"}</td>
 </tr>
 <tr>
  <th>{capture name='grn_link_GRN_LNK_157'}{cb_msg module='grn.link' key='GRN_LNK-157' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_link_GRN_LNK_157 necessary=1}</th>
  <td>{capture name='grn_link_GRN_LNK_158'}{cb_msg module='grn.link' key='GRN_LNK-158' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_link_GRN_LNK_158 append="validation_errors"}{grn_text name="title" size="50" necessary=1 value=$title}</td>
 </tr>
 <tr valign="top">
  <th>{capture name='grn_link_GRN_LNK_159'}{cb_msg module='grn.link' key='GRN_LNK-159' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_link_GRN_LNK_159 necessary=1}</th>
  <td>{capture name='grn_link_GRN_LNK_160'}{cb_msg module='grn.link' key='GRN_LNK-160' replace='true'}{/capture}{validate form=$form_name field="foreign_key" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_link_GRN_LNK_160 append="validation_errors"}{grn_text name="foreign_key" size="50" value=$foreign_key}<br>
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.link' key='GRN_LNK-161' replace='true'}</div>
  </td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.link' key='GRN_LNK-162' replace='true'}</th>
  <td>{grn_textarea name="memo" rows="10" value=$memo}</td>
 </tr>
 <tr>
  <td></td>
  <td>
   {include file="$button_file"}
  </td>
 </tr>
</table>

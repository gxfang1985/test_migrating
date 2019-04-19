<table class="std_form">
 <tr>
  <th>{cb_msg module='grn.link.system' key='GRN_LNK_SY-154' replace='true'}</th>
  <td>{grn_image image='category20.gif'}{$category.title|escape:"html"}</td>
 </tr>
 <tr>
  <th>{capture name='grn_link_system_GRN_LNK_SY_155'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-155' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_link_system_GRN_LNK_SY_155 necessary=false}</th>
  <td>
    {capture name='grn_link_system_GRN_LNK_SY_156'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-156' replace='true'}{/capture}
    {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_link_system_GRN_LNK_SY_156 values=$multiLanguageInfoArray.values}
  </td>
 </tr>
 <tr valign="top">
  <th>{capture name='grn_link_system_GRN_LNK_SY_157'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-157' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_link_system_GRN_LNK_SY_157 necessary=1}</th>
  <td>{capture name='grn_link_system_GRN_LNK_SY_158'}{cb_msg module='grn.link.system' key='GRN_LNK_SY-158' replace='true'}{/capture}{validate form=$form_name field="foreign_key" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_link_system_GRN_LNK_SY_158 append="validation_errors"}{grn_text name="foreign_key" size="50" value=$foreign_key}<br>
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.link.system' key='GRN_LNK_SY-159' replace='true'}</div>
  </td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.link.system' key='GRN_LNK_SY-160' replace='true'}</th>
  <td>{grn_textarea name="memo" rows="10" value=$memo}</td>
 </tr>
 <tr>
  <td></td>
  <td>
   {include file="$button_file"}
  </td>
 </tr>
</table>

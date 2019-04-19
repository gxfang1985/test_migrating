<table class="std_form">
 <tr>
  <th>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-78' replace='true'}</th>
  <td>{grn_image image='category20.gif'}{$category.title|escape:"html"}</td>
 </tr>
 <tr>
  <th>{capture name='grn_link_operation_GRN_LNK_OP_79'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-79' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_link_operation_GRN_LNK_OP_79 necessary=false}</th>
  <td>
    {capture name='grn_link_operation_GRN_LNK_OP_80'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-80' replace='true'}{/capture}
    {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_link_operation_GRN_LNK_OP_80 values=$multiLanguageInfoArray.values}
  </td>
 </tr>
 <tr valign="top">
  <th>{capture name='grn_link_operation_GRN_LNK_OP_81'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-81' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_link_operation_GRN_LNK_OP_81 necessary=1}</th>
  <td>{capture name='grn_link_operation_GRN_LNK_OP_82'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-82' replace='true'}{/capture}{validate form=$form_name field="foreign_key" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_link_operation_GRN_LNK_OP_82 append="validation_errors"}{grn_text name="foreign_key" size="50" value=$foreign_key}<br>
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.link.operation' key='GRN_LNK_OP-83' replace='true'}</div>
  </td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-84' replace='true'}</th>
  <td>{grn_textarea name="memo" rows="10" value=$memo}</td>
 </tr>
 <tr>
  <td></td>
  <td>
   {include file="$button_file"}
  </td>
 </tr>
</table>

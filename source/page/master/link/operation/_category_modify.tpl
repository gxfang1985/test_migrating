<table class="std_form">
 <tr>
  <th>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-46' replace='true'}</th>
  <td>{grn_image image='category20.gif'}{$category.parent_category.title|escape:"html"}</td>
 </tr>
 <tr>
  <th>{capture name='grn_link_operation_GRN_LNK_OP_47'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-47' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_link_operation_GRN_LNK_OP_47 necessary=false}</th>
  <td>
    {capture name='grn_link_operation_GRN_LNK_OP_48'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-48' replace='true'}{/capture}
    {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_link_operation_GRN_LNK_OP_48 values=$multiLanguageInfoArray.values}
  </td>
 </tr>
 <tr valign="top">
  <th>{capture name='grn_link_operation_GRN_LNK_OP_49'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-49' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_link_operation_GRN_LNK_OP_49 necessary=1}</th>
  <td>{capture name='grn_link_operation_GRN_LNK_OP_50'}{cb_msg module='grn.link.operation' key='GRN_LNK_OP-50' replace='true'}{/capture}{validate form=$form_name field="foreign_key" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_link_operation_GRN_LNK_OP_50 append="validation_errors"}{grn_text name="foreign_key" size="30" value=$category.foreign_key}<br>
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.link.operation' key='GRN_LNK_OP-51' replace='true'}</div>
  </td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.link.operation' key='GRN_LNK_OP-52' replace='true'}</th>
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

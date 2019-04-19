<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_parent_category_y'}{cb_msg module='grn.workflow.system' key='w_parent_category_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_parent_category_y}</th>
  <td>{if $is_nonparty}{grn_image image='category_trush20.gif'}{cb_msg module='grn.workflow.system' key='w_unlabeled' replace='true'}{else}{grn_image image='category20.gif'}{$pname|escape:"html"}{/if}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_title'}{cb_msg module='grn.workflow.system' key='w_title' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_title necessary=false}</th>
  <td>
   {capture name='grn_workflow_system_w_title_required'}{cb_msg module='grn.workflow.system' key='w_title_required' replace='true'}{/capture}
   {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_workflow_system_w_title_required values=$multiLanguageInfoArray.values}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_workflow_system_category_csv_code'}{cb_msg module='grn.workflow.system' key='category_csv_code' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_category_csv_code necessary=true}</th>
  <td>{capture name='grn_workflow_system_w_category_code_required'}{cb_msg module='grn.workflow.system' key='w_category_code_required' replace='true'}{/capture}{validate form=$form_name field="foreign_key" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_workflow_system_w_category_code_required append="validation_errors"}{grn_text name='foreign_key' size="50" value=$foreign_key}<br>
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.workflow.system' key='w_enter_unique_category_code_y' replace='true'}</div>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_workflow_system_w_memo'}{cb_msg module='grn.workflow.system' key='w_memo' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_memo}</th>
  <td>{grn_textarea name="memo" rows="9" value=$memo}</td>
 </tr>
 <tr>
  <td></td>
  <td>
   {include file="$button_file"}
  </td>
 </tr>
</table>
<input type="hidden" name="cid" value="{$category_id}">

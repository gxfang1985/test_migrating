<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_report_operation_GRN_RPRT_OP_410'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-410' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_operation_GRN_RPRT_OP_410}</th>
  <td>{if $is_nonparty}{grn_image image='category_trush20.gif'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-411' replace='true'}{else}{grn_image image='category20.gif'}{$pname|escape:"html"}{/if}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_operation_GRN_RPRT_OP_412'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-412' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_operation_GRN_RPRT_OP_412 necessary=false}</th>
  <td>
   {capture name='grn_report_operation_GRN_RPRT_OP_413'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-413' replace='true'}{/capture}
   {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_report_operation_GRN_RPRT_OP_413 values=$multiLanguageInfoArray.values}
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_report_operation_GRN_RPRT_OP_414'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-414' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_operation_GRN_RPRT_OP_414 necessary=true}</th>
  <td>{capture name='grn_report_operation_GRN_RPRT_OP_415'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-415' replace='true'}{/capture}{validate form=$form_name field="foreign_key" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_report_operation_GRN_RPRT_OP_415 append="validation_errors"}{grn_text name='foreign_key' size="50" value=$foreign_key}<br>
   <div class="br">&nbsp;</div>
<tr>
   <div class="sub_explanation">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-416' replace='true'}</div>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_report_operation_GRN_RPRT_OP_417'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-417' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_operation_GRN_RPRT_OP_417}</th>
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

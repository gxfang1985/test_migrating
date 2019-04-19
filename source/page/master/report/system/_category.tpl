<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_report_system_GRN_RPRT_SY_493'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-493' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_system_GRN_RPRT_SY_493}</th>
  <td>{if $is_nonparty}{grn_image image='category_trush20.gif'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-494' replace='true'}{else}{grn_image image='category20.gif'}{$pname|escape:"html"}{/if}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_system_GRN_RPRT_SY_495'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-495' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_system_GRN_RPRT_SY_495 necessary=false}</th>
  <td>
   {capture name='grn_report_system_GRN_RPRT_SY_496'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-496' replace='true'}{/capture}
   {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_report_system_GRN_RPRT_SY_496 values=$multiLanguageInfoArray.values}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_report_system_GRN_RPRT_SY_497'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-497' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_system_GRN_RPRT_SY_497 necessary=true}</th>
  <td>{capture name='grn_report_system_GRN_RPRT_SY_498'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-498' replace='true'}{/capture}{validate form=$form_name field="foreign_key" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_report_system_GRN_RPRT_SY_498 append="validation_errors"}{grn_text name='foreign_key' size="50" value=$foreign_key}<br>
   <div class="br">&nbsp;</div>
<tr>
   <div class="sub_explanation">{cb_msg module='grn.report.system' key='GRN_RPRT_SY-499' replace='true'}</div>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_report_system_GRN_RPRT_SY_500'}{cb_msg module='grn.report.system' key='GRN_RPRT_SY-500' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_system_GRN_RPRT_SY_500}</th>
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

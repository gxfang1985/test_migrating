 <tr>
  <th nowrap>{capture name='grn_report_operation_GRN_RPRT_OP_107'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-107' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_operation_GRN_RPRT_OP_107}</th>
  <td>
      {if $category_id == GRN_REPORT_CATEGORY_NONPARTY_ID}{grn_image image='category_trush20.gif'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-108' replace='true'}{else}{grn_image image='category20.gif'}{$category.name|escape}{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_operation_GRN_RPRT_OP_109'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-109' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_operation_GRN_RPRT_OP_109 necessary=true}</th>
  <td>
      {capture name='grn_report_operation_GRN_RPRT_OP_110'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-110' replace='true'}{/capture}{validate form=$form_name field="name" criteria="notEmpty" message=$smarty.capture.grn_report_operation_GRN_RPRT_OP_110 transform="cb_trim" append="validation_errors"}{grn_text name='name' size='50' disable_return_key=true value=$name_text}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_report_operation_GRN_RPRT_OP_111'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-111' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_operation_GRN_RPRT_OP_111 necessary=true}</th>
  <td>
      {capture name='grn_report_operation_GRN_RPRT_OP_112'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-112' replace='true'}{/capture}{validate form=$form_name field="foreign_key" criteria="notEmpty" message=$smarty.capture.grn_report_operation_GRN_RPRT_OP_112 transform="cb_trim" append="validation_errors"}{grn_text name='foreign_key' size='50' value=$foreign_key_text}
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-113' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <th>{capture name='grn_report_operation_GRN_RPRT_OP_114'}{cb_msg module='grn' key='grn.comment.permission.conf.item' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_operation_GRN_RPRT_OP_114}</th>
  <td>{capture name='grn_report_operation_GRN_RPRT_OP_115'}{cb_msg module='grn' key='grn.comment.permission.conf.add' replace='true'}{/capture}{grn_checkbox name='enable_follow' id='enable_follow' value=1 checked=$follow_check caption=$smarty.capture.grn_report_operation_GRN_RPRT_OP_115}</td>
 </tr>
 <tr>
  <th rowspan="2">{capture name='grn_report_operation_enable_fields'}{cb_msg module='grn.report' key='enable_fields' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_operation_enable_fields}</th>
  <td>{capture name='grn_report_operation_attendees'}{cb_msg module='grn.report' key='attendees' replace='true'}{/capture}{grn_checkbox name='enable_member' id='enable_member' value=1 checked=$member_check caption=$smarty.capture.grn_report_operation_attendees}</td>
 </tr>
 <tr>
  <td>{capture name='grn_report_outside_parties'}{cb_msg module='grn.report' key='outside_parties' replace='true'}{/capture}{grn_checkbox name='enable_partner' id='enable_partner' value=1 checked=$partner_check caption=$smarty.capture.grn_report_outside_parties}</td>
 </tr>
 <tr valign="top">
  <th nowrap>{capture name='grn_report_operation_GRN_RPRT_OP_116'}{cb_msg module='grn.report.operation' key='GRN_RPRT_OP-116' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_report_operation_GRN_RPRT_OP_116}</th>
  <td>
      {grn_textarea name="memo" rows="10" value=$memo_text}
  </td>
 </tr>

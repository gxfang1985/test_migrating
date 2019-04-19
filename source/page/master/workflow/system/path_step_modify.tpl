{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="pid" value="{$pid|escape}">
<input type="hidden" name="psid" value="{$psid|escape}">
<p class="explanation">{cb_msg module='grn.workflow.system' key='w_enter_patheway_step_information' replace='true'}{capture name='grn_workflow_system_w_description_y'}{cb_msg module='grn.workflow.system' key='w_description_y' replace='true'}{/capture}{grn_link caption="[`$smarty.capture.grn_workflow_system_w_description_y`]" page=workflow/system/path_step_explain pid=$pid psid=$psid col_type=$col_type}</p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_route_type_y'}{cb_msg module='grn.workflow.system' key='w_route_type_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_route_type_y}</th>
  <td>
{if GRN_WORKFLOW_CIRCULAR == $col_type}
<input type="hidden" name="col_type" value="1">
<input type="hidden" name="col_acceptance_type" value="0">
   {cb_msg module='grn.workflow.system' key='w_circular' replace='true'}
{else}
<input type="hidden" name="col_type" value="0">
{if GRN_WORKFLOW_OPERATOR_OR == $col_acceptance_type}
{assign var=or value=true}
{else}
{assign var=and value=true}
{/if}
   {capture name='grn_workflow_system_w_approve_all_approvers_y'}{cb_msg module='grn.workflow.system' key='w_approve_all_approvers_y' replace='true'}{/capture}{grn_radio name='col_acceptance_type' id='and' value='0' caption=$smarty.capture.grn_workflow_system_w_approve_all_approvers_y checked=$and}
   {capture name='grn_workflow_system_key_100'}{cb_msg module='grn.workflow.system' key='key_100' replace='true'}{/capture}{grn_radio name='col_acceptance_type' id='or' value='1' caption=$smarty.capture.grn_workflow_system_key_100 checked=$or}
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_pathway_step'}{cb_msg module='grn.workflow.system' key='w_pathway_step_name' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_pathway_step necessary=true}</th>
  <td>
   {capture name='grn_workflow_system_w_pathway_step_name_required'}{cb_msg module='grn.workflow.system' key='w_pathway_step_name_required' replace='true'}{/capture}{validate form=$form_name field="col_role" criteria="notEmpty" message=$smarty.capture.grn_workflow_system_w_pathway_step_name_required transform="cb_trim" append="validation_errors"}{grn_text name='col_role' size='50' disable_return_key=true value=$col_role}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_workflow_step_code'}{cb_msg module='grn.workflow' key='path_step_code' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_step_code}</th>
  <td>
   {capture name='grn_workflow_path_step_code_input_value'}{cb_msg module='grn.workflow' key='path_step_code_input_value' replace='true'}{/capture}{validate form=$form_name field="col_code" empty="true" criteria="isRegExp" message=$smarty.capture.grn_workflow_path_step_code_input_value expression="/^[\da-zA-Z_\-]+$/" transform="cb_trim" append="validation_errors"}
   {grn_text name='col_code' size='50' disable_return_key=true value=$col_code}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_allow_change_route_y'}{cb_msg module='grn.workflow.system' key='w_allow_change_route_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_allow_change_route_y}</th>
  <td>
   {capture name='grn_workflow_system_w_permit_allow'}{cb_msg module='grn.workflow.system' key='w_permit_allow' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_workflow_system_w_permit_allow name='col_change_path' id='col_change_path' value='1' checked=$col_change_path}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
   {capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_y' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_do_change_y}
   {grn_button_cancel page='workflow/system/path_step_view' pid=$pid psid=$psid}
  </td>
 </tr>
</table>
</form>
{include file='grn/system_footer.tpl'}

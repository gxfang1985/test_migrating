{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title|cat:' - Step 1/2' class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-118' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_current_app_approved_number_y'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-115' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_current_app_approved_number_y}</th>
  <td>
   {$current_approved_serial_number}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_new_application_number_y'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-123' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_new_application_number_y necessary='1'}</th>
  <td>
   {capture name='grn_workflow_system_w_new_app_approved_number_required_y'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-122' replace='true'}{/capture}{validate form=$form_name field="approved_serial_number" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_workflow_system_w_new_app_approved_number_required_y append="validation_errors"}
   {capture name='grn_workflow_system_w_new_app_approved_number_numeral_y'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-121' replace='true'}{/capture}{validate form=$form_name field="approved_serial_number" criteria="grn_workflow_isNumber" message=$smarty.capture.grn_workflow_system_w_new_app_approved_number_numeral_y append="validation_errors"}
   {capture name='grn_workflow_system_w_exceed_maximum_app_approved_number_y'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-119' replace='true'}{/capture}{validate form=$form_name field="approved_serial_number" criteria="grn_workflow_isRangeMax" max=$int_max message=$smarty.capture.grn_workflow_system_w_exceed_maximum_app_approved_number_y append="validation_errors"}
   {capture name='grn_workflow_system_w_under_minimum_app_approved_number_y'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-125' replace='true'}{/capture}{validate form=$form_name field="approved_serial_number" criteria="grn_workflow_isRangeMin" min=0 message=$smarty.capture.grn_workflow_system_w_under_minimum_app_approved_number_y append="validation_errors"}
   {capture name='grn_workflow_system_w_new_app_approved_number_int_y'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-135' replace='true'}{/capture}{validate form=$form_name field="approved_serial_number" criteria="isInt" message=$smarty.capture.grn_workflow_system_w_new_app_approved_number_int_y append="validation_errors"}
   {if !$approved_serial_number}
    {grn_text name='approved_serial_number' size='10' value=$current_approved_serial_number}
   {else}
    {grn_text name='approved_serial_number' size='10' value=$approved_serial_number}
   {/if}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_workflow_system_w_do_initialize_y'}{cb_msg module='grn.workflow.system' key='w_do_initialize_y' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_do_initialize_y}
      {grn_button_cancel}
  </td>
 </tr>
</table>

<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
</form>

{include file='grn/footer.tpl'}

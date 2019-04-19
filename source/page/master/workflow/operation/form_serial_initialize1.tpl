{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title|cat:' - Step 1/2' class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.workflow.system' key='w_enter_new_app_number_y' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_current_app_number_y'}{cb_msg module='grn.workflow.system' key='w_current_app_number_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_current_app_number_y}</th>
  <td>
    {$form.serial_number|escape}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_new_application_number_y'}{cb_msg module='grn.workflow.system' key='w_new_application_number_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_new_application_number_y necessary='1'}</th>
  <td>
   {capture name='grn_workflow_system_w_new_app_number_required_y'}{cb_msg module='grn.workflow.system' key='w_new_app_number_required_y' replace='true'}{/capture}{validate form=$form_name field="serial_number" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_workflow_system_w_new_app_number_required_y append="validation_errors"}
   {capture name='grn_workflow_system_w_new_app_number_numeral_y'}{cb_msg module='grn.workflow.system' key='w_new_app_number_numeral_y' replace='true'}{/capture}{validate form=$form_name field="serial_number" criteria="grn_workflow_isNumber" message=$smarty.capture.grn_workflow_system_w_new_app_number_numeral_y append="validation_errors"}
   {capture name='grn_workflow_system_w_exceed_maximum_app_number_y'}{cb_msg module='grn.workflow.system' key='w_exceed_maximum_app_number_y' replace='true'}{/capture}{validate form=$form_name field="serial_number" criteria="grn_workflow_isRangeMax" max=$int_max message=$smarty.capture.grn_workflow_system_w_exceed_maximum_app_number_y append="validation_errors"}
   {capture name='grn_workflow_system_w_under_minimum_app_number_y'}{cb_msg module='grn.workflow.system' key='w_under_minimum_app_number_y' replace='true'}{/capture}{validate form=$form_name field="serial_number" criteria="grn_workflow_isRangeMin" min=0 message=$smarty.capture.grn_workflow_system_w_under_minimum_app_number_y append="validation_errors"}
   {capture name='grn_workflow_system_w_new_app_number_int_y'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-136' replace='true'}{/capture}{validate form=$form_name field="serial_number" criteria="isInt" message=$smarty.capture.grn_workflow_system_w_new_app_number_int_y append="validation_errors"}
   {if !$serial_number}
    {grn_text name='serial_number' size='10' value=$form.serial_number}
   {else}
    {grn_text name='serial_number' size='10' value=$serial_number}
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

{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.workflow.system' key='w_enter_application_number_info_y' replace='true'}</div>
<p>
{include file='grn/show_validation_errors.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_set_app_no_format_y'}{cb_msg module='grn.workflow.system' key='w_set_app_no_format_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_set_app_no_format_y}</th>
  <td>
   {if $form.serial_type == 0}
    {assign var='serial_type_0' value=TRUE}
   {elseif $form.serial_type == 1}
    {assign var='serial_type_1' value=TRUE}
   {elseif $form.serial_type == 2}
    {assign var='serial_type_2' value=TRUE}
   {/if}
   {capture name='grn_workflow_system_w_use_common_app_no_in_all_form_y'}{cb_msg module='grn.workflow.system' key='w_use_common_app_no_in_all_form_y' replace='true'}{/capture}{grn_radio name='serial_type' id='serial_type_0' value='0' caption=$smarty.capture.grn_workflow_system_w_use_common_app_no_in_all_form_y checked=$serial_type_0}<br>
   {capture name='grn_workflow_system_w_app_form_code_app_number_use_y'}{cb_msg module='grn.workflow.system' key='w_app_form_code_app_number_use_y' replace='true'}{/capture}{grn_radio name='serial_type' id='serial_type_1' value='1' caption=$smarty.capture.grn_workflow_system_w_app_form_code_app_number_use_y checked=$serial_type_1}<br>
   {capture name='grn_workflow_system_w_do_not_use_app_no_y'}{cb_msg module='grn.workflow.system' key='w_do_not_use_app_no_y' replace='true'}{/capture}{grn_radio name='serial_type' id='serial_type_2' value='2' caption=$smarty.capture.grn_workflow_system_w_do_not_use_app_no_y checked=$serial_type_2}<br>
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_set_app_no_form'}{cb_msg module='grn.workflow.system' key='w_set_app_no_form' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_set_app_no_form}</th>
  <td>
   {grn_text name='serial_format' size='50' value=$form.serial_format}
  </td>
 </tr>
 <tr>
  <td><br></td>
 </tr>
 <tr>
  <tr>
   <th nowrap>{capture name='grn_workflow_system_w_set_app_approved_no_format_y'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-117' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_set_app_approved_no_format_y}</th>
   <td>
    {if $form.approved_serial_type == 1}
     {assign var='approved_serial_type_0' value=TRUE}
    {else}
     {assign var='approved_serial_type_1' value=TRUE}
    {/if}
    {capture name='grn_workflow_system_w_app_form_code_app_number_use_y'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-114' replace='true'}{/capture}{grn_radio name='approved_serial_type' id='approved_serial_type_0' value='1' caption=$smarty.capture.grn_workflow_system_w_app_form_code_app_number_use_y checked=$approved_serial_type_0}<br>
    {capture name='grn_workflow_system_w_do_not_use_app_no_y'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-116' replace='true'}{/capture}{grn_radio name='approved_serial_type' id='approved_serial_type_1' value='2' caption=$smarty.capture.grn_workflow_system_w_do_not_use_app_no_y checked=$approved_serial_type_1}<br>
   </td>
  </tr>
  <tr>
   <th nowrap>{capture name='grn_workflow_system_w_set_app_approved_no_form'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-124' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_set_app_approved_no_form}</th>
   <td>
    {grn_text name='approved_serial_format' size='50' value=$form.approved_serial_format}
   </td>
  </tr>
  <tr>
  <td></td>
  <td>
      {capture name='grn_workflow_system_w_do_set_y'}{cb_msg module='grn.workflow.lang' key='form_serial_modify_w_do_set_y' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_do_set_y}
      {grn_button_cancel}
  </td>
 </tr>
</table>

<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
</form>

{include file='grn/system_footer.tpl'}

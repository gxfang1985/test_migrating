{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="cid" value="{$cid|escape}">
<input type="hidden" name="fid" value="{$fid|escape}">
<input type="hidden" name="psid" value="{$psid|escape}">
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_do_allow_change_initial_value_by_applicant_y'}{cb_msg module='grn.workflow.system' key='w_do_allow_change_initial_value_by_applicant_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_do_allow_change_initial_value_by_applicant_y}</th>
  <td>
   {capture name='grn_workflow_system_w_allow_change_initial_value_by_applicant_y'}{cb_msg module='grn.workflow.system' key='w_allow_change_initial_value_by_applicant_y' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_workflow_system_w_allow_change_initial_value_by_applicant_y name='col_deny_change_path' id='col_deny_change_path' value='1' checked=$col_deny_change_path}<br>
 </tr>
 <tr>
  <td></td>
  <td>
   {capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_y' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_do_change_y}
   {grn_button_cancel page='workflow/system/form_default_list' poid=$poid cid=$cid fid=$fid psid=$psid}
  </td>
 </tr>
</table>
</form>
{include file='grn/system_footer.tpl'}

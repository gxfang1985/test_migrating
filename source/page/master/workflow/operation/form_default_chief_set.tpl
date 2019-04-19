{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="cid" value="{$cid|escape}">
<input type="hidden" name="fid" value="{$fid|escape}">
<input type="hidden" name="psid" value="{$psid|escape}">
<input type="hidden" name="mid" value="{$mid|escape}">

<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_target_role_y'}{cb_msg module='grn.workflow.system' key='w_target_role_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_target_role_y}</th>
  <td class="m_small">{grn_workflow_member_name type=$type id=$col_member}</td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_select_superior_y'}{cb_msg module='grn.workflow.system' key='w_select_superior_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_select_superior_y}</th>
  <td>
   {capture name='grn_workflow_system_w_select_applicants_superior_y'}{cb_msg module='grn.workflow.system' key='w_select_applicants_superior_y' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_workflow_system_w_select_applicants_superior_y name='col_chief' id='col_chief' value='1' checked=$col_chief}<br>
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.workflow.system' key='w_setting_to_select_users_superior_y' replace='true'}</div>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_y' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_do_change_y}
      {grn_button_cancel page='workflow/operation/form_default_list' poid=$poid cid=$cid fid=$fid psid=$psid}
  </td>
 </tr>
</table>

</form>
{include file='grn/footer.tpl'}

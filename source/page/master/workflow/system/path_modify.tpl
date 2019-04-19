{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{capture assign=page_title}{if GRN_WORKFLOW_PRIVATE_PATH == $col_type}{cb_msg module='grn.workflow.system' key='private_path_modify'}{else}{cb_msg module='grn.workflow.system' key='public_path_modify'}{/if}{/capture}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="pid" value="{$pid|escape}">
<p class="explanation">{cb_msg module='grn.workflow.system' key='w_enter_route_info_y' replace='true'}</p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_route_name_y'}{cb_msg module='grn.workflow.system' key='w_route_name_y' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_route_name_y necessary=true}</th>
  <td>
   {capture name='grn_workflow_system_w_route_name_required_y'}{cb_msg module='grn.workflow.system' key='w_route_name_required_y' replace='true'}{/capture}{validate form=$form_name field='col_name' criteria="notEmpty" message=$smarty.capture.grn_workflow_system_w_route_name_required_y transform="cb_trim" append="validation_errors"}{grn_text name='col_name' size='50' disable_return_key=true value=$col_name}
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_pathway_code'}{cb_msg module='grn.workflow.system' key='w_pathway_code' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_pathway_code necessary=true}</th>
  <td>
   {capture name='grn_workflow_system_w_pathway_code_required'}{cb_msg module='grn.workflow.system' key='w_pathway_code_required' replace='true'}{/capture}{validate form=$form_name field='col_foreign_key' criteria="notEmpty" message=$smarty.capture.grn_workflow_system_w_pathway_code_required transform="cb_trim" append="validation_errors"}{grn_text name='col_foreign_key' size='50' disable_return_key=true value=$col_foreign_key}<br>
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.workflow.system' key='w_enter_unique_route_code_y' replace='true'}</div>
  </td>
 </tr>
 <tr>
  <th nowrap>{capture name='grn_workflow_system_popup_path_explain'}{cb_msg module='grn.workflow.system' key='popup_path_explain' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_popup_path_explain}</th>
  <td>
   {include file="grn/richeditor.tpl" name="col_description" html=$html text=$text enable=true rows=9 cols=50 class="form_textarea_grn"}
   {capture name='grn_workflow_system_w_show_icon_display_y'}{cb_msg module='grn.workflow.system' key='w_show_icon_display_y' replace='true'}{/capture}{grn_checkbox caption=$smarty.capture.grn_workflow_system_w_show_icon_display_y name='col_icon' id='col_icon' value='1' checked=$col_icon}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
   <input class="margin" type="submit" name="modify" value="{cb_msg module='grn.workflow.system' key='w_do_change_y' replace='true'}">
   {grn_button_cancel page='workflow/system/path_view' pid=$pid}
  </td>
 </tr>
</table>
</form>
{include file='grn/system_footer.tpl'}

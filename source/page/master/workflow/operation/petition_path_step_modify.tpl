{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p class="explanation">
{cb_msg module='grn.workflow.system' key='w_select_processor_y' replace='true'}<br>
{cb_msg module='grn.workflow.system' key='w_comment_displayed_in_pathway_change_history' replace='true'}
</p>

<div class="marginHalf">
 {grn_workflow_form_icon_image icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url}{if $petition.petition_number != ''}No.{$petition.petition_number|escape}{/if}
 <font size="+1"><span class="bold">{$petition.form_name|escape}{cb_msg module='grn.workflow.system' key='w_bracket_left' replace='true'}{$petition.name|escape}{cb_msg module='grn.workflow.system' key='w_bracket_right' replace='true'}</span></font>
</div>
<div class="border-partition-common-grn"></div>
<table class="std_form">
 <tr>
  <th align="left" nowrap>{cb_msg module='grn.workflow.system' key='w_pathway_step_name' replace='true'}</th>
  <td>{$path_step.col_role|escape}</td>
 </tr>
 <tr>
  <th align="left" nowrap>{cb_msg module='grn.workflow.system' key='w_route_type_y' replace='true'}</th>
  <td>
{if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
   {cb_msg module='grn.workflow.system' key='w_circular' replace='true'}
{else}
   {cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}
{/if}
  </td>
 </tr>
 <tr>
  <th align="left" valign="top" nowrap>{cb_msg module='grn.workflow.system' key='w_processor_y' replace='true'}</th>
  <td valign="bottom" style="padding-left:0">
{foreach name=user from=$path_step.users item=user}
{if GRN_WORKFLOW_RESULT_UNPROCESSING < $user.col_result}
   <span class="voice">{grn_user_name uid=$user.col_user name=$user.col_display_name valid=$user.col_valid users_info=$users_info}</span><br>
{/if}
{/foreach}
   {grn_member_add name='member_select' app_id='workflow' form_name=$form_name selected_users=$selected_users skip=true use_order_parts=false access_plugin=$plugin}
  </td>
 </tr>
 <tr>
  <th align="left" valign="top" nowrap>{cb_msg module='grn.workflow.system' key='w_changer_y' replace='true'}</th>
  <td colspan="3">{grn_user_name uid=$login.id name=$login.name users_info=$users_info}</td>
 </tr>
 <tr valign="top">
  <th align="left" nowrap>{cb_msg module='grn.workflow.system' key='w_comment' replace='true'}</th>
  <td>
   {grn_textarea name='col_comment' rows=5 cols=60 value=$path_step.col_comment}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      {capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_y' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_do_change_y onclick="grn_onsubmit_common(this.form);"}
      {grn_button_cancel page='workflow/operation/petition_path_step_view' cid=$category_id fid=$form_id pid=$petition_id psid=$path_step_id}
  </td>
 </tr>
</table>

<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
<input type="hidden" name="pid" value="{$petition_id|escape}">
<input type="hidden" name="psid" value="{$path_step_id|escape}">
<input type="hidden" name="simple" value="{$simple|escape}">
</form>
{include file="workflow/_petition_path_step_modify_js.tpl"}
{include file="grn/footer.tpl"}
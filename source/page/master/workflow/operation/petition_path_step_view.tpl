{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<div id="main_menu_part">
 <span class="menu_item">
  {capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_with_no_cancel_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_change_y page='workflow/operation/petition_path_step_modify' image='modify20.gif' cid=$category_id fid=$form_id pid=$petition_id psid=$path_step_id disabled=$path_step.not_modify}
 </span>
</div>
<div class="marginHalf">
 {grn_workflow_form_icon_image icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url}{if $petition.petition_number != ''}No.{$petition.petition_number|escape}{/if}
 <font size="+1"><span class="bold">{$petition.form_name|escape}{cb_msg module='grn.workflow.system' key='w_bracket_left' replace='true'}{$petition.name|escape}{cb_msg module='grn.workflow.system' key='w_bracket_right' replace='true'}</span></font>
</div>
<div class="border-partition-common-grn"></div>
<table class="view_table">
 <tr>
  <th nowrap valign="top">{cb_msg module='grn.workflow.system' key='w_pathway_step_name' replace='true'}</th>
  <td>{$path_step.col_role|escape}</td>
 </tr>
 <tr>
  <th nowrap valign="top">{cb_msg module='grn.workflow.system' key='w_route_type_y' replace='true'}</th>
  <td>
{if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
   {cb_msg module='grn.workflow.system' key='w_circular' replace='true'}
{else}
   {cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap valign="top">{cb_msg module='grn.workflow.system' key='w_allow_change_route_y' replace='true'}</th>
  <td>
{if $path_step.col_change_path}
   {grn_image image='check20.gif'}
{else}
   &nbsp;
{/if}</td>
 </tr>
 <tr>
  <th nowrap valign="top">{cb_msg module='grn.workflow.system' key='w_processor_y' replace='true'}</th>
  <td>
{if $path_step.col_skip || 0 >= $path_step.user_count}
   {cb_msg module='grn.workflow' key='skip'}
{else}
{foreach name=user from=$path_step.users item=user}
   <span class="voice">{grn_user_name uid=$user._id name=$user.col_display_name valid=$user.col_valid users_info=$users_info}</span><br>
{/foreach}
{/if}
  </td>
 </tr>
</table>

{include file="grn/footer.tpl"}
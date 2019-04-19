{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{assign var='form_name' value=$smarty.template|basename}
{grn_title title=$page_title class=$page_info.parts[0]}

{if GRN_WORKFLOW_PRIVATE_PATH == $path.col_type}
<div id="main_menu_part">
 <span class="menu_item">
  {capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_with_no_cancel_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_change_y page='workflow/operation/form_path_step_modify' image='modify20.gif' cid=$cid fid=$fid psid=$psid disabled=$is_not_manage}
 </span>
 <span class="menu_item">
  {capture name='grn_workflow_system_w_do_set_initial_value_y'}{cb_msg module='grn.workflow.system' key='w_do_set_initial_value_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_set_initial_value_y page='workflow/operation/form_default_list' image='modify20.gif' cid=$cid fid=$fid psid=$psid disabled=$is_not_manage}
 </span>
 <span class="menu_item">
  {capture name='grn_workflow_system_w_do_delete'}{cb_msg module='grn.workflow.system' key='w_do_delete' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_delete page='workflow/operation/form_path_step_delete' image='delete20.gif' cid=$cid fid=$fid psid=$psid disabled=$is_not_manage}
 </span>
</div>
<p></p>
{/if}

<table class="view_table">
 <tr>
  <th nowrap valign="top">{cb_msg module='grn.workflow.system' key='w_pathway_step_name' replace='true'}</th>
  <td>{$path_step.col_role|escape}</td>
 </tr>
<tr>
    <th nowrap valign="top">{cb_msg module='grn.workflow.system' key='w_pathway_step_code' replace='true'}</th>
    <td>{$path_step.col_code}</td>
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
{if 1 == $path_step.col_change_path}
   {grn_image image='check20.gif'}
{else}
   &nbsp;
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap valign="top">{cb_msg module='grn.workflow.system' key='w_initial_value_y' replace='true'}</th>
  <td>
{if 0 == $member_total}
{cb_msg module='grn.workflow.system' key='w_default_set' replace='true'}
{else}
{foreach name=members from=$members item=member}
<span class="voice">{grn_workflow_member_name infos=$member}</span><br>
{/foreach}
{/if}
  </td>
 </tr>
 <tr>
  <th nowrap valign="top">{cb_msg module='grn.workflow.system' key='w_do_allow_change_initial_value_by_applicant_y' replace='true'}</th>
  <td>
{if $path_step.col_deny_change_path}
   &nbsp;
{else}
   {grn_image image='check20.gif'}
{/if}
  </td>
 </tr>
</table>
{include file='grn/footer.tpl'}

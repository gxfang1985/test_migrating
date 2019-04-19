{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape|escape}">
<input type="hidden" name="sid" value="{$skip_id|escape}">
<input type="hidden" name="pcid" value="{$condition_id|escape}">


<div id="main_menu_part">
<span class="menu_item">{capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_with_no_cancel_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_change_y page='workflow/operation/path_condition_modify' cid=$category_id fid=$form_id sid=$skip_id pcid=$condition_id image='write20.gif' disabled=$is_not_manage}</span>
<span class="menu_item">{capture name='grn_workflow_system_w_do_delete'}{cb_msg module='grn.workflow.system' key='w_do_delete' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_delete page='workflow/operation/path_condition_delete' cid=$category_id fid=$form_id sid=$skip_id pcid=$condition_id image='delete20.gif' disabled=$is_not_manage}</span>
</div>
<table class="view_table">
{foreach from=$condition_list key=id item=condition}

 <tr valign="top">
  <th>{cb_msg module='grn.workflow.system' key='w_split_condition_name_y' replace='true'}</th>
  <td>{$condition.col_name|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.workflow.system' key='w_split_condition_y' replace='true'}</th>
  <td>{$condition.col_display_name|escape}{cb_msg module='grn.workflow.system' key='w_A_matching_B' replace='true'}{$condition.operator|escape}{cb_msg module='grn.workflow.system' key='w_A_matching_B' replace='true'}{$condition.condition|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.workflow.system' key='w_route_after_apply_condition_y' replace='true'}</th>
  <td>
  {foreach name=path_step_list from=$condition_path_step_list[$condition._id] item=path_step}{$path_step.col_role|escape}{if $smarty.foreach.path_step_list.last == false}{cb_msg module='grn.workflow.system' key='w_inequality_right' replace='true'}{/if}{/foreach}
  </td>
 </tr>
  </td>
 </tr>
{/foreach}
</table>


</form>
{include file='grn/footer.tpl'}

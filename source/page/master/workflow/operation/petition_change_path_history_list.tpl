{include file="grn/head.tpl"}
{include file="grn/header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<p>
<div class="marginHalf">
 {grn_workflow_form_icon_image icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url}{if $petition.petition_number != ''}No.{$petition.petition_number|escape}{/if} <font size="+1"><span class="bold">{$petition.form_name|escape}{cb_msg module='grn.workflow.system' key='w_bracket_left' replace='true'}{$petition.name|escape}{cb_msg module='grn.workflow.system' key='w_bracket_right' replace='true'}</span></font>
</div>
</p>

<div class="border-partition-common-grn"></div>

<div class="wf_route_change_history">
<table class="list_column">
 <colgroup>
  <col width="10%">
  <col width="15%">
  <col width="10%">
  <col width="10%">
  <col width="10%">
  <col width="35%">
  <col width="10%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_changer_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_pathway_step' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_route_type_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_add_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow' key='delete_3' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_comment' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_date_and_time_y' replace='true'}</th>
 </tr>
{foreach from=$change_path_histories item=change_path_history}
{assign var=path_step_id value=$change_path_history.col_path_step_data}
<tr>
 <td nowrap>{assign var=uid value=$change_path_history.col_creator}{grn_user_name uid=$uid name=$change_path_history.col_creator_name valid=$creators.$uid.col_valid users_info=$users_info}</td>
 <td nowrap>{$path_steps.$path_step_id.col_role|escape}</td>
 <td nowrap>
{if GRN_WORKFLOW_CIRCULAR == $path_steps.$path_step_id.col_type}
  {cb_msg module='grn.workflow.system' key='w_circular' replace='true'}
{else}
  {cb_msg module='grn.workflow' key="col_acceptance_type_`$path_steps.$path_step_id.col_acceptance_type`"}
{/if}
 </td>
 <td nowrap valign="top">
{foreach from=$change_path_history.add_users item=user}
  {grn_user_name uid=$user.col_user name=$user.col_old_display_name valid=$user.col_valid users_info=$users_info}<br>
{/foreach}
 </td>
 <td nowrap valign="top" style="background-color:#E8E8E8;">
{foreach from=$change_path_history.deleted_users item=user}
  {grn_user_name uid=$user.col_user name=$user.col_old_display_name valid=$user.col_valid users_info=$users_info}<br>
{/foreach}
 </td>
 <td>{grn_format body=$change_path_history.col_comment}</td>
 <td nowrap>{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$change_path_history.col_ctime}</td>
</tr>
{/foreach}
</table>
</div>

{include file="grn/footer.tpl"}

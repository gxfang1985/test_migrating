{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{assign var='form_name' value=$smarty.template|basename}
{grn_title title=$page_title class=$page_info.parts[0]}

<p>
<div class="marginHalf">
 {grn_workflow_form_icon_image icon_type=$petition.col_icon_type icon_id=$petition.col_icon_id icon_url=$petition.col_icon_url}{if $petition.col_petition_number != ''}No.{$petition.col_petition_number|escape}{/if} <font size="+1"><span class="bold">{$petition.col_form_name|escape}{cb_msg module='grn.workflow' key='opened_parenthesis' replace='true'}{$petition.col_name|escape}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</span></font>
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
  <th nowrap>{cb_msg module='grn.workflow' key='user_made_change' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow' key='path_step' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow' key='path_class' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow' key='add' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow' key='delete_3' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow' key='comment' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow' key='date_time' replace='true'}</th>
 </tr>
{foreach from=$change_path_histories item=change_path_history}
{assign var=path_step_id value=$change_path_history.col_path_step_data}
<tr>
 <td nowrap>{assign var=uid value=$change_path_history.col_creator}{grn_user_name uid=$uid name=$change_path_history.col_creator_name valid=$creators.$uid.col_valid users_info=$creators}</td>
 <td nowrap>{$path_steps.$path_step_id.col_role|escape}</td>
 <td nowrap>
{if GRN_WORKFLOW_CIRCULAR == $path_steps.$path_step_id.col_type}
  {cb_msg module='grn.workflow' key='pass_along' replace='true'}
{else}
  {cb_msg module='grn.workflow' key="col_acceptance_type_`$path_steps.$path_step_id.col_acceptance_type`"}
{/if}
 </td>
 <td nowrap valign="top">
{foreach from=$change_path_history.add_users item=user}
  {grn_user_name uid=$user.col_user name=$user.col_old_display_name valid=$user.col_valid users_info=$creators}<br>
{/foreach}
 </td>
 <td nowrap valign="top" style="background-color:#E8E8E8;">
{foreach from=$change_path_history.deleted_users item=user}
  {grn_user_name uid=$user.col_user name=$user.col_old_display_name valid=$user.col_valid users_info=$creators}<br>
{/foreach}
 </td>
 <td>{grn_format body=$change_path_history.col_comment}</td>
 <td nowrap>{grn_date_format format='DateTimeMiddle_YMDW_HM' date=$change_path_history.col_ctime}</td>
</tr>
{/foreach}
</table>
</div>

{include file='grn/footer.tpl'}

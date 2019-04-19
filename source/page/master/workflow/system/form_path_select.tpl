{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cid" value="{$cid|escape}">
<input type="hidden" name="fid" value="{$fid|escape}">
<p class="explanation">{cb_msg module='grn.workflow.system' key='w_select_pathway_from_shared_pathway' replace='true'}</p>
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_workflow_system_w_pathway'}{cb_msg module='grn.workflow.system' key='w_pathway' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_system_w_pathway}</th>
  <td>
   {grn_select name='pid' options=$path_option onchange="form.action='$page_path';form.submit();"}
  </td>
 </tr>
</table>
<hr>
<!-- 経路情報  -->
<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_memo_for_sysytem_administrator' replace='true'}</div>
<table class="view_table" width="80%">
<col width="20%">
<col width="80%">
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.workflow.system' key='w_memo_for_sysytem_administrator' replace='true'}</th>
  <td>{grn_format body=$path.col_admin_memo}</td>
 </tr>
</table>
<p></p>
<!-- 経路情報  -->
<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_route_info_y' replace='true'}</div>
<table class="view_table" width="80%">
<col width="20%">
<col width="80%">
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.workflow.system' key='w_route_name_y' replace='true'}</th>
  <td>{$path.col_name|escape}</td>
 </tr>
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.workflow.system' key='w_pathway_code' replace='true'}</th>
  <td>{$path.col_foreign_key|escape}</td>
 </tr>
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.workflow.system' key='w_do_share_route_y' replace='true'}</th>
  <td>{if GRN_WORKFLOW_PUBLIC_PATH == $path.col_type}{cb_msg module='grn.workflow.system' key='w_yes' replace='true'}{else}{cb_msg module='grn.workflow.system' key='w_no' replace='true'}{/if}</td>
 </tr>
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.workflow.system' key='w_description_y' replace='true'}</th>
   {if $path.col_description && $path.col_richeditor}
      <td>{$path.col_description|grn_noescape}</td>
   {else}
      <td>{grn_format body=$path.col_description}</td>
   {/if}
 </tr>
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.workflow.system' key='w_show_icon_display_y' replace='true'}</th>
  <td>{if 1 == $path.col_icon}{grn_image image='check20.gif'}{/if}</td>
 </tr>
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.workflow.system' key='w_creation_information_y' replace='true'}</th>
  <td>
   {grn_user_name uid=$path.col_creator name=$path.col_creator_name}
   {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$path.col_ctime}
  </td>
 </tr>
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.workflow.system' key='w_modified_info_y' replace='true'}</th>
  <td>
   {grn_user_name uid=$path.col_modifier name=$path.col_modifier_name}
   {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$path.col_mtime}
  </td>
 </tr>
</table>
<p></p>
<!-- 申請経路の経路ステップ一覧  -->
<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_app_route_step_list_y' replace='true'}</div>
<table class="list_column" width="80%" border="1" cellspacing="0" cellpadding="2">
 <colgroup>
  <col width="1%">
  <col width="20%">
  <col width="20%">
  <col width="15%">
  <col width="30%">
  <col width="15%">
 </colgroup>
 <tr>
  <th></th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_pathway_step' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_route_type_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_allow_change_route_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_initial_value_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_do_allow_change_initial_value_by_applicant_y' replace='true'}</th>
 </tr>
{assign var=not_first value=true}
{foreach name=path_steps from=$path_steps item=path_step}
 <tr>
{if $not_first}
{assign var=not_first value=false}
  <td class="wf_route_arrow_area_grn" rowspan="{$path_step_count}" align="center"><span class="wf_route_arrow_grn">{cb_msg module='grn.workflow.system' key='w_arrow_downward' replace='true'}</span></td>
{/if}
  <td nowrap>{$path_step.col_role|escape}</td>
  <td nowrap>
{if $path_step.col_type}
   {cb_msg module='grn.workflow.system' key='w_circular' replace='true'}
{else}
   {cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}
{/if}
  </td>
  <td nowrap>
{if $path_step.col_change_path}
   {grn_image image='check20.gif'}
{else}
    &nbsp;
{/if}
  </td>
  <td nowrap>
{assign var='path_step_id' value=$path_step._id}
{if 0 == $member_total.$path_step_id}
   {cb_msg module='grn.workflow.system' key='w_default_set' replace='true'}
{else}
{foreach name=members from=$members.$path_step_id item=member}
   <span class="voice">{grn_workflow_member_name infos=$member}</span><br>
{/foreach}
{if 10 < $member_total.$path_step_id}
   {cb_msg module='grn.workflow.system' key='petition_csv_dash' replace='true'}<small>{cb_msg module='grn.workflow.system' key='w_member_total_count_1' replace='true'}{$member_total.$path_step_id}{cb_msg module='grn.workflow.system' key='w_member_total_count_2' replace='true'}</small>
{/if}
{/if}
  </td>
  <td nowrap>
{if $path_step.col_deny_change_path}
    &nbsp;
{else}
   {grn_image image='check20.gif'}
{/if}
  </td>
</tr>
{/foreach}
</table>
</div>
<table class="std_form">
 <tr>
  <td></td>
  <td>
   {capture name='grn_workflow_system_w_do_apply_y'}{cb_msg module='grn.workflow.system' key='w_do_apply_y' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_do_apply_y}
   {grn_button_cancel page='workflow/system/form_view' cid=$cid fid=$fid}
  </td>
 </tr>
</table>
</form>
{include file='grn/system_footer.tpl'}

{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{assign var='form_name' value=$smarty.template|basename}
{grn_title title=$page_title class=$page_info.parts[0]}

<!-- 管理者用メモ  -->
<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_memo_for_sysytem_administrator' replace='true'}</div>
<div id="main_menu_part">
 <span class="menu_item">{capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_with_no_cancel_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_change_y page=workflow/system/path_admin_memo_modify pid=$pid image='modify20.gif'}</span>
</div>
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
<div id="main_menu_part">
{if 0 >= $path.form_count}
{assign var='no_form' value=true}
{/if}
{if 1 >= $acceptance_path_step_count}
{assign var='no_acceptance_path_step' value=true}
{/if}
{if 1 >= $circular_path_step_count}
{assign var='no_circular_path_step' value=true}
{/if}
{if 0 >= $path_step_count}
{assign var='no_path_step' value=true}
{/if}
{if GRN_WORKFLOW_PUBLIC_PATH == $path.col_type}
 <span class="menu_item">{capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_with_no_cancel_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_change_y page=workflow/system/path_modify pid=$pid image='modify20.gif'}</span>
 <span class="menu_item">{capture name='grn_workflow_system_w_do_delete'}{cb_msg module='grn.workflow.system' key='w_do_delete' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_delete page=workflow/system/path_delete pid=$pid image='delete20.gif'}</span>
 <span class="menu_item">{capture name='grn_workflow_system_w_ref_used_app_form_y'}{cb_msg module='grn.workflow.system' key='w_ref_used_app_form_y' replace='true'}{/capture}{grn_workflow_link caption=$smarty.capture.grn_workflow_system_w_ref_used_app_form_y page=workflow/system/path_form_list icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url pid=$pid disabled=$no_form}</span>
{else}
 <span class="menu_item">{capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_with_no_cancel_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_change_y page=workflow/system/path_modify pid=$pid image='modify20.gif'}</span>
 <span class="menu_item">{capture name='grn_workflow_system_w_set_to_shared_pathway'}{cb_msg module='grn.workflow.system' key='w_set_to_shared_pathway' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_set_to_shared_pathway page=workflow/system/path_publish pid=$pid image='open20.gif'}</span>
 <span class="menu_item">{capture name='grn_workflow_system_w_ref_used_app_form_y'}{cb_msg module='grn.workflow.system' key='w_ref_used_app_form_y' replace='true'}{/capture}{grn_workflow_link caption=$smarty.capture.grn_workflow_system_w_ref_used_app_form_y page=workflow/system/path_form_list icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url pid=$pid disabled=$no_form}</span>
{/if}
</div>
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
  <td>
{if GRN_WORKFLOW_PUBLIC_PATH == $path.col_type}
   {cb_msg module='grn.workflow.system' key='w_yes' replace='true'}
{else}
   {cb_msg module='grn.workflow.system' key='w_no' replace='true'}
{/if}
  </td>
 </tr>
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.workflow.system' key='popup_path_explain' replace='true'}</th>
  {if $path.col_description && $path.col_richeditor}
  <td>{$path.col_description|grn_noescape}</td>
  {else}
  <td>{grn_format body=$path.col_description}</td>
  {/if}
 </tr>
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.workflow.system' key='w_show_icon_display_y' replace='true'}</th>
  <td>
{if $path.col_icon}
   {grn_image image='check20.gif'}
{else}
   &nbsp;
{/if}
  </td>
 </tr>
{if GRN_WORKFLOW_PUBLIC_PATH == $path.col_type}
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.workflow.system' key='w_number_of_app_form_used_y' replace='true'}</th>
  <td>{$path.form_count}</td>
 </tr>
 <tr>
{/if}
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

<!-- 申請経路  -->
{if GRN_WORKFLOW_PUBLIC_PATH == $path.col_type}
<form name="{$form_name}/acceptance_path" method="post" action="{grn_pageurl page='workflow/system/path_step_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="pid" value="{$pid|escape}">
<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_approve_route_y' replace='true'}</div>
<div id="main_menu_part">
 <span class="menu_item">{capture name='grn_workflow_system_w_do_add_y'}{cb_msg module='grn.workflow.system' key='w_do_add_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_add_y page=workflow/system/path_step_add pid=$pid image='write20.gif'}</span>
 <span class="menu_item">{capture name='grn_workflow_system_w_do_change_order_y'}{cb_msg module='grn.workflow.system' key='w_do_change_order_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_change_order_y page=workflow/system/path_step_order pid=$pid image='order20.gif' disabled=$no_acceptance_path_step}</span>
</div>
<table class="list_column" width="80%" border="1" cellspacing="0" cellpadding="2">
 <colgroup>
     <col width="1%">
     <col width="1%">
     <col width="15%">
     <col width="15%">
     <col width="15%">
     <col width="20%">
     <col width="15%">
     <col width="18%">
 </colgroup>
 <tr>
  <th></th>
  <th>{include file='workflow/checkall.tpl' func_name="CheckAllAcceptancePathSteps" form_name="`$form_name`/acceptance_path" elem_name='psids[]'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_pathway_step' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_route_type_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_allow_change_route_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_initial_value_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_do_allow_change_initial_value_by_applicant_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_pathway_step_code' replace='true'}</th>
 </tr>
{assign var=not_first value=true}
{foreach name=acceptance_path_steps from=$acceptance_path_steps item=path_step}
 <tr>
{if $not_first}
{assign var=not_first value=false}
  <td class="wf_route_arrow_area_grn" rowspan="{$acceptance_path_step_count}" align="center"><span class="wf_route_arrow_grn">{cb_msg module='grn.workflow.system' key='w_arrow_downward' replace='true'}</span></td>
{/if}
  <td>{grn_checkbox name='psids[]' id="psids_`$path_step._id`" value=$path_step._id}</td>
  <td nowrap>{grn_link caption=$path_step.col_role page='workflow/system/path_step_view' pid=$pid psid=$path_step._id}</td>
  <td nowrap>{cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}</td>
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
{/if}
  </td>
  <td nowrap>
{if $path_step.col_deny_change_path}
    &nbsp;
{else}
   {grn_image image='check20.gif'}
{/if}
  </td>
     <td>{$path_step.col_code}</td>
</tr>
{/foreach}
</table>
<div class="marginHalf">
{cb_msg module='grn.workflow.system' key='w_delete_checked_item_1' replace='true'}{capture name='grn_workflow_system_w_delete_checked_item_2'}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_2' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_system_w_delete_checked_item_2 onclick="if(!grn_is_checked(this.form,'psids[]')) return false;"}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_3' replace='true'}
</div>
</form>
<p></p>
<form name="{$form_name}/circular_path" method="post" action="{grn_pageurl page='workflow/system/path_step_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="pid" value="{$pid|escape}">
<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_circular_pathway' replace='true'}</div>
<div id="main_menu_part">
 <span class="menu_item">{capture name='grn_workflow_system_w_do_add_y'}{cb_msg module='grn.workflow.system' key='w_do_add_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_add_y page=workflow/system/path_step_add pid=$pid col_type=1 image='write20.gif'}</span>
 <span class="menu_item">{capture name='grn_workflow_system_w_do_change_order_y'}{cb_msg module='grn.workflow.system' key='w_do_change_order_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_change_order_y page=workflow/system/path_step_order pid=$pid col_type=1 image='order20.gif' disabled=$no_circular_path_step}</span>
</div>
<table class="list_column" width="80%" border="1" cellspacing="0" cellpadding="2">
 <colgroup>
     <col width="1%">
     <col width="1%">
     <col width="15%">
     <col width="15%">
     <col width="15%">
     <col width="20%">
     <col width="15%">
     <col width="18%">
 </colgroup>
 <tr>
  <th></th>
  <th>{include file='workflow/checkall.tpl' func_name="CheckAllCircularPathSteps" form_name="`$form_name`/circular_path" elem_name='psids[]'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_pathway_step' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_route_type_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_allow_change_route_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_initial_value_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_do_allow_change_initial_value_by_applicant_y' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.workflow.system' key='w_pathway_step_code' replace='true'}</th>
 </tr>
{assign var=not_first value=true}
{foreach name=circular_path_steps from=$circular_path_steps item=path_step}
 <tr>
{if $not_first}
{assign var=not_first value=false}
  <td class="wf_route_arrow_area_grn" rowspan="{$circular_path_step_count}" align="center"><span class="wf_route_arrow_grn">{cb_msg module='grn.workflow.system' key='w_arrow_downward' replace='true'}</span></td>
{/if}
  <td>{grn_checkbox name='psids[]' id="psids_`$path_step._id`" value=$path_step._id}</td>
  <td nowrap>
   {grn_link caption=$path_step.col_role page='workflow/system/path_step_view' pid=$pid psid=$path_step._id}
  </td>
  <td nowrap>{cb_msg module='grn.workflow.system' key='w_circular' replace='true'}</td>
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
{/if}
  </td>
  <td nowrap>
{if $path_step.col_deny_change_path}
    &nbsp;
{else}
   {grn_image image='check20.gif'}
{/if}
  </td>
     <td>{$path_step.col_code}</td>
</tr>
{/foreach}
</table>
<div class="marginHalf">
{cb_msg module='grn.workflow.system' key='w_delete_checked_item_1' replace='true'}{capture name='grn_workflow_system_w_delete_checked_item_2'}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_2' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_system_w_delete_checked_item_2 onclick="if(!grn_is_checked(this.form,'psids[]')) return false;"}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_3' replace='true'}
</div>
</form>
{else}
<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_app_route_y' replace='true'}</div>
<table class="list_column" width="80%" border="1" cellspacing="0" cellpadding="2">
 <colgroup>
     <col width="1%">
     <col width="15%">
     <col width="15%">
     <col width="15%">
     <col width="20%">
     <col width="15%">
     <col width="19%">
 </colgroup>
 <tr>
  <th></th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_pathway_step' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_route_type_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_allow_change_route_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_initial_value_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_do_allow_change_initial_value_by_applicant_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_pathway_step_code' replace='true'}</th>
 </tr>
{assign var=not_first value=true}
{foreach name=path_steps from=$path_steps item=path_step}
 <tr>
{if $not_first}
{assign var=not_first value=false}
  <td class="wf_route_arrow_area_grn" rowspan="{$path_step_count}" align="center"><span class="wf_route_arrow_grn">{cb_msg module='grn.workflow.system' key='w_arrow_downward' replace='true'}</span></td>
{/if}
  <td nowrap>
   {grn_link caption=$path_step.col_role page='workflow/system/path_step_view' pid=$pid psid=$path_step._id}
  </td>
  <td nowrap>
{if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
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
{/if}
  </td>
  <td nowrap>
{if $path_step.col_deny_change_path}
    &nbsp;
{else}
   {grn_image image='check20.gif'}
{/if}
  </td>
     <td>{$path_step.col_code}</td>
</tr>
{/foreach}
</table>
</div>
{/if}

{include file='grn/system_footer.tpl'}

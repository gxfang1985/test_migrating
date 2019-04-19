{* header *}
{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{assign var='sub_dir' value='system'}
{assign var='form_name' value=$smarty.template|basename}

<!--page_title-->
{if $page_title}
 {grn_title title=$page_title class=$page_info.parts[0]}
{/if}

<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_memo_for_sysytem_administrator' replace='true'}</div>
<div id="main_menu_part">
 <span class="menu_item">{capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_with_no_cancel_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_change_y page=workflow/operation/form_memo_modify cid=$category_id fid=$form_id image='modify20.gif' disabled=$is_not_manage}</span>
</div>
{include file='workflow/_form_view_view_table.tpl' link_identifier='operation'}
<form name="{$form_name}/form_layout_list" method="post" action="{grn_pageurl page='workflow/operation/command_form_view'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>
<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_app_form_item_list_y' replace='true'}</div>
<div id="main_menu_part">
 <span class="menu_item">{capture name='grn_workflow_system_w_do_add_item_y'}{cb_msg module='grn.workflow.system' key='w_do_add_item_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_add_item_y page=workflow/operation/formlayout_add cid=$category_id fid=$form_id image='write20.gif' disabled=$is_not_manage}</span>
 <span class="menu_item">{capture name='grn_workflow_system_w_add_blank_lines'}{cb_msg module='grn.workflow.system' key='w_add_blank_lines' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_add_blank_lines page=workflow/operation/formlayout_blank_add cid=$category_id fid=$form_id image='write20.gif' disabled=$is_not_manage}</span>
 {if $allow_customization}
 <span class="menu_item">{capture name='grn_workflow_system_w_set_blank_space_lines'}{cb_msg module='grn.workflow.system' key='w_set_blank_space_lines' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_set_blank_space_lines page=workflow/operation/formlayout_blank_space_add cid=$category_id fid=$form_id image='write20.gif' element_id="workflow/operation/formlayout_blank_space_add" disabled=$is_not_manage}</span>
 {/if}
 <span class="menu_item">{if $item_count <= 2 || ! $is_manage}{assign var='order_disabled' value='true'}{/if}{capture name='grn_workflow_system_w_do_change_order_y'}{cb_msg module='grn.workflow.system' key='w_do_change_order_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_change_order_y page=workflow/operation/formlayout_order cid=$category_id fid=$form_id image='order20.gif' disabled=$order_disabled}</span>
 <span class="menu_item">{capture name='grn_workflow_system_form_preview_link'}{cb_msg module='grn.workflow.system' key='form_preview_link' replace='true'}{/capture}{grn_workflow_link caption=$smarty.capture.grn_workflow_system_form_preview_link page='workflow/operation/form_preview_select' icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url cid=$category_id fid=$form_id disabled=$is_not_manage}</span>
 {if $acceptance_path_step_total > 0 && $access_setting == true}
  <span class="menu_item">{capture name='grn_workflow_system_w_set_access_priv_item_y'}{cb_msg module='grn.workflow.system' key='w_set_access_priv_item_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_set_access_priv_item_y page='workflow/operation/item_access_list' cid=$category_id fid=$form_id image='auth_wf_form20.gif'}</span>
 {else}
  <span class="menu_item">{capture name='grn_workflow_system_w_set_access_priv_item_y'}{cb_msg module='grn.workflow.system' key='w_set_access_priv_item_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_set_access_priv_item_y page='workflow/operation/item_access_list' cid=$category_id fid=$form_id image='auth_wf_form20.gif' disabled=true}</span>
 {/if}
 {if $isActiveSchedule === true}
    <span class="menu_item">{capture name='grn_workflow_system_w_set_auto_schedule_register_y'}{cb_msg module='grn.workflow.system' key='w_set_auto_schedule_register_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_set_auto_schedule_register_y page='workflow/operation/auto_schedule_register' cid=$category_id fid=$form_id image='schedule20.gif' disabled=$is_disable_schedule_register}</span>
 {/if}
 <div id="rare_menu_part_under">
  <span class="menu_item">{if $item_count <= 1 || ! $is_manage}{assign var='delete_disabled' value='true'}{/if}{capture name='grn_workflow_system_w_delete_all_items_in_app_form_y'}{cb_msg module='grn.workflow.system' key='w_delete_all_items_in_app_form_y' replace='true'}{/capture}{grn_link image='delete20.gif' page='workflow/operation/formlayout_delete_all' cid=$category_id fid=$form_id caption=$smarty.capture.grn_workflow_system_w_delete_all_items_in_app_form_y disabled=$delete_disabled}</span>
 </div>
</div>
<div style="width:80%">
 <div class="wf_path_table">
   <table class="list_column">
     {include file="workflow/_form_view_item_list.tpl" enable=$is_manage link_identifier='operation'}
 </table>
 </div>
</div>
{cb_msg module='grn.workflow.system' key='w_delete_checked_item_1' replace='true'}{capture name='grn_workflow_system_w_delete_checked_item_2'}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_2' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_system_w_delete_checked_item_2 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;cmd.value='delete';" disabled=$is_not_manage}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_3' replace='true'}&nbsp;&nbsp;
{cb_msg module='grn.workflow.system' key='key_109_1' replace='true'}{capture name='grn_workflow_system_key_109_2'}{cb_msg module='grn.workflow.system' key='key_109_2' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_system_key_109_2 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;cmd.value='copy';" disabled=$is_not_manage}{cb_msg module='grn.workflow.system' key='key_109_3' replace='true'}
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
<input type="hidden" name="cmd" value="">
</form>

<!-- 経路情報  -->
{if 0 >= $public_path_total || ! $is_manage}
{assign var='no_public_path' value=true}
{/if}
{if 1 >= $acceptance_path_step_total || ! $is_manage}
{assign var='no_acceptance_path_step' value=true}
{/if}
{if 1 >= $circular_path_step_total || ! $is_manage}
{assign var='no_circular_path_step' value=true}
{/if}
{if 0 >= $path_step_total || ! $is_manage}
{assign var='no_path_step' value=true}
{elseif 1 >= $path_step_total}
{assign var='no_path_condition' value=true}
{/if}
{if $form.path}
<p>
<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_route_info_y' replace='true'}</div>
<div id="main_menu_part">
{if GRN_WORKFLOW_PRIVATE_PATH == $path.col_type}
 <span class="menu_item">{capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_with_no_cancel_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_change_y page=workflow/operation/form_path_modify cid=$category_id fid=$form_id pid=$pid image='modify20.gif' disabled=$is_not_manage}</span>
 <span class="menu_item">{capture name='grn_workflow_system_w_share_pathway'}{cb_msg module='grn.workflow.system' key='w_share_pathway' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_share_pathway page=workflow/operation/form_path_publish cid=$category_id fid=$form_id image='open20.gif' disabled=$is_not_manage}</span>
{else}
 <span class="menu_item">{capture name='grn_workflow_system_w_do_set_private_route_y'}{cb_msg module='grn.workflow.system' key='w_do_set_private_route_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_set_private_route_y page=workflow/operation/form_path_add cid=$category_id fid=$form_id image='private_path20.gif' disabled=$is_not_manage}</span>
{/if}
 <span class="menu_item">{capture name='grn_workflow_system_w_set_shared_pathway'}{cb_msg module='grn.workflow.system' key='w_set_shared_pathway' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_set_shared_pathway page=workflow/operation/form_path_select cid=$category_id fid=$form_id image='public_path20.gif' disabled=$no_public_path}</span>
 <span class="menu_item">{capture name='grn_workflow_system_w_pathway_preview'}{cb_msg module='grn.workflow.system' key='w_pathway_preview' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_pathway_preview page=workflow/operation/form_path_preview_select cid=$category_id fid=$form_id pid=$pid image='path20.gif' disabled=$no_path_step}</span>
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
   {capture name='grn_workflow_system_w_yes'}{cb_msg module='grn.workflow.system' key='w_yes' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_workflow_system_w_yes}
{else}
   {capture name='grn_workflow_system_w_no'}{cb_msg module='grn.workflow.system' key='w_no' replace='true'}{/capture}{grn_sentence caption=$smarty.capture.grn_workflow_system_w_no}
{/if}
  </td>
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
  <td>
{if 1 == $path.col_icon}
   {grn_image image='check20.gif'}
{else}
   &nbsp;
{/if}
  </td>
 </tr>
{if GRN_WORKFLOW_PUBLIC_PATH == $path.col_type}
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.workflow.system' key='w_number_of_app_form_y' replace='true'}</th>
  <td>{$path.form_total|escape}</td>
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
</p>
<!-- 申請経路  -->
{if GRN_WORKFLOW_PRIVATE_PATH == $path.col_type}
<p>
<form name="{$form_name}/acceptance_path" method="post" action="{grn_pageurl page='workflow/operation/form_path_step_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_approve_route_y' replace='true'}</div>
<div id="main_menu_part">
 <span class="menu_item">{capture name='grn_workflow_system_w_do_add_y'}{cb_msg module='grn.workflow.system' key='w_do_add_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_add_y page=workflow/operation/form_path_step_add cid=$category_id fid=$form_id image='write20.gif' disabled=$is_not_manage}</span>
 <span class="menu_item">{capture name='grn_workflow_system_w_do_change_order_y'}{cb_msg module='grn.workflow.system' key='w_do_change_order_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_change_order_y page=workflow/operation/form_path_step_order cid=$category_id fid=$form_id image='order20.gif' disabled=$no_acceptance_path_step}</span>
</div>
<div class="wf_path_table">
<table class="list_column">
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
  <th>{include file='workflow/checkall.tpl' func_name="CheckAllAcceptancePathSteps" form_name="`$form_name`/acceptance_path" elem_name='psids[]' checkall_disabled=$is_not_manage}</th>
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
  <td class="wf_route_arrow_area_grn" rowspan="{$acceptance_path_step_total}" align="center"><span class="wf_route_arrow_grn">{cb_msg module='grn.workflow.system' key='w_arrow_downward' replace='true'}</span></td>
{/if}
  <td>{grn_checkbox name='psids[]' id="psids_`$path_step._id`" value=$path_step._id disabled=$is_not_manage}</td>
  <td nowrap>
   {grn_link caption=$path_step.col_role page='workflow/operation/form_path_step_view' cid=$category_id fid=$form_id psid=$path_step._id}
  </td>
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
</div>
<div class="marginHalf">
{cb_msg module='grn.workflow.system' key='w_delete_checked_item_1' replace='true'}{capture name='grn_workflow_system_w_delete_checked_item_2'}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_2' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_system_w_delete_checked_item_2 onclick="if(!grn_is_checked(this.form,'psids[]')) return false;" disabled=$is_not_manage}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_3' replace='true'}
</div>
</form>
</p>
<p>
<form name="{$form_name}/circular_path" method="post" action="{grn_pageurl page='workflow/operation/form_path_step_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_circular_pathway' replace='true'}</div>
<div id="main_menu_part">
 <span class="menu_item">{capture name='grn_workflow_system_w_do_add_y'}{cb_msg module='grn.workflow.system' key='w_do_add_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_add_y page=workflow/operation/form_path_step_add  cid=$category_id fid=$form_id col_type=1 image='write20.gif' disabled=$is_not_manage}</span>
 <span class="menu_item">{capture name='grn_workflow_system_w_do_change_order_y'}{cb_msg module='grn.workflow.system' key='w_do_change_order_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_change_order_y page=workflow/operation/form_path_step_order cid=$category_id fid=$form_id col_type=1 image='order20.gif' disabled=$no_circular_path_step}</span>
</div>
<div class="wf_path_table">
<table class="list_column">
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
  <th>{include file='workflow/checkall.tpl'  func_name="CheckAllCircularPathSteps" form_name="`$form_name`/circular_path" elem_name='psids[]' disabled=$is_not_manage}</th>
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
  <td class="wf_route_arrow_area_grn" rowspan="{$circular_path_step_total|escape}" align="center"><span class="wf_route_arrow_grn">{cb_msg module='grn.workflow.system' key='w_arrow_downward' replace='true'}</span></td>
{/if}
  <td>{grn_checkbox name='psids[]' id="psids_`$path_step._id`" value=$path_step._id disabled=$is_not_manage}</td>
  <td nowrap>
   {grn_link caption=$path_step.col_role page='workflow/operation/form_path_step_view' cid=$category_id fid=$form_id psid=$path_step._id}
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
</div>
<div class="marginHalf">
{cb_msg module='grn.workflow.system' key='w_delete_checked_item_1' replace='true'}{capture name='grn_workflow_system_w_delete_checked_item_2'}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_2' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_system_w_delete_checked_item_2 onclick="if(!grn_is_checked(this.form,'psids[]')) return false;" disabled=$is_not_manage}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_3' replace='true'}
</div>
</form>
</p>
{else}
<p>
<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_app_route_y' replace='true'}</div>
<div class="wf_path_table">
<table class="list_column">
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
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_do_allow_change_route_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_initial_value_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_do_allow_change_initial_value_by_applicant_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_pathway_step_code' replace='true'}</th>
 </tr>
{assign var=not_first value=true}
{foreach name=path_steps from=$path_steps item=path_step}
 <tr>
{if $not_first}
{assign var=not_first value=false}
  <td class="wf_route_arrow_area_grn" rowspan="{$path_step_total|escape}" align="center"><span class="wf_route_arrow_grn">{cb_msg module='grn.workflow.system' key='w_arrow_downward' replace='true'}</span></td>
{/if}
  <td nowrap>
   {grn_link caption=$path_step.col_role page='workflow/operation/form_path_step_view'  cid=$category_id fid=$form_id psid=$path_step._id}
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
</p>
{/if}

<!-- 経路分岐情報  -->
{assign var='item_id' value=$path_skip.col_item}
{assign var='path_skip_item' value=$item_list.$item_id}
<p>
{if 0 >= $path_skip_item_total || $path_skip || ! $is_manage}
{assign var='already_set' value=true}
{/if}
{if ! $path_skip_item.display_type || ! $is_manage}
{assign var='no_set' value=true}
{/if}
<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_split_info_route_y' replace='true'}</div>
<div id="main_menu_part">
<span class="menu_item">{capture name='grn_workflow_system_w_do_set_y'}{cb_msg module='grn.workflow.lang' key='form_view_w_do_set_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_set_y page='workflow/operation/path_skip_set' cid=$category_id fid=$form_id image='write20.gif' disabled=$already_set}</span>
<span class="menu_item">{capture name='grn_workflow_system_w_do_delete'}{cb_msg module='grn.workflow.system' key='w_do_delete' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_delete page='workflow/operation/path_skip_delete' cid=$category_id fid=$form_id sid=$path_skip._id image='delete20.gif' disabled=$no_set}</span>
</div>
{if $item_id}
<table class="view_table" width="80%">
<col width="15%">
<col width="85%">
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.workflow.system' key='w_item_type_2' replace='true'}</th>
  <td>{$path_skip_item.display_type|escape}</td>
 </tr>
 <tr>
  <th valign="top" nowrap>{cb_msg module='grn.workflow.system' key='w_split_item_name_y' replace='true'}</th>
  <td>{$path_skip_item.display_name|escape}</td>
 </tr>
</table>
</p>

{if $path_skip_item.display_type == null}{assign var='no_path_condition' value=true}{/if}
{if ($path_skip_item.foreign_key == GRN_WORKFLOW_CONDITION_ITEM_RADIO && $path_skip_item.settings.radio_items == null) || ($path_skip_item.foreign_key == GRN_WORKFLOW_CONDITION_ITEM_MENU_STRING && $path_skip_item.settings.menu_items == null && $path_skip_item.settings.menu_item_type == 0)}
{assign var='no_path_condition' value=true}
{/if}

{if $path_skip_item.display_type != null}
<p>
<form name="{$form_name}/pathcondition" method="post" action="{grn_pageurl page='workflow/operation/path_condition_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
<input type="hidden" name="sid" value="{$path_skip._id|escape}">

<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_route_split_condition_list_y' replace='true'}</div>
<div id="main_menu_part">
 <span class="menu_item">{capture name='grn_workflow_system_w_do_add_y'}{cb_msg module='grn.workflow.system' key='w_do_add_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_add_y page='workflow/operation/path_condition_add' cid=$category_id fid=$form_id sid=$path_skip._id image='write20.gif' disabled=$no_path_condition}</span>
 <span class="menu_item">{if $condition_list_count <= 1 || ! $is_manage}{assign var='condition_order_disabled' value='true'}{/if}{capture name='grn_workflow_system_w_do_change_order_y'}{cb_msg module='grn.workflow.system' key='w_do_change_order_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_change_order_y page=workflow/operation/path_condition_order cid=$category_id fid=$form_id sid=$path_skip._id image='order20.gif' disabled=$condition_order_disabled}</span>
</div>
<div class="wf_path_table">
 <table class="list_column">
    <colgroup>
     <col width="1%">
     <col width="15%">
     <col width="20%">
     <col width="65%">
    </colgroup>
  <th>{include file='workflow/checkall.tpl' func_name="CheckAllpathConditions" form_name="`$form_name`/pathcondition" elem_name='pcids[]' disabled=$is_not_manage}</th>
 </th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_split_name_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_split_condition_y' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_route_after_apply_condition_y' replace='true'}</th>
 </tr>
{foreach from=$condition_list key=id item=condition}
<tr>
 <td nowrap>
  {grn_checkbox name='pcids[]' id="pcids`$condition._id`" value=$condition._id caption='' disabled=$is_not_manage}</td>
 <td nowrap>{grn_link caption=$condition.col_name page='workflow/operation/path_condition_view' cid=$category_id fid=$form_id sid=$path_skip._id pcid=$condition._id}</td>
 <td nowrap>{$condition.col_display_name|escape}{cb_msg module='grn.workflow.system' key='w_A_matching_B' replace='true'}{$condition.operator|escape}{cb_msg module='grn.workflow.system' key='w_A_matching_B' replace='true'}{$condition.condition|escape}</td>
 <td nowrap>
{foreach name=path_step_list from=$condition_path_step_list[$condition._id] item=condition_path_step}
{$condition_path_step.col_role|escape}{if $smarty.foreach.path_step_list.last == false}{cb_msg module='grn.workflow.system' key='w_inequality_right' replace='true'}{/if}
{/foreach}
 </td>
</tr>
{/foreach}
</table>
</div>
<div class="marginHalf">
{cb_msg module='grn.workflow.system' key='w_delete_checked_item_1' replace='true'}{capture name='grn_workflow_system_w_delete_checked_item_2'}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_2' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_system_w_delete_checked_item_2 onclick="if(!grn_is_checked(this.form,'pcids[]')) return false;" disabled=$is_not_manage}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_3' replace='true'}
</div>
</form>
</p>
  {/if}
{else}
<p style="margin-left:2em">
  {cb_msg module='grn.workflow.system' key='w_default_split' replace='true'}
</p>
{/if}
{else}
<p>
<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_route_info_y' replace='true'}</div>
<div id="main_menu_part">
 <span class="menu_item">{capture name='grn_workflow_system_w_do_set_private_route_y'}{cb_msg module='grn.workflow.system' key='w_do_set_private_route_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_set_private_route_y page=workflow/operation/form_path_add cid=$category_id fid=$form_id image='private_path20.gif' disabled=$is_not_manage}</span>
 <span class="menu_item">{capture name='grn_workflow_system_w_set_shared_pathway'}{cb_msg module='grn.workflow.system' key='w_set_shared_pathway' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_set_shared_pathway page=workflow/operation/form_path_select cid=$category_id fid=$form_id image='public_path20.gif' disabled=$no_public_path}</span>
</div>
</p>
<p style="margin-left:2em">
  {cb_msg module='grn.workflow.system' key='w_default_path' replace='true'}
</p>
{/if}

<!--footer-->
{include file="grn/footer.tpl"}

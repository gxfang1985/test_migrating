<table class="view_table" width="80%">
 <colgroup>
  <col width="20%">
  <col width="80%">
 </colgroup>
 <tr valign="top">
  <th>{cb_msg module='grn.workflow.system' key='w_memo_for_sysytem_administrator' replace='true'}</th>
  <td>{grn_format body=$form.admin_memo}</td>
 </tr>
</table>

<form name="{$form_name}" method="post" action="{grn_pageurl page="workflow/$link_identifier/form_serial_initialize1"}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<p>
<div class="sub_title">{cb_msg module='grn.workflow.system' key='w_app_form_info_y' replace='true'}</div>
<div id="main_menu_part">
 <span class="menu_item">{capture name='grn_workflow_system_w_do_change_y'}{cb_msg module='grn.workflow.system' key='w_do_change_with_no_cancel_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_change_y page=workflow/$link_identifier/form_modify cid=$category_id fid=$form_id image='modify20.gif' disabled=$is_not_manage element_id="workflow/system/form_modify"}</span>
 <span class="menu_item">{capture name='grn_workflow_system_w_move'}{cb_msg module='grn.workflow.system' key='w_move' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_move page=workflow/$link_identifier/form_move cid=$category_id fid=$form_id image='move20.gif' disabled=$is_not_manage element_id="workflow/system/form_move"}</span>
 <span class="menu_item">{capture name='grn_workflow_system_w_do_delete'}{cb_msg module='grn.workflow.system' key='w_do_delete' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_delete page=workflow/$link_identifier/form_delete cid=$category_id fid=$form_id image='delete20.gif' disabled=$is_not_manage element_id="workflow/system/form_delete"}</span>
 {if $form.active == 0}
 {if $is_not_manage || 0 == $path_step_total}{assign var=disabled_activate value=true}{/if}
  <span class="menu_item">{capture name='grn_workflow_system_w_do_valid_y'}{cb_msg module='grn.workflow.system' key='w_do_valid_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_valid_y page=workflow/$link_identifier/form_activate cid=$category_id fid=$form_id image='open20.gif' disabled=$disabled_activate element_id="workflow/system/form_activate"}</span>
 {else}
  <span class="menu_item">{capture name='grn_workflow_system_w_do_invalid_y'}{cb_msg module='grn.workflow.system' key='w_do_invalid_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_do_invalid_y page=workflow/$link_identifier/form_activate cid=$category_id fid=$form_id image='open20.gif' disabled=$is_not_manage element_id="workflow/system/form_activate"}</span>
 {/if}
 <div id="rare_menu_part_under">
  <span class="menu_item">{capture name='grn_workflow_system_w_setting_icon'}{cb_msg module='grn.workflow.system' key='w_setting_icon' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_setting_icon page=workflow/$link_identifier/form_icon_modify cid=$category_id fid=$form_id image='workflow_icon20.gif' disabled=$is_not_manage element_id="workflow/system/form_icon_modify"}</span>
  <span class="menu_item">{capture name='grn_workflow_system_w_set_app_no_y'}{cb_msg module='grn.workflow.system' key='w_set_app_no_y' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_w_set_app_no_y page=workflow/$link_identifier/form_serial_modify cid=$category_id fid=$form_id image='workflow_serial20.gif' disabled=$is_not_manage element_id="workflow/system/form_serial_modify"}</span>
  {if $allow_customization}
    <span class="menu_item">{capture name='grn_workflow_system_GRN_WKF_SYS_135'}{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-137' replace='true'}{/capture}{grn_link caption=$smarty.capture.grn_workflow_system_GRN_WKF_SYS_135 page=workflow/$link_identifier/customization_resource fid=$form_id image='disk20.gif' disabled=$is_not_manage element_id="workflow/system/customization_resource"}</span>
  {/if}
 </div>
</div>
<table class="view_table" width="80%">
 <colgroup>
  <col width="20%">
  <col width="70%">
  <col width="10%">
 </colgroup>
 <tr valign="top">
  <th>{cb_msg module='grn.workflow.system' key='petition_csv_form_name' replace='true'}</th>
  <td colspan="2">{$form.name|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.workflow.system' key='w_app_form_code_y' replace='true'}</th>
  <td colspan="2">{$form.foreign_key|escape}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.workflow.system' key='w_category' replace='true'}</th>
  <td colspan="2">
      {if $category_id == GRN_WORKFLOW_CATEGORY_NONPARTY_ID}{grn_image image='category_trush20.gif'}{cb_msg module='grn.workflow.system' key='w_unlabeled' replace='true'}{else}{grn_image image='category20.gif'}{$category.name|escape}{/if}
  </td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.workflow.system' key='w_description_y' replace='true'}</th>
  <td colspan="2">{grn_format body=$form.memo}</td>
 </tr>
{if $smarty.const.ON_FOREST !== 1}
 <tr valign="top">
  <th>{cb_msg module='grn.workflow.system' key='w_automatic_export_of_app_data_y' replace='true'}</th>
  <td colspan="2">
      {if $form.auto_export}{$form.export_folder|escape}{/if}
  </td>
 </tr>
{/if}
 <tr valign="top">
  <th>{cb_msg module='grn.workflow.system' key='w_valid_invalid_app_form_y' replace='true'}</th>
  <td colspan="2">{if $form.active}<span class="font_green">{cb_msg module='grn.workflow.system' key='w_valid_y' replace='true'}</span>{else}<span class="font_red">{cb_msg module='grn.workflow.system' key='w_invalid_y' replace='true'}</span>{/if}</td>
 </tr>
 <tr valign="top">
  <th>{cb_msg module='grn.workflow.system' key='w_icon' replace='true'}</th>
  <td colspan="2">
      {grn_workflow_form_icon_image icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url}
      {$form.icon_name|escape}
  </td>
 </tr>
      {if $form.serial_type == 1}
 <tr valign="top">
  <th>{cb_msg module='grn.workflow.system' key='w_final_app_number_y' replace='true'}</th>
  <td>{$form.serial_number|escape}</td>
  <td>{capture name='grn_workflow_system_w_do_initialize_y'}{cb_msg module='grn.workflow.system' key='w_do_initialize_y' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_system_w_do_initialize_y}</td>
 </tr>
      {/if}
 <tr valign="top">
  <th>{cb_msg module='grn.workflow.system' key='w_set_app_no_format_y' replace='true'}</th>
  <td colspan="2">
      {if $form.serial_type == 0}
        {cb_msg module='grn.workflow.system' key='w_use_common_app_no_in_all_form_y' replace='true'}
      {elseif $form.serial_type == 1}
        {cb_msg module='grn.workflow.system' key='w_app_form_code_app_number_use_y' replace='true'}
      {else}
        {cb_msg module='grn.workflow.system' key='w_do_not_use_app_no_y' replace='true'}
      {/if}
  </td>
 </tr>
      {if $form.serial_type == 1}
 <tr valign="top">
  <th>{cb_msg module='grn.workflow.system' key='w_set_app_no_form' replace='true'}</th>
  <td colspan="2">{$form.serial_format|escape}</td>
 </tr>
      {/if}
{if $form.approved_serial_type == 1}
 <tr valign="top">
  <th>{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-120' replace='true'}</th>
  <td>{if $form.approved_serial_number}{$form.approved_serial_number|escape}{else}0{/if}</td>
  <td>{capture name='grn_workflow_system_w_do_initialize_y'}{cb_msg module='grn.workflow.system' key='w_do_initialize_y' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_system_w_do_initialize_y page=workflow/$link_identifier/form_approved_serial_initialize1 cid=$category_id fid=$form_id}</td>
 </tr>
{/if}
<tr valign="top">
 <th>{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-117' replace='true'}</th>
 <td colspan="2">
  {if $form.approved_serial_type == 1}
   {cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-114' replace='true'}
  {else}
   {cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-116' replace='true'}
  {/if}
 </td>
</tr>
{if $form.approved_serial_type == 1}
 <tr valign="top">
  <th>{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-124' replace='true'}</th>
  <td colspan="2">{$form.approved_serial_format|escape}</td>
 </tr>
{/if}
{if $allow_customization}
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.workflow.system' key='GRN_WKF_SYS-137' replace='true'}</th>
  <td colspan="2">
    {$activation_customization_resource_string|escape}
  </td>
 </tr>
{/if}
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_registeration_info_y' replace='true'}</th>
  <td colspan="2">
   {grn_user_name uid=$form.creator name=$form.creator_name}
   {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$form.ctime}
  </td>
  </tr>
  <tr valign="top">
   <th nowrap>{cb_msg module='grn.workflow.system' key='w_modified_info_y' replace='true'}</th>
   <td colspan="2">
    {grn_user_name uid=$form.modifier name=$form.modifier_name}
    {grn_date_format format='DateTimeMiddle_YMDW_HM' date=$form.mtime}
   </td>
  </tr>
</table>
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
</form>


{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename|cat:$tmp_key}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<!-- 見通しよくナビゲーション -->

<center>
<table border=0>
 <tr align="center">
  <td class="step_grn" valign="middle">{cb_msg module='grn.workflow' key='enter_contents' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_current_grn" valign="middle">{cb_msg module='grn.workflow' key='set_path' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_grn" valign="middle">{cb_msg module='grn.workflow' key='confirm_contents' replace='true'}</td>
 </tr>
</table>
</center>

<!-- ここまで　見通しよくナビゲーション -->

<p class="explanation">{cb_msg module='grn.workflow' key='set_application_path' replace='true'}</p>
{assign var='half_width_number' value='1'}
{include file='grn/_ajax_submit_check_error.tpl'}

{foreach from=$path_step_data_list key=psid item=path_step_data}
 {capture name=validate_require}{$path_step_data.col_role|grn_noescape}{cb_msg module='grn.workflow' key='required_field' replace='true'}{/capture}
 {validate form=$form_name field="path_step_`$path_step_data._id`_sUID" criteria="notEmpty" message=$smarty.capture.validate_require append="validation_errors"}
{/foreach}

<p></p>
{cb_msg module='grn.workflow' key='opened_bracket' replace='true'}<span class="bold">{grn_workflow_form_icon_image icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url}{$petition.form_name|escape}{cb_msg module='grn.workflow' key='opened_parenthesis' replace='true'}{$petition.name|escape}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</span>{cb_msg module='grn.workflow' key='closed_bracket' replace='true'}
<div class="border-partition-common-grn"></div>

{if $path}
{if $path.col_icon}
<span class="sub_title">{cb_msg module='grn.workflow' key='application_path' replace='true'}</span>&nbsp;<span class="adjust_link"><small>{capture name='grn_workflow_description'}{cb_msg module='grn.workflow' key='whats_this' replace='true'}{/capture}{grn_link image='popup14.gif' page='workflow/popup_path_explain' caption=$smarty.capture.grn_workflow_description target='_blank' cid=$category_id fid=$form_id}</small></span>
{else}
<div class="sub_title">{cb_msg module='grn.workflow' key='application_path' replace='true'}</div>
<div class="path_explanation">
{if $path.col_description && $path.col_richeditor}
<div class="adjust_link">{$path.col_description|grn_noescape}</div>
{else}
<small>
{grn_format body=$path.col_description}
</small>
{/if}
</div>
{/if}
{else}
<div class="sub_title">{cb_msg module='grn.workflow' key='application_path' replace='true'}</div>
{/if}
{grn_workflow_member_add
name='route_member_add'
form_name=$form_name
sUID='sUID'
CGID='CGID'
CID='candidate_CID'
path_step_list=$path_step_data_list
path_step_count=$path_step_data_count
include_org=$show_organize
access_plugin=$plugin}
{strip}
 <div class="mTop15 mBottom15">
  {capture name='grn_workflow_back_to_prev_screen'}{cb_msg module='grn.workflow' key='back_to_prev_screen' replace='true'}{/capture}
  {capture name='grn_workflow_confirm_contents_2'}{cb_msg module='grn.workflow' key='confirm_contents_2' replace='true'}{/capture}
  {capture name='grn_workflow_do_cancel'}{cb_msg module='grn.workflow' key='do_cancel' replace='true'}{/capture}
  {capture name='grn_pageurl_command_send_path_remand_proxy'}{grn_pageurl page=workflow/command_`$page_info.last`}{/capture}
  {grn_button id='workflow_button_back' spacing='tight' caption=$smarty.capture.grn_workflow_back_to_prev_screen onclick="document.forms['$form_name'].cmd.value='back'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_send_path_remand_proxy`', this);"}
  {grn_button id='workflow_button_confirm' ui='main' spacing='loose' caption=$smarty.capture.grn_workflow_confirm_contents_2 onclick="document.forms['$form_name'].cmd.value='send'; grn.component.member_add.get_instance('route_member_add').prepareSubmit(); grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_send_path_remand_proxy`', this);"}
  {grn_button id='workflow_button_cancel' caption=$smarty.capture.grn_workflow_do_cancel onclick="document.forms['$form_name'].cmd.value='cancel'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_send_path_remand_proxy`', this);"}
 </div>
{/strip}
<input type="hidden" name="cmd" value="">
<input type="hidden" name="sf" value="1">
<input type="hidden" name="fid" value="{$folder_id|escape}">
<input type="hidden" name="pid" value="{$petition_id|escape}">
<input type="hidden" name="mode" value="{$mode|escape}">
<input type="hidden" name="simple" value="{$simple|escape}">
<input type="hidden" name="cpsf" value="{$cpsf|escape}">
<input type="hidden" name="handle" value="{$handle|escape}">
<input type="hidden" name="tmp_key" value="{$tmp_key|escape}">
</form>
{grn_load_javascript file="grn/html/component/ajax_submit_wf.js"}
{grn_load_javascript file="grn/html/page/workflow/ajax_submit.js"}

{include file="grn/footer.tpl"}

{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p>
<div class="explanation">

 {cb_msg module='grn.workflow' key='GRN_WKF_10' replace='true'}{$cancel_message}{cb_msg module='grn.workflow' key='GRN_WKF_11' replace='true'}<br>
 <span class="bold"> {grn_workflow_form_icon_image icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url}{if $petition.petition_number != ''}No.{$petition.petition_number|escape}{/if} {$petition.form_name|escape}{cb_msg module='grn.workflow' key='key_2_2' replace='true'}{$petition.name|escape}{cb_msg module='grn.workflow' key='key_2_3' replace='true'}</span><br>
{cb_msg module='grn.workflow' key='enter_comment_if_necessary' replace='true'}<br>
{if $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING}
{cb_msg module='grn.workflow' key='move_application_to_draft' replace='true'}
{/if}
</div>
</p>

<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_workflow_name'}{cb_msg module='grn.workflow' key='name' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_name}</th>
  <td>
  {if $petition.agent_user}
   {grn_user_name uid=$petition.user name=$petition.user_name}
   {cb_msg module='grn.workflow' key='per_pro_applicant_bracket' replace='true'}{grn_user_name uid=$petition.agent_user name=$petition.agent_user_name}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
  {else}
   {grn_user_name uid=$login.id name=$login.name}
  {/if}
  </td>
 </tr>
 <tr>
  <th valign="top" nowrap>{capture name='grn_workflow_comment'}{cb_msg module='grn.workflow' key='comment' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_workflow_comment}</th>
  <td>
   {grn_textarea name="comment" cols="50" rows="5" value=$col_admin_memo}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
   <div class="mTop10">
    {strip}
     {capture name='grn_workflow_back_from_cancel'}{cb_msg module='grn.workflow' key='back_from_cancel' replace='true'}{/capture}
     {capture name='grn_pageurl_command_cancel'}{grn_pageurl page=workflow/command_`$page_info.last`}{/capture}
     {grn_button id=`$page_info.last`_submit ui='main' spacing='normal' caption=$cancel_button onclick="document.forms['$form_name'].cancel.value=''; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_cancel`', this);"}
     {if $cpsf}
      {grn_button id=`$page_info.last`_submit_back_from_cancel caption=$smarty.capture.grn_workflow_back_from_cancel
      onclick="document.forms['$form_name'].cancel.value='1'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_cancel`', this);"}
     {else}
      {if GRN_WORKFLOW_FOLDER_TYPE_UNPROCESSED_ID == $folder.col_folder_type}
       {grn_button id='workflow_button_back' action='cancel' page='workflow/handle' page_param_fid=$fid page_param_pid=$pid page_param_simple=$simple caption=$smarty.capture.grn_workflow_back_from_cancel}
      {else}
       {grn_button id='workflow_button_back' action='cancel' page='workflow/view' page_param_fid=$fid page_param_pid=$pid page_param_simple=$simple caption=$smarty.capture.grn_workflow_back_from_cancel}
      {/if}
     {/if}
    {/strip}
   </div>
  </td>
 </tr>
</table>
<input type="hidden" name="fid" value="{$fid|escape}">
<input type="hidden" name="pid" value="{$pid|escape}">
<input type="hidden" name="simple" value="{$simple|escape}">
<input type="hidden" name="handle" value="{$handle|escape}">
<input type="hidden" name="cpsf" value="{$cpsf|escape}">
<input type="hidden" name="cancel" value="">
<input type="hidden" name="tmp_key" value="{$tmp_key|escape}">
</form>

{include file='grn/_ajax_submit_check_error.tpl'}
{grn_load_javascript file="grn/html/component/ajax_submit_wf.js"}
{grn_load_javascript file="grn/html/page/workflow/ajax_submit.js"}

{include file='grn/footer.tpl'}

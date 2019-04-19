{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<!-- ##_ここに各画面のデザイン_## -->

<!-- 見通しよくナビゲーション -->
<center>
<table border=0>
 <tr align="center">
  <td class="step_grn" valign="middle">{cb_msg module='grn.workflow' key='enter_contents' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_grn" valign="middle">{cb_msg module='grn.workflow' key='set_path' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_current_grn" valign="middle">{cb_msg module='grn.workflow' key='confirm_contents' replace='true'}</td>
 </tr>
</table>
</center>
<!-- ここまで　見通しよくナビゲーション -->

<p class="explanation">{cb_msg module='grn.workflow' key='confirm_application' replace='true'}</p>

<p></p>
{cb_msg module='grn.workflow' key='opened_bracket' replace='true'}<span class="bold">{grn_workflow_form_icon_image icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url}{$form.name|escape}{cb_msg module='grn.workflow' key='opened_parenthesis' replace='true'}{$form.subject|escape}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</span>{cb_msg module='grn.workflow' key='closed_bracket' replace='true'}
<p></p>
<table class="view_table">
 <tr valign="middle">
  <th rowspan="1" align="left" width="30%" nowrap>{cb_msg module='grn.workflow' key='priority' replace='true'}</th>
  <td nowrap>{grn_workflow_priority value=$properties.priority mode="view_confirm"}</td>
 </tr>
</table>
<div class="border-partition-common-grn"></div>

<table width="100%">
 <tr>
  <td>
   <span class="sub_title">{cb_msg module='grn.workflow' key='application_contents' replace='true'}</span>
   <table class="view_table" width="100%">
<!-- ここから　項目セクション -->
{foreach from=$item_list item=item_line}
 {if $item_line.type == 2}
   </table>
    <table width="100%">
     <tr valign="top">
      <td>
       <div class="wf_empty_row"></div>
      </td>
     </tr>
    </table>
   <table class="view_table" width="100%">
 {elseif $item_line.type == 3}
   <tr valign="top">
       <td colspan="2">
           {if $item_line.sub_item_count == 0}
               <div id="js_customization_item_{$item_line.code}"></div>
           {else}
               <table class="layout-border-none" width="100%">
                   <tr>
                       {grn_workflow_include_item folder_id=$folder_id petition_id=$petition_id iid=$item_line.iid item=$item_line display="view-confirm"}
                       {foreach from=$item_line.sub_item_list item=sub_item}
                           {grn_workflow_include_item folder_id=$folder_id petition_id=$petition_id iid=$sub_item.iid item=$sub_item display="view-confirm"}
                       {/foreach}
                   </tr>
               </table>
           {/if}
       </td>
   </tr>
 {else}
    <tr valign="top">
        {if $item_line.type != 3}
            <th rowspan="1" align="left">
                {$item_line.display_name|escape}
            </th>
        {/if}
   {if $item_line.sub_item_count == 0}
    {grn_workflow_include_item folder_id=$folder_id petition_id=$petition_id iid=$item_line.iid item=$item_line display="view-confirm"}
   {else}
     <td nowrap>
      {if $item_line.right_align_flag == 1}
      <table class="layout-border-none-full-width">
      {else}
      <table class="layout-border-none" width="100%">
      {/if}
       <tr>
    {grn_workflow_include_item folder_id=$folder_id petition_id=$petition_id iid=$item_line.iid item=$item_line display="view-confirm"}
    {foreach from=$item_line.sub_item_list item=sub_item}
     {grn_workflow_include_item folder_id=$folder_id petition_id=$petition_id iid=$sub_item.iid item=$sub_item display="view-confirm"}
    {/foreach}
       </tr>
      </table>
     </td>
   {/if}
    </tr>
  {if $item_line.type == 1}
    <tr valign="top">
     <th rowspan="1" align="left">{cb_msg module='grn.workflow' key='col_agent_type_0' replace='true'}</th>
     <td nowrap>{grn_user_name uid=$petition.agent_user name=$petition.agent_user_name users_info=$users_info}</td>
    </tr>
    <tr valign="top">
     <th rowspan="1" align="left">{cb_msg module='grn.workflow' key='mandator' replace='true'}</th>
     <td nowrap>{grn_user_name uid=$petition.user name=$petition.user_name users_info=$users_info}</td>
    </tr>
  {/if}
 {/if}
{/foreach}
<!-- ここまで　項目セクション -->
   </table>
  </td>
 </tr>
</table>

<p>
<div class="wf_path_table_simple">
<span class="sub_title">{cb_msg module='grn.workflow' key='application_path' replace='true'}</span>
<small>
{if !$simple}
{cb_msg module='grn.workflow' key='bracket_arrow_left' replace='true'}{capture name='grn_workflow_hide_processor'}{cb_msg module='grn.workflow' key='hide_processor' replace='true'}{/capture}{grn_link page='workflow/send_confirm_draft_proxy' caption=$smarty.capture.grn_workflow_hide_processor fid=$folder_id pid=$petition_id sf=1 simple=1 tmp_key=$tmp_key}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
{else}
{cb_msg module='grn.workflow' key='bracket_arrow_right' replace='true'}{capture name='grn_workflow_show_all_processor'}{cb_msg module='grn.workflow' key='show_all_processor' replace='true'}{/capture}{grn_link page='workflow/send_confirm_draft_proxy' caption=$smarty.capture.grn_workflow_show_all_processor fid=$folder_id pid=$petition_id sf=1 simple=0 tmp_key=$tmp_key}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
{/if}
</small>

<table class="list_column">
 <tr>
  <th nowrap><br></th>
  <th nowrap>{cb_msg module='grn.workflow' key='path_class' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow' key='path_step' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow' key='processor' replace='true'}</th>
 </tr>
 <tr>
  <td class="wf_route_arrow_area_grn" align="center" rowspan="{$path_step_count|escape}"><span class="wf_route_arrow_grn">{cb_msg module='grn.workflow' key='arrow_down' replace='true'}</span></td>
 {foreach from=$path_step_list key=psid item=path_step}
  {if GRN_WORKFLOW_CIRCULAR == $path_step.col_type}
  <td nowrap>
   {cb_msg module='grn.workflow' key='pass_along' replace='true'}
  {else}
   {if $path_step.last_acceptance}
  <td class="last_decision" nowrap>
   <span class="kind">{cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}</span>
   {else}
  <td nowrap>
   {cb_msg module='grn.workflow' key="col_acceptance_type_`$path_step.col_acceptance_type`"}
   {/if}
  {/if}
  </td>
  <td>{$path_step.col_role|escape}</td>
  {if !$simple}
  <td>
   <table class="layout">
   {foreach from=$path_step.users item=user}
    <tr>
{if $user._id}
     <td nowrap>{grn_user_name uid=$user._id name=$user.col_display_name valid=$user.col_valid users_info=$users_info}</td>
{else}
     <td nowrap>{cb_msg module='grn.workflow' key='skip'}</td>
{/if}
    </tr>
   {/foreach}
   </table>
  </td>
  {else}
   {if $next_flag != 1}
  <td align="center" rowspan="{$path_step_count|escape}" nowrap>
   <small>{cb_msg module='grn.workflow' key='bracket_arrow_right' replace='true'}{capture name='grn_workflow_show_all_processor'}{cb_msg module='grn.workflow' key='show_all_processor' replace='true'}{/capture}{grn_link page='workflow/send_confirm_draft_proxy' caption=$smarty.capture.grn_workflow_show_all_processor fid=$folder_id pid=$petition_id sf=1 simple=0 tmp_key=$tmp_key}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}</small>
  </td>
    {assign var="next_flag" value="1"}
   {/if}
  {/if}
 </tr>
 {/foreach}
</table>
<small>
{if !$simple}
{cb_msg module='grn.workflow' key='bracket_arrow_left' replace='true'}{capture name='grn_workflow_hide_processor'}{cb_msg module='grn.workflow' key='hide_processor' replace='true'}{/capture}{grn_link page='workflow/send_confirm_draft_proxy' caption=$smarty.capture.grn_workflow_hide_processor fid=$folder_id pid=$petition_id sf=1 simple=1 tmp_key=$tmp_key}{cb_msg module='grn.workflow' key='closed_parenthesis' replace='true'}
{/if}
</small>
</div>
{strip}
  <div class="mTop15 mBottom15">
      {capture name='grn_workflow_back_to_prev_screen'}{cb_msg module='grn.workflow' key='back_to_prev_screen' replace='true'}{/capture}
      {capture name='grn_workflow_apply_per_pro'}{cb_msg module='grn.workflow' key='apply_per_pro' replace='true'}{/capture}
      {capture name='grn_workflow_do_cancel'}{cb_msg module='grn.workflow' key='do_cancel' replace='true'}{/capture}
      {capture name='grn_pageurl_command_send_confirm_draft_proxy'}{grn_pageurl page=workflow/command_`$page_info.last`}{/capture}
      {grn_button id='workflow_button_back' spacing='tight' caption=$smarty.capture.grn_workflow_back_to_prev_screen onclick="document.forms['$form_name'].cmd.value='back'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_send_confirm_draft_proxy`', this);"}
      {grn_button id='workflow_button_create_proxy_request' ui='main' spacing='loose' caption=$smarty.capture.grn_workflow_apply_per_pro onclick="document.forms['$form_name'].cmd.value='send'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_send_confirm_draft_proxy`', this);"}
      {grn_button id='workflow_button_cancel' caption=$smarty.capture.grn_workflow_do_cancel onclick="document.forms['$form_name'].cmd.value='cancel'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_send_confirm_draft_proxy`', this);"}
  </div>
{/strip}
<input type="hidden" name="cmd" value="">
<input type="hidden" name="fid" value="{$folder_id|escape}">
<input type="hidden" name="pid" value="{$petition_id|escape}">
<input type="hidden" name="mode" value="{$mode|escape}">
<input type="hidden" name="simple" value="{$simple|escape}">
<input type="hidden" name="tmp_key" value="{$tmp_key|escape}">
</form>

{include file='grn/_ajax_submit_check_error.tpl'}
{grn_load_javascript file="grn/html/component/ajax_submit_wf.js"}
{grn_load_javascript file="grn/html/page/workflow/ajax_submit.js"}

{if $apply_customization}
    {grn_load_customization_js_css}
{/if}

<!-- ##_ここまで各画面のデザイン_## -->
{include file="grn/footer.tpl"}

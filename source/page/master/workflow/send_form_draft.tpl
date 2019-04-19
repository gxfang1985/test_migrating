{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{include file="grn/common.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename|cat:$tmp_key}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/command_'|cat:$page_info.last}" enctype="multipart/form-data" onsubmit="{literal}if (this.cmd.value == ''){return false};{/literal}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<!-- ##_ここに各画面のデザイン_## -->

<!-- 見通しよくナビゲーション -->
<center>
<table border=0>
 <tr align="center">
  <td class="step_current_grn" valign="middle">{cb_msg module='grn.workflow' key='enter_contents' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_grn" valign="middle">{cb_msg module='grn.workflow' key='set_path' replace='true'}</td>
  <td><span class="step_arrow_grn"></span></td>
  <td class="step_grn" valign="middle">{cb_msg module='grn.workflow' key='confirm_contents' replace='true'}</td>
 </tr>
</table>
</center>
<!-- ここまで　見通しよくナビゲーション -->

<p class="explanation">{cb_msg module='grn.workflow' key='edit_draft' replace='true'}</p>
{assign var='half_width_number' value='1'}
{include file='grn/_ajax_submit_check_error.tpl'}
{include file='grn/indispensable.tpl'}

<p></p>
{cb_msg module='grn.workflow' key='opened_bracket' replace='true'}<span class="bold">{grn_workflow_form_icon_image icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url}{$form.name|escape}</span>{cb_msg module='grn.workflow' key='closed_bracket' replace='true'}
<table class="std_form">
 <tr valign="middle">
  <th rowspan="1" align="left" width="30%" nowrap>{cb_msg module='grn.workflow' key='priority' replace='true'}</th>
  <td nowrap>{grn_workflow_priority value=$properties.priority mode="edit"}</td>
 </tr>
</table>
<div class="border-partition-common-grn"></div>

<table class="std_form">
<!-- ここから　項目セクション -->
{foreach from=$item_list item=item_line}
 {if $item_line.type == 2}
 <tr valign="top">
  <td rowspan="1" colspan="1" align="left" width=""><div class="wf_empty_row"></div></td>
 </tr>
 {elseif $item_line.type == 3}
     <tr valign="top">
         <td colspan="2">
             {if $item_line.sub_item_count == 0}
                 <div id="js_customization_item_{$item_line.code}"></div>
             {else}
                 <table>
                     <tr>
                         {grn_workflow_include_item folder_id=$folder_id petition_id=$petition_id iid=$item_line.iid item=$item_line display="input"}
                         {foreach from=$item_line.sub_item_list item=sub_item}
                             {grn_workflow_include_item folder_id=$folder_id petition_id=$petition_id iid=$sub_item.iid item=$sub_item display="input"}
                         {/foreach}
                     </tr>
                 </table>
             {/if}
         </td>
     </tr>
 {else}
 <tr valign="top">
  {if $item_line.type != 3}
    {if $item_line.description}
        <th rowspan="2" align="left" width="30%" nowrap>
    {else}
        <th rowspan="1" align="left" width="30%" nowrap>
    {/if}
    {grn_show_input_title title=$item_line.display_name necessary=$item_line.total_required}
    {assign var="current_display_name" value=$item_line.display_name}
    </th>
  {/if}
  {if $item_line.sub_item_count == 0}
   {grn_workflow_include_item folder_id=$folder_id petition_id=$petition_id iid=$item_line.iid item=$item_line display="input"}
 </tr>
  {else}
  <td>
   <table class="std_form_table_sub_grn">
    <tr>
   {grn_workflow_include_item folder_id=$folder_id petition_id=$petition_id iid=$item_line.iid item=$item_line display="input"}
   {foreach from=$item_line.sub_item_list item=sub_item}
    {grn_workflow_include_item folder_id=$folder_id petition_id=$petition_id iid=$sub_item.iid item=$sub_item display="input"}
   {/foreach}
    </tr>
   </table>
  </td>
 </tr>
  {/if}
  {if $item_line.description}
 <tr>
  <td>
   {if $item_line.description_type != 1}
    {if $item_line.description_editor == 1}
   <div class="adjust_link">{$item_line.description|grn_noescape}</div>
    {else}
     {grn_format body=$item_line.description}
    {/if}
   {else}
   <div class="adjust_link"><small>{capture name='grn_workflow_description'}{cb_msg module='grn.workflow' key='whats_this' replace='true'}{/capture}{grn_link image='popup14.gif' page='workflow/send_description_common' caption="[`$smarty.capture.grn_workflow_description`]" target='_blank' category_id=$category_id form_id=$form_id item_id=$item_line.iid mode=$mode}</small></div>
   {/if}
  </td>
 </tr>
  {/if}
  {if $item_line.type == 1}
 <tr valign="top">
  <th rowspan="1" align="left" width="30%" nowrap>{cb_msg module='grn.workflow' key='item_type_5' replace='true'}</th>
  <td nowrap>{grn_user_name uid=$login.id name=$login.name}</td>
 </tr>
  {/if}
 {/if}
{/foreach}
<!-- ここまで　項目セクション -->
 <tr>
  <td></td>
  <td>
   {strip}
   <div class="mTop10">
    {capture name='grn_pageurl_command_send_form_draft'}{grn_pageurl page=workflow/command_`$page_info.last`}{/capture}
    {capture name='grn_workflow_set_path_2'}{cb_msg module='grn.workflow' key='set_path_2' replace='true'} >>{/capture}
    {capture name='grn_workflow_change_draft'}{cb_msg module='grn.workflow' key='change_draft' replace='true'}{/capture}
    {capture name='grn_workflow_do_cancel'}{cb_msg module='grn.workflow' key='do_cancel' replace='true'}{/capture}
    {capture name='grn_workflow_set_route_onclick'}
        if(grn.component.button("#workflow_button_set_route").isDisabled())
            return false;
        document.forms['{$form_name}'].cmd.value='next';
        if((typeof(workflow_file_validate)=='function') && (!confirmIfExistFailedFile() || !workflow_file_validate(false)))
            return false;
        else grn.page.workflow.ajax_submit.workflow_submit('{$form_name}', '{$smarty.capture.grn_pageurl_command_send_form_draft}', this);
    {/capture}
    {capture name='grn_workflow_save_as_draft_onclick'}
        if(grn.component.button("#workflow_button_save_as_draft").isDisabled())
            return false;
        document.forms['{$form_name}'].cmd.value='save';
        if((typeof(workflow_file_validate)=='function') && (!confirmIfExistFailedFile() || !workflow_file_validate(true)))
            return false;
        else grn.page.workflow.ajax_submit.workflow_submit('{$form_name}', '{$smarty.capture.grn_pageurl_command_send_form_draft}', this);
    {/capture}
     {grn_button id='workflow_button_set_route' ui='main' spacing='loose' caption=$smarty.capture.grn_workflow_set_path_2 onclick=$smarty.capture.grn_workflow_set_route_onclick}
     {grn_button id='workflow_button_save_as_draft' class="button_submit_grn" spacing='tight' caption=$smarty.capture.grn_workflow_change_draft onclick=$smarty.capture.grn_workflow_save_as_draft_onclick}
     {grn_button id='workflow_button_cancel' class="button_submit_grn" caption=$smarty.capture.grn_workflow_do_cancel onclick="if(grn.component.button('#workflow_button_cancel').isDisabled())return false; document.forms['$form_name'].cmd.value='cancel'; grn.page.workflow.ajax_submit.workflow_submit('$form_name', '`$smarty.capture.grn_pageurl_command_send_form_draft`', this);"}
   </div>
   {/strip}
  </td>
 </tr>
</table>
<input type="hidden" name="sf" value="1">
<input type="hidden" name="cmd" value="">
<input type="hidden" name="fid" value="{$folder_id|escape}">
<input type="hidden" name="pid" value="{$petition_id|escape}">
<input type="hidden" name="mode" value="{$mode|escape}">
<input type="hidden" name="simple" value="{$simple|escape}">
<input type="hidden" id="tmp_key" name="tmp_key" value="{$tmp_key|escape}">
</form>
<span style="display: none" id="auto_schedule_register_pop_up">{cb_msg module='grn.workflow' key='send_form_pop_up' replace='true' }</span>
{grn_load_javascript file="grn/html/component/ajax_submit_wf.js"}
{grn_load_javascript file="grn/html/page/workflow/ajax_submit.js"}

{if $apply_customization}
    {grn_load_customization_js_css}
{/if}

<!-- ##_ここまで各画面のデザイン_## -->
{include file="grn/footer.tpl"}

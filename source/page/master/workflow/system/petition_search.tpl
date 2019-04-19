{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="cid" value="2">
<input type="hidden" name="in" value="1">

{literal}
<script language="JavaScript" type="text/javascript">
<!--
function change_term( form, sel )
{
    if( sel.options[sel.selectedIndex].value == 'before' )
    {
        form.elements['li'].disabled = true;
    }
    else
    {
        form.elements['li'].disabled = false;
    }
}
//-->
</script>
{/literal}

<table class="std_form">
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.workflow' key='application_form' replace='true'}</th>
  <td>
   {capture name='suffix'}
    {if $form.deleted == 1}
     {cb_msg module='grn.workflow' key='[deleted]'}
    {elseif $form.active == 0}
     {cb_msg module='grn.workflow' key='[deactive]'}
    {/if}
   {/capture}
   {grn_workflow_form_icon_image icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url}<span class="bold">{grn_sentence caption=$form.name|cat:$smarty.capture.suffix}</span>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_search_chars_y' replace='true'}</th>
  <td>
   {grn_text necessary=true name="text" value=$search.text size="50"}
   <input type="submit" name="Search" value="{cb_msg module='grn.workflow.system' key='w_do_search_y' replace='true'}"><br>
   {capture name='grn_workflow_system_w_specify_chars_caps_non_caps_y'}{cb_msg module='grn.workflow.system' key='w_specify_chars_caps_non_caps_y' replace='true'}{/capture}{grn_checkbox name="sensitive" id="sensitive" value="1" checked=$search.sensitive caption=$smarty.capture.grn_workflow_system_w_specify_chars_caps_non_caps_y}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_search_target_condition_y' replace='true'}</th>
  <td>
   {capture name='grn_workflow_view_status_0'}{cb_msg module='grn.workflow' key='view_status_0' replace='true'}{/capture}{grn_checkbox name="status_0" id="status_0" value="1" checked=$search.status.0 caption=$smarty.capture.grn_workflow_view_status_0}
   {capture name='grn_workflow_view_status_1'}{cb_msg module='grn.workflow' key='view_status_1' replace='true'}{/capture}{grn_checkbox name="status_1" id="status_1" value="1" checked=$search.status.1 caption=$smarty.capture.grn_workflow_view_status_1}
   {capture name='grn_workflow_view_status_2'}{cb_msg module='grn.workflow' key='view_status_2' replace='true'}{/capture}{grn_checkbox name="status_2" id="status_2" value="1" checked=$search.status.2 caption=$smarty.capture.grn_workflow_view_status_2}
   {capture name='grn_workflow_view_status_3'}{cb_msg module='grn.workflow' key='view_status_3' replace='true'}{/capture}{grn_checkbox name="status_3" id="status_3" value="1" checked=$search.status.3 caption=$smarty.capture.grn_workflow_view_status_3}
   {capture name='grn_workflow_view_status_4'}{cb_msg module='grn.workflow' key='view_status_4' replace='true'}{/capture}{grn_checkbox name="status_4" id="status_4" value="1" checked=$search.status.4 caption=$smarty.capture.grn_workflow_view_status_4}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_application_date_y' replace='true'}{cb_msg module='grn.workflow.system' key='w_period' replace='true'}</th>
  <td>
   <input type="hidden" name="start_term_" value="1">
   <input type="hidden" name="end_term_"   value="1">
   {grn_select_date form_name=$form_name necessary=false show_wday=true prefix='start_term_' date=$search.start_date}
   {cb_msg module='grn.workflow.system' key='w_wavy_line ' replace='true'}{grn_select_date form_name=$form_name necessary=false show_wday=true prefix='end_term_' date=$search.end_date}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.workflow.system' key='w_search_item_y' replace='true'}</th>
  <td>
   {capture name='grn_workflow_system_petition_csv_no'}{cb_msg module='grn.workflow.system' key='petition_csv_no' replace='true'}{/capture}{grn_checkbox name="item_0" id="item_0" value="1" checked=$search.item.0 caption=$smarty.capture.grn_workflow_system_petition_csv_no}
   {capture name='grn_workflow_system_petition_csv_subject'}{cb_msg module='grn.workflow.system' key='petition_csv_subject' replace='true'}{/capture}{grn_checkbox name="item_1" id="item_1" value="1" checked=$search.item.1 caption=$smarty.capture.grn_workflow_system_petition_csv_subject}
   {capture name='grn_workflow_system_w_applicant_y'}{cb_msg module='grn.workflow.system' key='w_applicant_y' replace='true'}{/capture}{grn_checkbox name="item_2" id="item_2" value="1" checked=$search.item.2 caption=$smarty.capture.grn_workflow_system_w_applicant_y}
   {capture name='grn_workflow_system_w_entry_item_chars_y'}{cb_msg module='grn.workflow.system' key='w_entry_item_chars_y' replace='true'}{/capture}{grn_checkbox name="item_3" id="item_3" value="1" checked=$search.item.3 caption=$smarty.capture.grn_workflow_system_w_entry_item_chars_y}
  </td>
 </tr>
 <tr>
  <td></td>
   <td>{capture name='grn_workflow_system_w_do_search_y'}{cb_msg module='grn.workflow.system' key='w_do_search_y' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_workflow_system_w_do_search_y}</td>
 </tr>
</table>
<input type="hidden" name="cid" value="{$category_id|escape}">
<input type="hidden" name="fid" value="{$form_id|escape}">
</form>

<!--petition_list-->

<hr>
<p>
<div class="sub_title">{cb_msg module='grn.workflow.system' key='key_116' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</div>
<div class="contents_navi"><nobr>{include file="grn/word_navi.tpl" navi=$navi.navi}</nobr></div>
<form name="{$form_name}/petition_delete_multi" method="post" action="{grn_pageurl page='workflow/system/petition_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <table class="list_column">
  <colgroup>
   <col width="1%">
   <col width="5%">
   <col width="10%">
   <col width="25%">
   <col width="10%">
   <col width="15%">
   <col width="15%">
   <col width="15%">
  </colgroup>
  <tr>
   <th>{include file='workflow/checkall.tpl' form_name="`$form_name`/petition_delete_multi" elem_name='ids[]'}</th>
{if $sort == 'pnu'}
   <th nowrap>{capture name='grn_workflow_system_petition_csv_no'}{cb_msg module='grn.workflow.system' key='petition_csv_no' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_system_petition_csv_no page=$page_info.all cid=$category_id fid=$form_id sort='pnd' sf=1 sp=0 reverse=1}</th>
{elseif  $sort == 'pnd'}
   <th nowrap>{capture name='grn_workflow_system_petition_csv_no'}{cb_msg module='grn.workflow.system' key='petition_csv_no' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_system_petition_csv_no page=$page_info.all cid=$category_id fid=$form_id sort='pnu' sf=1 sp=0}</th>
{else}
  <th nowrap>{capture name='grn_workflow_system_petition_csv_no'}{cb_msg module='grn.workflow.system' key='petition_csv_no' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_system_petition_csv_no page=$page_info.all cid=$category_id fid=$form_id sort='pnd'  sf=1 sp=0 disable=1}</th>
{/if}
   <th nowrap>{cb_msg module='grn.workflow.system' key='w_priority_y' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.workflow.system' key='petition_csv_subject' replace='true'}</th>
   <th nowrap>{cb_msg module='grn.workflow.system' key='w_status_y' replace='true'}</th>
{if $sort == 'unu'}
   <th nowrap>{capture name='grn_workflow_system_w_applicant_y'}{cb_msg module='grn.workflow.system' key='w_applicant_y' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_system_w_applicant_y page=$page_info.all cid=$category_id fid=$form_id sort='und' sf=1 sp=0 reverse=1}</th>
{elseif $sort == 'und'}
   <th nowrap>{capture name='grn_workflow_system_w_applicant_y'}{cb_msg module='grn.workflow.system' key='w_applicant_y' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_system_w_applicant_y page=$page_info.all cid=$category_id fid=$form_id sort='unu' sf=1 sp=0}</th>
{else}
   <th nowrap>{capture name='grn_workflow_system_w_applicant_y'}{cb_msg module='grn.workflow.system' key='w_applicant_y' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_system_w_applicant_y page=$page_info.all cid=$category_id fid=$form_id sort='und' sf=1 sp=0 disable=1}</th>
{/if}
   <th nowrap>{cb_msg module='grn.workflow.system' key='w_final_approver_y' replace='true'}</th>
{if $sort == 'ctu'}
   <th nowrap>{capture name='grn_workflow_system_w_application_date_y'}{cb_msg module='grn.workflow.system' key='w_application_date_y' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_system_w_application_date_y page=$page_info.all cid=$category_id fid=$form_id sort='ctd' sf=1 sp=0 reverse=1}</th>
{elseif $sort == 'ctd'}
   <th nowrap>{capture name='grn_workflow_system_w_application_date_y'}{cb_msg module='grn.workflow.system' key='w_application_date_y' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_system_w_application_date_y page=$page_info.all cid=$category_id fid=$form_id sort='ctu' sf=1 sp=0}</th>
{else}
   <th nowrap>{capture name='grn_workflow_system_w_application_date_y'}{cb_msg module='grn.workflow.system' key='w_application_date_y' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_system_w_application_date_y page=$page_info.all cid=$category_id fid=$form_id sort='ctd' sf=1 sp=0 disable=1}</th>
{/if}
  </tr>
{foreach from=$petition_list item=petition}
  <tr valign="top">
   <td nowrap>{grn_checkbox name='ids[]' id="ids_`$petition.pid`" value=$petition.pid}</td>
   <td nowrap>{$petition.petition_number|escape}</td>
   <td nowrap>{grn_workflow_priority value=$petition.priority mode="view_list"}</td>
   <td nowrap>{grn_link page='workflow/system/petition_view' caption=$petition.name truncated_caption=$subject_width cid=$category_id fid=$form_id pid=$petition.pid}</td>
   <td nowrap>
 {if $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING || $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS || $petition.status == GRN_WORKFLOW_STATUS_REMAND}{* 未処理/進行中/差し戻し *}
    <font color=#003399><span class="bold">{cb_msg module='grn.workflow' key='view_status_0' replace='true'}</span></font>
 {elseif $petition.status == GRN_WORKFLOW_STATUS_ACCEPTANCE}
    <font color=#009966><span class="bold">{cb_msg module='grn.workflow' key='view_status_1' replace='true'}</span></font>
 {elseif $petition.status == GRN_WORKFLOW_STATUS_REJECTION}
    <font color=#CC3300><span class="bold">{cb_msg module='grn.workflow' key='view_status_2' replace='true'}</span></font>
 {elseif $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL}
    <font color=#999999><span class="bold">{cb_msg module='grn.workflow' key='view_status_3' replace='true'}</span></font>

 {elseif $petition.status == GRN_WORKFLOW_STATUS_TEMPORARY || $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL}
    <font color=#999999><span class="bold">{cb_msg module='grn.workflow' key='col_folder_type_6' replace='true'}</span></font>
 {elseif $petition.status == GRN_WORKFLOW_STATUS_FINISHED}
    <font color=#006600><span class="bold">{cb_msg module='grn.workflow' key='view_status_4' replace='true'}</span></font>
 {/if}
   </td>
   <td nowrap>{grn_user_name uid=$petition.user name=$petition.user_name truncated=$name_width valid=$petition.user_valid users_info=$users_info}</td>
   <td nowrap>
 {if $petition.status == GRN_WORKFLOW_STATUS_REJECTION}
  {grn_user_name uid=$petition.transactor_id name=$petition.transactor_name truncated=$name_width valid=$petition.transactor_valid users_info=$users_info}
 {else}
  {foreach from=$petition.transactor item=user}
   {grn_user_name uid=$user._id name=$user.col_display_name truncated=$name_width valid=$user.col_valid users_info=$users_info}
  {/foreach}
  {if $petition.transactor_num > $show_user_num},{cb_msg module='grn.workflow.system' key='petition_csv_dash' replace='true'}{/if}
 {/if}
   </td>
   <td nowrap>{grn_date_format date=$petition.ctime}</td>
  </tr>
{/foreach}
 </table>
 <div class="contents_navi"><nobr>{include file="grn/word_navi.tpl" navi=$navi.navi}</nobr></div>
 <div class="contents_navi">
  <nobr>
{cb_msg module='grn.workflow.system' key='w_delete_checked_item_1' replace='true'}{capture name='grn_workflow_system_w_delete_checked_item_2'}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_2' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_system_w_delete_checked_item_2 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;"}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_3' replace='true'}
  </nobr>
 </div>
 <input type="hidden" name="cid" value="{$category_id|escape}">
 <input type="hidden" name="fid" value="{$form_id|escape}">
</form>

{include file="grn/system_footer.tpl"}

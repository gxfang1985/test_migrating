{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

<!--menubar-->
<div id="main_menu_part">
    <span class="menu_item">{if $form_id == 0}{assign var='export_disabled' value='true'}{/if}{capture name='grn_workflow_system_w_output_CSV'}{cb_msg module='grn.workflow.system' key='w_output_CSV' replace='true'}{/capture}{grn_link page='workflow/system/petition_export' caption=$smarty.capture.grn_workflow_system_w_output_CSV image='export20.gif' cid=$category_id fid=$form_id disabled=$export_disabled}</span>
    <div id="rare_menu_part_under">
        <span class="menu_item">{if $navi.count < 1}{assign var='delete_disabled' value='true'}{/if}{capture name='grn_workflow_system_w_delete_all_app_form_data_y'}{cb_msg module='grn.workflow.system' key='w_delete_all_app_form_data_y' replace='true'}{/capture}{grn_link page='workflow/system/petition_delete_all' caption=$smarty.capture.grn_workflow_system_w_delete_all_app_form_data_y image='delete20.gif' cid=$category_id fid=$form_id disabled=$delete_disabled}</span>
    </div>
</div>
<!--menubar_end-->

<!--category_path-->
{if !$form_id}{assign var='search_disabled' value='true'}{/if}
{capture name='grn_workflow_system_w_application_data_y'}{cb_msg module='grn.workflow.system' key='w_application_data_y' replace='true'}{/capture}{include file="workflow/_category_path.tpl" search_action='workflow/system/petition_search' app_name=$smarty.capture.grn_workflow_system_w_application_data_y search_disabled=$search_disabled}
<!--category_path_end-->

<!--category_tree-->
<table width="100%">
 <tr valign="top">
  <td id="tree_part" width="30%">
{include file="workflow/_category_structure.tpl" no_extra=1}
<!--category_tree_end-->
<!--form_list-->
   <div class="border-partition-common-grn"></div>
   <div class="sub_title">{cb_msg module='grn.workflow.system' key='w_app_form_y' replace='true'}</div>
{foreach from=$form_list item=form}
   <div class="tree_item">
 {capture name='suffix'}
  {if $form.deleted == 1}
   {cb_msg module='grn.workflow' key='[deleted]'}
  {elseif $form.active == 0}
   {cb_msg module='grn.workflow' key='[deactive]'}
  {/if}
 {/capture}
 {if $form.fid == $form_id}
   <nobr>{grn_workflow_form_icon_image icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url}<span style="background:#bbbbff"><span class="bold">{grn_sentence caption=$form.name|cat:$smarty.capture.suffix}</span></span>
   </nobr>
 {else}
  {if $form.type == 0}
    <nobr>{grn_workflow_link page='workflow/system/petition_list' caption=$form.name|cat:$smarty.capture.suffix icon_type=$form.icon_type icon_id=$form.icon_id icon_url=$form.icon_url cid=$category_id fid=$form.fid}</nobr>
  {/if}
 {/if}
   </div>
{/foreach}
  </td>
<!--form_list_end-->

<!--petition_list-->
  <td id="view_part" width="70%">
   {assign var="current_form" value=$form_list.$form_id}
   {if $current_form}
   <div class="bold">{grn_workflow_form_icon_image icon_type=$current_form.icon_type icon_id=$current_form.icon_id icon_url=$current_form.icon_url}{grn_sentence caption=$current_form.name}</div>
   {/if}
   <div class="margin_vert">
    <form name="{$form_name}_list_item" method="get" action="{grn_pageurl page='workflow/system/petition_list'}">
     <input type="hidden" name="cid" value="{$category_id|escape}">
     <input type="hidden" name="fid" value="{$form_id|escape}">
     {grn_select name="condition" size="1" options=$condition_options onchange="this.form.submit()"}
     {cb_msg module='grn.workflow.system' key='key_120_1' replace='true'} <input type="button" value="{cb_msg module='grn.workflow.system' key='key_120_2' replace='true'}" onclick="this.form.submit();">&nbsp;
     <span class="sub_title">{cb_msg module='grn.workflow.system' key='w_application_data_y' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi.start_count end_num=$navi.end_count all_num=$navi.count}</span>
    </form>
   </div>

   <div class="contents_navi">{include file="grn/word_navi.tpl" navi=$navi.navi}</div>
   <form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/system/petition_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
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
      <th>{include file='workflow/checkall.tpl' form_name=$form_name elem_name='ids[]'}</th>
{if $sort == 'pnu'}
      <th nowrap>{capture name='grn_workflow_system_petition_csv_no'}{cb_msg module='grn.workflow.system' key='petition_csv_no' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_system_petition_csv_no page=$page_info.all cid=$category_id fid=$form_id sort='pnd' sp=0 sf=2 reverse=1}</th>
{elseif  $sort == 'pnd'}
      <th nowrap>{capture name='grn_workflow_system_petition_csv_no'}{cb_msg module='grn.workflow.system' key='petition_csv_no' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_system_petition_csv_no page=$page_info.all cid=$category_id fid=$form_id sort='pnu' sp=0 sf=2}</th>
{else}
      <th nowrap>{capture name='grn_workflow_system_petition_csv_no'}{cb_msg module='grn.workflow.system' key='petition_csv_no' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_system_petition_csv_no page=$page_info.all cid=$category_id fid=$form_id sort='pnd' sp=0 sf=2 disable=1}</th>
{/if}
      <th nowrap>{cb_msg module='grn.workflow.system' key='w_priority_y' replace='true'}</th>
      <th nowrap>{cb_msg module='grn.workflow.system' key='petition_csv_subject' replace='true'}</th>
      <th nowrap>{cb_msg module='grn.workflow.system' key='w_status_y' replace='true'}</th>
{if $sort == 'unu'}
      <th nowrap>{capture name='grn_workflow_system_w_applicant_y'}{cb_msg module='grn.workflow.system' key='w_applicant_y' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_system_w_applicant_y page=$page_info.all cid=$category_id fid=$form_id sort='und' sp=0 sf=2 reverse=1}</th>
{elseif $sort == 'und'}
      <th nowrap>{capture name='grn_workflow_system_w_applicant_y'}{cb_msg module='grn.workflow.system' key='w_applicant_y' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_system_w_applicant_y page=$page_info.all cid=$category_id fid=$form_id sort='unu' sp=0 sf=2}</th>
{else}
      <th nowrap>{capture name='grn_workflow_system_w_applicant_y'}{cb_msg module='grn.workflow.system' key='w_applicant_y' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_system_w_applicant_y page=$page_info.all cid=$category_id fid=$form_id sort='und' sp=0 sf=2 disable=1}</th>
{/if}
      <th nowrap>{cb_msg module='grn.workflow.system' key='w_final_approver_y' replace='true'}</th>
{if $sort == 'ctu'}
      <th nowrap>{capture name='grn_workflow_system_w_application_date_y'}{cb_msg module='grn.workflow.system' key='w_application_date_y' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_system_w_application_date_y page=$page_info.all cid=$category_id fid=$form_id sort='ctd' sp=0 sf=2 reverse=1}</th>
{elseif $sort == 'ctd'}
      <th nowrap>{capture name='grn_workflow_system_w_application_date_y'}{cb_msg module='grn.workflow.system' key='w_application_date_y' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_system_w_application_date_y page=$page_info.all cid=$category_id fid=$form_id sort='ctu' sp=0 sf=2}</th>
{else}
      <th nowrap>{capture name='grn_workflow_system_w_application_date_y'}{cb_msg module='grn.workflow.system' key='w_application_date_y' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_system_w_application_date_y page=$page_info.all cid=$category_id fid=$form_id sort='ctd' sp=0 sf=2 disable=1}</th>
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
       <font color=#999999><span class="bold">{cb_msg module='grn.workflow' key='view_status_5' replace='true'}</span></font>
 {elseif $petition.status == GRN_WORKFLOW_STATUS_FINISHED}
       <font color=#006600><span class="bold">{cb_msg module='grn.workflow' key='view_status_4' replace='true'}</span></font>
 {/if}
      </td>
      <td nowrap>{grn_user_name uid=$petition.user name=$petition.user_name truncated=$name_width valid=$petition.user_valid users_info=$users_info}</td>
      <td nowrap>
 {if $petition.status == GRN_WORKFLOW_STATUS_REJECTION}
  {grn_user_name uid=$petition.transactor_id name=$petition.transactor_name  truncated=$name_width valid=$petition.trancator_valid users_info=$users_info}
 {elseif $petition.status != GRN_WORKFLOW_STATUS_TEMPORARY}
  {foreach from=$petition.transactor item=user}
   {grn_user_name uid=$user._id  name=$user.col_display_name truncated=$name_width valid=$user.col_valid users_info=$users_info}
  {foreachelse}
{cb_msg module='grn.workflow.system' key='w_circulars' replace='true'}
  {/foreach}
  {if $petition.transactor_num > $show_user_num},<span class="dots">{cb_msg module='grn.workflow.system' key='petition_csv_dash' replace='true'}</span>{/if}
 {/if}
      </td>
      <td nowrap>{grn_date_format date=$petition.ctime}</td>
     </tr>
{/foreach}
    </table>
    <div class="contents_navi">{include file="grn/word_navi.tpl" navi=$navi.navi}</div>
{cb_msg module='grn.workflow.system' key='w_delete_checked_item_1' replace='true'}{capture name='grn_workflow_system_w_delete_checked_item_2'}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_2' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_system_w_delete_checked_item_2 onclick="if(!grn_is_checked(this.form,'ids[]')) return false;"}{cb_msg module='grn.workflow.system' key='w_delete_checked_item_3' replace='true'}
    <input type="hidden" name="cid" value="{$category_id|escape}">
    <input type="hidden" name="fid" value="{$form_id|escape}">
   </form>
  </td>
 </tr>
</table>

{include file="grn/system_footer.tpl"}

{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}

{capture name="common"}
      &nbsp;&nbsp; 
<span>{grn_select name="item_type_%NUM%" id="item_type_%NUM%" size="1" options=$item_type_options onchange="javascript:grn_workflow_change_search_item(%NUM%, this)"}</span>
<span id="fspan%NUM%">{grn_select name="item_expr_%NUM%"  size="1" options=$item_expr_options.standard}{grn_text name="item_value_%NUM%" size="35"}</span>
<span id="dspan"><input type="button" value="{cb_msg module='grn.workflow' key='delete_2' replace='true'}" onClick="javascript:grn_workflow_delete_search_item(%NUM%)"></span>
{/capture}

{capture name="delete_all"}
 <input type='button' value='{cb_msg module='grn.workflow' key='delete_all_condition' replace='true'}' onclick='return grn_workflow_delete_search_item_all();'>
{/capture}

{capture name="standard"}
{grn_select name="item_expr_%NUM%"  size="1" options=$item_expr_options.standard}{grn_text name="item_value_%NUM%" size="35" value=''}
{/capture}

{capture name="status"}
{grn_select name="item_expr_%NUM%"  size="1" options=$item_expr_options.status}{grn_select name="item_value_%NUM%"  size="1" options=$item_value_options}
{/capture}

{capture name="date"}
{grn_select name="item_expr_%NUM%"  size="1" options=$item_expr_options.date}{grn_workflow_select_date prefix="item_value_%NUM%_" form_name=$form_name}
{/capture}

{capture name="priority"}
{grn_select name="item_expr_%NUM%"  size="1" options=$item_expr_options.priority}{grn_select name="item_value_%NUM%"  size="1" options=$item_value_options_priority}
{/capture}

{literal}
<script language="JavaScript" type="text/javascript">
<!--
var wday_name = new Array("{/literal}{cb_msg module='fw.date' key='WDayShort0'}{literal}", "{/literal}{cb_msg module='fw.date' key='WDayShort1'}{literal}", "{/literal}{cb_msg module='fw.date' key='WDayShort2'}{literal}", "{/literal}{cb_msg module='fw.date' key='WDayShort3'}{literal}", "{/literal}{cb_msg module='fw.date' key='WDayShort4'}{literal}", "{/literal}{cb_msg module='fw.date' key='WDayShort5'}{literal}", "{/literal}{cb_msg module='fw.date' key='WDayShort6'}{literal}");
var date_day_unit = '{/literal}{cb_msg module='fw.ui' key='date_day_unit'}{literal}';
var date_year_unit = '{/literal}{cb_msg module='fw.ui' key='date_year_unit'}{literal}';

{/literal}{if $search.condition_item_count == 0}{literal}
var delete_count = 1
{/literal}{else}{literal}
var delete_count = {/literal}{$search.condition_item_count}{literal}
{/literal}{/if}{literal}
var idNum = {/literal}{if $search.condition_item_count == 0}1{else}{$search.condition_item_count}{/if}{literal};
var __wfmf_item_templates = new Array(7);
var __wfmf_item_common     = '{/literal}{$smarty.capture.common|escape:"javascript"}{literal}';
var __wfmf_item_delete_all = '{/literal}{$smarty.capture.delete_all|escape:"javascript"}{literal}';
__wfmf_item_templates[0]   = '{/literal}{$smarty.capture.standard|escape:"javascript"}{literal}';
__wfmf_item_templates[1]   = '{/literal}{$smarty.capture.standard|escape:"javascript"}{literal}';
__wfmf_item_templates[2]   = '{/literal}{$smarty.capture.standard|escape:"javascript"}{literal}';
__wfmf_item_templates[3]   = '{/literal}{$smarty.capture.status|escape:"javascript"}{literal}';
__wfmf_item_templates[4]   = '{/literal}{$smarty.capture.date|escape:"javascript"}{literal}';
__wfmf_item_templates[5]   = '{/literal}{$smarty.capture.standard|escape:"javascript"}{literal}';
__wfmf_item_templates[6] = '{/literal}{$smarty.capture.standard|escape:"javascript"}{literal}';
__wfmf_item_templates[7] = '{/literal}{$smarty.capture.priority|escape:"javascript"}{literal}';
//__wfmf_item_templates[6]   = '{/literal}{$smarty.capture.priority|escape:"javascript"}{literal}';
//-->
</script>
{/literal}
{grn_load_javascript file="grn/html/select_date.js"}
{grn_load_javascript file="grn/html/wf_select_date.js"}
{grn_load_javascript file="grn/html/wfmf.js"}
{* GRN2-6613
<p>*}
{* 検索条件*}
<form name="{$form_name}" method="post" action="{grn_pageurl page='workflow/'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="back_fid" value="{$back_fid}">
<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.workflow' key='search_target' replace='true'}</th>
  <td>{grn_select name='fid' size='1' options=$search.folder_options}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.workflow' key='number_of_items_to_display' replace='true'}</th>
  <td>{grn_select name='term' size='1' options=$search.term_options}</td>
 </tr>
 <tr>
  <th rowspan="3" id="fhead" rowspan="2">{cb_msg module='grn.workflow' key='search_condition' replace='true'}</th>
  <td>{grn_select name='condition'  size='1' options=$search.condition_options}</td>
 </tr>
 <tr>
  <td nowrap>
    <div id="fbox">
{if $search.condition_item_count == 0}
    <div id="fdiv1">
      &nbsp;&nbsp; 
      <span>{grn_select name='item_type_1' size='1' options=$item_type_options onchange="javascript:grn_workflow_change_search_item(1, this)"}</span>
      <span id="fspan1">{grn_select name='item_expr_1'  size='1' options=$item_expr_options.standard}{grn_text name='item_value_1' size='35' value=''}</span>
      <span id="dspan"><input type='button' value='{cb_msg module='grn.workflow' key='delete_2' replace='true'}' onClick='javascript:grn_workflow_delete_search_item(1)'></span>
    </div>
{else}
  {foreach name='condition_item' from=$search.condition_item_list item=condition_item}
    {assign var='num' value=$smarty.foreach.condition_item.iteration}
    <div id="fdiv{$num}">
      &nbsp;&nbsp;
        <span>{grn_select name='item_type_'|cat:$num size='1' options=$condition_item.type_options onchange='javascript:grn_workflow_change_search_item('|cat:$num|cat:', this)'}</span>
        {if $condition_item.type == GRN_WORKFLOW_SEARCH_ITEM_STATUS}
         <span id="fspan{$num}">{grn_select name='item_expr_'|cat:$num  size='1' options=$condition_item.expr_options}{grn_select name='item_value_'|cat:$num  size='1' options=$condition_item.value_options}</span>
        {elseif  $condition_item.type == GRN_WORKFLOW_SEARCH_ITEM_DATE}
         <span id="fspan{$num}">{grn_select name='item_expr_'|cat:$num  size='1' options=$condition_item.expr_options}{grn_workflow_select_date prefix='item_value_'|cat:$num|cat:'_' form_name=$form_name date=$condition_item.value}</span>
        {elseif $condition_item.type == GRN_WORKFLOW_SEARCH_ITEM_PRIORITY}
         <span id="fspan{$num}">{grn_select name='item_expr_'|cat:$num  size='1' options=$condition_item.expr_options}{grn_select name='item_value_'|cat:$num  size='1' options=$condition_item.value_options}</span>
        {else}
          <span id="fspan{$num}">{grn_select name='item_expr_'|cat:$num size='1' options=$condition_item.expr_options}{grn_text name='item_value_'|cat:$num size='35' value=$condition_item.value}</span>
        {/if}
     <span id="dspan"><input type='button' value='{cb_msg module='grn.workflow' key='delete_2' replace='true'}' onClick='javascript:grn_workflow_delete_search_item({$num})'></span>
    </div>
  {/foreach}
{/if}
   </div>
  </td>
 </tr>
 <tr>
  <td>
   <input type="button" value="{cb_msg module='grn.workflow' key='add_condition' replace='true'}" onclick="javascript:grn_workflow_add_search_item()">&nbsp;
   <span id="fdel"><span id="delete_all"><input type="button" value="{cb_msg module='grn.workflow' key='delete_all_condition' replace='true'}" onclick="javascript:grn_workflow_delete_search_item_all()"></span></span>
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
      <div class="mTop10 mBottom15">
          {capture name='grn_workflow_search_2'}{cb_msg module='grn.workflow' key='search_2' replace='true'}{/capture}
          {grn_button id='' ui='main' action='submit' caption=$smarty.capture.grn_workflow_search_2}
      </div>
  </td>
 </tr>
</table>
</form>
{literal}
<script language="JavaScript" type="text/javascript">
<!--
grn_workflow_check_search_delete(delete_count);
//-->
</script>
{/literal}

<table class="maincontents_list"><tbody><tr><td class="maincontents_list_td">

{if $folder.folder_type != GRN_WORKFLOW_FOLDER_TYPE_NEW_ID}

{if $folder.folder_type == GRN_WORKFLOW_FOLDER_TYPE_PROXY_APPROVAL_ID OR
    $folder.folder_type == GRN_WORKFLOW_FOLDER_TYPE_APPROVAL_PLAN_ID OR
    $folder.folder_type == GRN_WORKFLOW_FOLDER_TYPE_PUBLIC_ID
}
<p>
<div class="sub_title">{cb_msg module='grn.workflow' key='search_result_of_1' replace='true'}{$folder.name|escape}{cb_msg module='grn.workflow' key='search_result_of_2' replace='true'} {include file="grn/smart_data_count_310.tpl" start_num=$navi.start_count end_num=$navi.end_count}</div>
<div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$navi.navi}</nobr></div>
<table class="list_column">
 <colgroup>
  <col width="11%">
  <col width="5%">
  <col width="20%">
  <col width="20%">
  <col width="12%">
  {if $folder.folder_type == GRN_WORKFLOW_FOLDER_TYPE_PROXY_APPROVAL_ID}
  <col width="10%">
  <col width="10%">
  <col width="7%">
  {else}
  <col width="15%">
  <col width="12%">
  {/if}
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.workflow' key='item_type_0' replace='true'}</th>
  <th nowrap>
  {if $sort == 'pnu'}
      {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_id sort='pnd' sf=1 sp=0 reverse=1}
  {elseif  $sort == 'pnd'}
      {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_id sort='pnu' sf=1 sp=0}
  {else}
      {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_id sort='pnd' sf=1 sp=0 disable=1}
  {/if}
  </th>
  <th nowrap>
  {if $sort == 'fnu'}
      {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_id sort='fnd' sf=1 sp=0 reverse=1}
  {elseif  $sort == 'fnd'}
      {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_id sort='fnu' sf=1 sp=0}
  {else}
      {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_id sort='fnd' sf=1 sp=0 disable=1}
  {/if}
  </th>
  <th nowrap>{cb_msg module='grn.workflow' key='form_subject' replace='true'}</th>
  {if $folder.folder_type == GRN_WORKFLOW_FOLDER_TYPE_PROXY_APPROVAL_ID OR
      $folder.folder_type == GRN_WORKFLOW_FOLDER_TYPE_APPROVAL_PLAN_ID  OR
      $folder.folder_type == GRN_WORKFLOW_FOLDER_TYPE_PUBLIC_ID
  }
  <th nowrap>{cb_msg module='grn.workflow' key='item_type_3' replace='true'}</th>
  {else}
  <th nowrap>{cb_msg module='grn.workflow' key='result' replace='true'}</th>
  {/if}
  <th nowrap>
   {if $folder.folder_type == GRN_WORKFLOW_FOLDER_TYPE_OUT_ID}
    {cb_msg module='grn.workflow' key='processor' replace='true'}
   {elseif $folder.folder_type == GRN_WORKFLOW_FOLDER_TYPE_PROXY_APPROVAL_ID}
    {cb_msg module='grn.workflow' key='accept_delegated_user' replace='true'}
   {else}
    {cb_msg module='grn.workflow' key='item_type_5' replace='true'}
   {/if}</th>
  {if $folder.folder_type == GRN_WORKFLOW_FOLDER_TYPE_PROXY_APPROVAL_ID}
  <th nowrap>
  {cb_msg module='grn.workflow' key='item_type_5' replace='true'}
  </th>
  {/if}
  <th nowrap>
  {if $sort == 'ctu'}
      {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_id sort='ctd' sf=1 sp=0 reverse=1}
  {elseif $sort == 'ctd'}
      {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_id sort='ctu' sf=1 sp=0}
  {else}
      {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_id sort='ctd' sf=1 sp=0 disable=1}
  {/if}
  </th>
 </tr>
 {foreach from=$petition_list item=petition}
 <tr>
  <td nowrap>{$petition.petition_number|escape}</td>
  <td nowrap>{grn_workflow_priority value=$petition.priority mode="view_list"}</td>
    <td nowrap><nobr>{grn_workflow_link page='workflow/view' caption="`$petition.form_name`" truncated_caption=$subject_width_fix icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url fid=$petition.folder pid=$petition.pid}</nobr></td>
    <td nowrap><nobr>{grn_workflow_link page='workflow/view' caption="`$petition.name`" truncated_caption=$subject_width fid=$petition.folder pid=$petition.pid}</nobr></td>
  <td nowrap>
  {if $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING || $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS || $petition.status == GRN_WORKFLOW_STATUS_REMAND}{* 未処理/進行中/差し戻し *}
   <span class="wf_petition_status_highlight"><span class="progress">{cb_msg module='grn.workflow' key='view_status_0' replace='true'}</span></span>
  {elseif $petition.status == GRN_WORKFLOW_STATUS_ACCEPTANCE}
   <span class="wf_petition_status_highlight"><span class="ok">{cb_msg module='grn.workflow' key='view_status_1' replace='true'}</span></span>
  {elseif $petition.status == GRN_WORKFLOW_STATUS_REJECTION}
   <span class="wf_petition_status_highlight"><span class="decline">{cb_msg module='grn.workflow' key='view_status_2' replace='true'}</span></span>
  {elseif $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL || $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL}{* 取り消し/取り戻し *}
   <span class="wf_petition_status_highlight"><span class="deletion">{cb_msg module='grn.workflow' key='view_status_3' replace='true'}</span></span>
  {elseif $petition.status == GRN_WORKFLOW_STATUS_FINISHED}
   <span class="wf_petition_status_highlight"><span class="finished">{cb_msg module='grn.workflow' key='view_status_4' replace='true'}</span></span>
  {/if}
  </td>
  {if $folder.folder_type == GRN_WORKFLOW_FOLDER_TYPE_OUT_ID}
  {* 送信一覧 *}
  <td nowrap>
   {if $petition.status == GRN_WORKFLOW_STATUS_REJECTION}
   {* 却下の場合（却下したを表示） *}
    {grn_user_name uid=$petition.transactor_id name=$petition.transactor_name  truncated=$name_width valid=$petition.transactor_valid users_info=$users_info}
   {else}
    {foreach from=$petition.transactor item=user}
     {grn_user_name uid=$user.col_user name=$user.col_display_name name=$user.col_display_name truncated=$name_width valid=$user.col_valid users_info=$users_info}
    {foreachelse}
{cb_msg module='grn.workflow' key='pass_along_only_bracket' replace='true'}
    {/foreach}
    {if $petition.transactor_num > $show_user_num},{cb_msg module='grn.workflow' key='three_dots' replace='true'}{/if}
   {/if}
  </td>
  {else}
 {* 受信一覧 *}
  <td nowrap>
  {if $folder.folder_type == GRN_WORKFLOW_FOLDER_TYPE_PROXY_APPROVAL_ID}
    {grn_user_name uid=$petition.folder_user_id name=$petition.folder_user_name  truncated=$name_width valid=$petition.folder_user_valid users_info=$users_info}
  {else}
    {grn_user_name uid=$petition.user name=$petition.user_name  truncated=$name_width valid=$petition.user_valid users_info=$users_info}
  {/if}
  </td>
  {/if}
  {if $folder.folder_type == GRN_WORKFLOW_FOLDER_TYPE_PROXY_APPROVAL_ID}
  <td nowrap>
    {grn_user_name uid=$petition.user name=$petition.user_name  truncated=$name_width valid=$petition.user_valid users_info=$users_info}
  </td>
  {/if}
  
  <td nowrap>{grn_date_format date=$petition.ctime}</td>
 </tr>
 {/foreach}
</table>
<div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$navi.navi}</nobr></div>
{else}
<p>
<div class="sub_title">{cb_msg module='grn.workflow' key='search_result_of_1' replace='true'}{$folder.name|escape}{cb_msg module='grn.workflow' key='search_result_of_2' replace='true'} {include file="grn/smart_data_count_310.tpl" start_num=$navi.start_count end_num=$navi.end_count}</div>
<div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$navi.navi}</nobr></div>
<form name="{$form_name}_delete" method="post" action="{grn_pageurl page='workflow/delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div class="list_menu"><nobr>
<span class="list_menu_item">{include file='workflow/checkall.tpl' form_name="`$form_name`_delete" elem_name="pids[]"}</span>
{capture name='grn_workflow_GRN_WKF_4'}{cb_msg module='grn.workflow' key='GRN_WKF_4' replace='true'}{/capture}
<span class="list_menu_item">{grn_button_submit caption=$smarty.capture.grn_workflow_GRN_WKF_4 id="btn_delete_multi1" onclick="return false;"}</span>
</nobr></div>
<table class="list_column">
 <colgroup>
  <col width="5%">
  <col width="11%">
  <col width="5%">
  <col width="20%">
  <col width="20%">
  <col width="12%">
  <col width="15%">
  <col width="12%">
 </colgroup>
 <tr>
  <th nowrap></th>
  <th nowrap>{cb_msg module='grn.workflow' key='item_type_0' replace='true'}</th>
  <th nowrap>
  {if $sort == 'pnu'}
      {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_id sort='pnd' sf=1 sp=0 reverse=1}
  {elseif  $sort == 'pnd'}
      {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_id sort='pnu' sf=1 sp=0}
  {else}
      {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_id sort='pnd' sf=1 sp=0 disable=1}
  {/if}
  </th>
  <th nowrap>
  {if $sort == 'fnu'}
      {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_id sort='fnd' sf=1 sp=0 reverse=1}
  {elseif  $sort == 'fnd'}
      {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_id sort='fnu' sf=1 sp=0}
  {else}
      {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_id sort='fnd' sf=1 sp=0 disable=1}
  {/if}
  </th>
  <th nowrap>{cb_msg module='grn.workflow' key='form_subject' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow' key='item_type_3' replace='true'}</th>
  <th nowrap>{if $folder.folder_type == GRN_WORKFLOW_FOLDER_TYPE_OUT_ID}{cb_msg module='grn.workflow' key='processor' replace='true'}{else}{cb_msg module='grn.workflow' key='item_type_5' replace='true'}{/if}</th>
  <th nowrap>
  {if $sort == 'ctu'}
      {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_id sort='ctd' sf=1 sp=0 reverse=1}
  {elseif $sort == 'ctd'}
      {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_id sort='ctu' sf=1 sp=0}
  {else}
      {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_id sort='ctd' sf=1 sp=0 disable=1}
  {/if}
  </th>
 </tr>
 {foreach from=$petition_list item=petition}
 <tr>
  <td nowrap>{if GRN_WORKFLOW_FOLDER_TYPE_OUT_ID == $folder.folder_type}{if (GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL == $petition.status && $petition.cancel_confirm) || GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL == $petition.status || GRN_WORKFLOW_STATUS_FINISHED == $petition.status || GRN_WORKFLOW_STATUS_REJECTION == $petition.status}<input type="checkbox" name="pids[]" value="{$petition.pid|escape}">{/if}{else}<input type="checkbox" name="pids[]" value="{$petition.pid|escape}">{/if}</td>
  <td nowrap>{$petition.petition_number|escape}</td>
  <td nowrap>{grn_workflow_priority value=$petition.priority mode="view_list"}</td>
  {if $folder_id == GRN_WORKFLOW_FOLDER_PROXY_APPROVAL_ID}
  <td nowrap><nobr>{grn_workflow_link page='workflow/view' caption="`$petition.form_name`" truncated_caption=$subject_width_fix icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url fid=$petition.folder pid=$petition.pid}</nobr></td>
  <td nowrap><nobr>{grn_workflow_link page='workflow/view' caption="`$petition.name`" truncated_caption=$subject_width fid=$petition.folder pid=$petition.pid}</nobr></td>
  {else}
  <td nowrap><nobr>{grn_workflow_link page='workflow/view' caption="`$petition.form_name`" truncated_caption=$subject_width_fix icon_type=$petition.icon_type icon_id=$petition.icon_id icon_url=$petition.icon_url fid=$folder_id pid=$petition.pid}</nobr></td>
  <td nowrap><nobr>{grn_workflow_link page='workflow/view' caption="`$petition.name`" truncated_caption=$subject_width fid=$folder_id pid=$petition.pid}</nobr></td>
  {/if}
  <td nowrap>
  {if $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING || $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS || $petition.status == GRN_WORKFLOW_STATUS_REMAND}{* 未処理/進行中/差し戻し *}
   <span class="wf_petition_status_highlight"><span class="progress">{cb_msg module='grn.workflow' key='view_status_0' replace='true'}</span></span>
  {elseif $petition.status == GRN_WORKFLOW_STATUS_ACCEPTANCE}
   <span class="wf_petition_status_highlight"><span class="ok">{cb_msg module='grn.workflow' key='view_status_1' replace='true'}</span></span>
  {elseif $petition.status == GRN_WORKFLOW_STATUS_REJECTION}
   <span class="wf_petition_status_highlight"><span class="decline">{cb_msg module='grn.workflow' key='view_status_2' replace='true'}</span></span>
  {elseif $petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL || $petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL}{* 取り消し/取り戻し *}
   <span class="wf_petition_status_highlight"><span class="deletion">{cb_msg module='grn.workflow' key='view_status_3' replace='true'}</span></span>
  {elseif $petition.status == GRN_WORKFLOW_STATUS_FINISHED}
   <span class="wf_petition_status_highlight"><span class="finished">{cb_msg module='grn.workflow' key='view_status_4' replace='true'}</span></span>
  {/if}
  </td>
  {if $folder.folder_type == GRN_WORKFLOW_FOLDER_TYPE_OUT_ID}
  {* 送信一覧 *}
  <td nowrap>
   {if $petition.status == GRN_WORKFLOW_STATUS_REJECTION}
   {* 却下の場合（却下したを表示） *}
    {grn_user_name uid=$petition.transactor_id name=$petition.transactor_name  truncated=$name_width valid=$petition.transactor_valid users_info=$users_info}
   {else}
    {foreach from=$petition.transactor item=user}
     {grn_user_name uid=$user.col_user name=$user.col_display_name name=$user.col_display_name truncated=$name_width valid=$user.col_valid users_info=$users_info}
    {foreachelse}
{cb_msg module='grn.workflow' key='pass_along_only_bracket' replace='true'}
    {/foreach}
    {if $petition.transactor_num > $show_user_num},{cb_msg module='grn.workflow' key='three_dots' replace='true'}{/if}
   {/if}
  </td>
  {else}
 {* 受信一覧 *}
  <td nowrap>{grn_user_name uid=$petition.user name=$petition.user_name  truncated=$name_width valid=$petition.user_valid users_info=$users_info}</td>
  {/if}
  <td nowrap>{grn_date_format date=$petition.ctime}</td>
 </tr>
 {/foreach}
</table>
{grn_delete title=$delete_info_multi.title page=$delete_info_multi.page no_confirm=$delete_info_multi.no_confirm data=$delete_info_multi.data handler=$delete_info_multi.handler multi_target=$delete_info_multi.multi_target form_target=$delete_info_multi.form_target}
<div class="list_menu"><nobr><span class="list_menu_item">{include file='workflow/checkall.tpl' form_name="`$form_name`_delete" elem_name="pids[]"}</span><span class="list_menu_item">{capture name='grn_workflow_GRN_WKF_4'}{cb_msg module='grn.workflow' key='GRN_WKF_4' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_GRN_WKF_4 id="btn_delete_multi2" onclick="return false;"}</span>
</nobr></div>
<div class="navi"><nobr>{include file='grn/word_navi.tpl' navi=$navi.navi}</nobr></div>
<input type="hidden" name="fid" value="{$folder.fid|escape}">
</form>
{/if}
{else}
{* 未処理一覧 *}
<div class="sub_title">{cb_msg module='grn.workflow' key='search_result_of_1' replace='true'}{$folder_list.unprocessed_folder.name|escape}{cb_msg module='grn.workflow' key='search_result_of_2' replace='true'} {include file="grn/smart_data_count_310.tpl" start_num=$unprocessed_navi.start_count end_num=$unprocessed_navi.end_count}</div>
<div class="navi"><nobr>{include file='grn/word_multi_navi.tpl' navi=$unprocessed_navi.navi}</nobr></div>
<table class="list_column">
 <colgroup>
  <col width="16%">
  <col width="5%">
  <col width="20%">
  <col width="20%">
  <col width="13%">
  <col width="16%">
  <col width="16%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.workflow' key='item_type_0' replace='true'}</th>
  <th nowrap>
  {if $sort == 'pnu'}
      {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_id sort='pnd' sort_result=$sort_result sf=1 sp=0 reverse=1}
  {elseif  $sort == 'pnd'}
      {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_id sort='pnu' sort_result=$sort_result sf=1 sp=0}
  {else}
      {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_id sort='pnd' sort_result=$sort_result sf=1 sp=0 disable=1}
  {/if}
  </th>
  <th nowrap>
  {if $sort == 'fnu'}
      {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_id sort='fnd' sort_result=$sort_result sf=1 sp=0 reverse=1}
  {elseif  $sort == 'fnd'}
      {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_id sort='fnu' sort_result=$sort_result sf=1 sp=0}
  {else}
      {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_id sort='fnd' sort_result=$sort_result sf=1 sp=0 disable=1}
  {/if}
  </th>
  <th nowrap>{cb_msg module='grn.workflow' key='form_subject' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow' key='item_type_3' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow' key='item_type_5' replace='true'}</th>
  <th nowrap>
  {if $sort == 'ctu'}
      {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_id sort='ctd' sort_result=$sort_result sf=1 sp=0 reverse=1}
  {elseif $sort == 'ctd'}
      {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_id sort='ctu' sort_result=$sort_result sf=1 sp=0}
  {else}
      {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_id sort='ctd' sort_result=$sort_result sf=1 sp=0 disable=1}
  {/if}
  </th>
 </tr>
 {foreach from=$unprocessed_petition_list item=unprocessed_petition}
 <tr>
  <td nowrap>{$unprocessed_petition.petition_number|escape}</td>
  <td nowrap>{grn_workflow_priority value=$unprocessed_petition.priority mode="view_list"}</td>
  <td nowrap><nobr>{grn_workflow_link page='workflow/handle' caption="`$unprocessed_petition.form_name`" truncated_caption=$subject_width_fix icon_type=$unprocessed_petition.icon_type icon_id=$unprocessed_petition.icon_id icon_url=$unprocessed_petition.icon_url fid=$folder_list.unprocessed_folder.fid pid=$unprocessed_petition.pid}</nobr></td>
  <td nowrap><nobr>{grn_workflow_link page='workflow/handle' caption="`$unprocessed_petition.name`" truncated_caption=$subject_width fid=$folder_list.unprocessed_folder.fid pid=$unprocessed_petition.pid}</nobr></td>
  <td nowrap>
  {if $unprocessed_petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING || $unprocessed_petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS || $unprocessed_petition.status == GRN_WORKFLOW_STATUS_REMAND}{* 未処理/進行中/差し戻し *}
   <span class="wf_petition_status_highlight"><span class="progress">{cb_msg module='grn.workflow' key='view_status_0' replace='true'}</span></span>
  {elseif $unprocessed_petition.status == GRN_WORKFLOW_STATUS_ACCEPTANCE}
   <span class="wf_petition_status_highlight"><span class="ok">{cb_msg module='grn.workflow' key='view_status_1' replace='true'}</span></span>
  {elseif $unprocessed_petition.status == GRN_WORKFLOW_STATUS_REJECTION}
   <span class="wf_petition_status_highlight"><span class="decline">{cb_msg module='grn.workflow' key='view_status_2' replace='true'}</span></span>
  {elseif $unprocessed_petition.status == GRN_WORKFLOW_STATUS_IN_PROCESS_CANCEL || $unprocessed_petition.status == GRN_WORKFLOW_STATUS_UNPROCESSING_CANCEL}{* 取り消し/取り戻し *}
   <span class="wf_petition_status_highlight"><span class="deletion">{cb_msg module='grn.workflow' key='view_status_3' replace='true'}</span></span>
  {elseif $unprocessed_petition.status == GRN_WORKFLOW_STATUS_FINISHED}
   <span class="wf_petition_status_highlight"><span class="finished">{cb_msg module='grn.workflow' key='view_status_4' replace='true'}</span></span>
  {/if}
  </td>
  <td nowrap>{grn_user_name uid=$unprocessed_petition.user name=$unprocessed_petition.user_name  truncated=$name_width valid=$unprocessed_petition.user_valid users_info=$users_info}</td>
  <td nowrap>{grn_date_format date=$unprocessed_petition.ctime}</td>
 </tr>
 {/foreach}
</table>
<div class="navi"><nobr>{include file='grn/word_multi_navi.tpl' navi=$unprocessed_navi.navi}</nobr></div>

<div style="line-height:0.5em;">&nbsp;</div>

{* 結果一覧 *}
{grn_delete title=$delete_info_multi_finish.title page=$delete_info_multi_finish.page no_confirm=$delete_info_multi_finish.no_confirm data=$delete_info_multi_finish.data handler=$delete_info_multi_finish.handler multi_target=$delete_info_multi_finish.multi_target form_target=$delete_info_multi_finish.form_target}
<div class="sub_title">{cb_msg module='grn.workflow' key='search_result_of_1' replace='true'}{$folder_list.finish_folder.name|escape}{cb_msg module='grn.workflow' key='search_result_of_2' replace='true'} {include file="grn/smart_data_count_310.tpl" start_num=$finish_navi.start_count end_num=$finish_navi.end_count}</div>
<div class="navi"><nobr>{include file='grn/word_multi_navi.tpl' navi=$finish_navi.navi}</nobr></div>
<form name="{$form_name}_delete" method="post" action="{grn_pageurl page='workflow/delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div class="list_menu"><nobr>
<span class="list_menu_item">{include file='workflow/checkall.tpl' form_name="`$form_name`_delete" elem_name="pids[]"}</span>
<span class="list_menu_item">{capture name='grn_workflow_GRN_WKF_4'}{cb_msg module='grn.workflow' key='GRN_WKF_4' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_GRN_WKF_4 id="btn_delete_multi_finish1" onclick="return false;"}</span>
</nobr></div>
<table class="list_column">
 <colgroup>
  <col width="5%">
  <col width="11%">
  <col width="5%">
  <col width="20%">
  <col width="20%">
  <col width="13%">
  <col width="16%">
  <col width="16%">
 </colgroup>
 <tr>
  <th nowrap></th>
  <th nowrap>{cb_msg module='grn.workflow' key='item_type_0' replace='true'}</th>
{*
  <th nowrap>{cb_msg module='grn.workflow' key='priority' replace='true'}</th>
*}
  <th nowrap>
  {if $sort_result == 'prnu'}
      {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_id sort=$sort sort_result='prnd' sf=1 sp=0 reverse=1}
  {elseif  $sort_result == 'prnd'}
      {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_id sort=$sort sort_result='prnu' sf=1 sp=0}
  {else}
      {capture name='grn_workflow_priority'}{cb_msg module='grn.workflow' key='priority' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_priority page=$page_info.all fid=$folder_id sort=$sort sort_result='prnd' sf=1 sp=0 disable=1}
  {/if}
  </th>
{*
  <th nowrap>{cb_msg module='grn.workflow' key='application_form_name' replace='true'}</th>
*}
  <th nowrap>
  {if $sort_result == 'frnu'}
      {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_id sort=$sort sort_result='frnd' sf=1 sp=0 reverse=1}
  {elseif  $sort_result == 'frnd'}
      {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_id sort=$sort sort_result='frnu' sf=1 sp=0}
  {else}
      {capture name='grn_workflow_application_form_name'}{cb_msg module='grn.workflow' key='application_form_name' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_application_form_name page=$page_info.all fid=$folder_id sort=$sort sort_result='frnd' sf=1 sp=0 disable=1}
  {/if}
  </th>
  <th nowrap>{cb_msg module='grn.workflow' key='form_subject' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow' key='result' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.workflow' key='accepted_rejected' replace='true'}</th>
{*
  <th nowrap>{cb_msg module='grn.workflow' key='item_type_4' replace='true'}</th>
*}
  <th nowrap>
  {if $sort_result == 'crtu'}
      {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_id sort=$sort sort_result='crtd' sf=1 sp=0 reverse=1}
  {elseif $sort_result == 'crtd'}
      {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_id sort=$sort sort_result='crtu' sf=1 sp=0}
  {else}
      {capture name='grn_workflow_item_type_4'}{cb_msg module='grn.workflow' key='item_type_4' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_workflow_item_type_4 page=$page_info.all fid=$folder_id sort=$sort sort_result='crtd' sf=1 sp=0 disable=1}
  {/if}
  </th>
 </tr>
  {foreach from=$finish_petition_list item=finish_petition}
 <tr>
  <td nowrap><input type="checkbox" name="pids[]" value="{$finish_petition.pid}"></td>
  <td nowrap>{$finish_petition.petition_number|escape}</td>
  <td nowrap>{grn_workflow_priority value=$finish_petition.priority mode="view_list"}</td>
  <td nowrap><nobr>{grn_workflow_link page='workflow/view' caption="`$finish_petition.form_name`" truncated_caption=$subject_width_fix icon_type=$finish_petition.icon_type icon_id=$finish_petition.icon_id icon_url=$finish_petition.icon_url fid=$folder_list.finish_folder.fid pid=$finish_petition.pid}</nobr></td>
  <td nowrap><nobr>{grn_workflow_link page='workflow/view' caption="`$finish_petition.name`" truncated_caption=$subject_width fid=$folder_list.finish_folder.fid pid=$finish_petition.pid}</nobr></td>
  <td nowrap>
   {if $finish_petition.status == GRN_WORKFLOW_STATUS_ACCEPTANCE}
   <span class="wf_petition_status_highlight"><span class="ok">{cb_msg module='grn.workflow' key='view_status_1' replace='true'}</span></span>
   {elseif $finish_petition.status == GRN_WORKFLOW_STATUS_REJECTION}
   <span class="wf_petition_status_highlight"><span class="decline">{cb_msg module='grn.workflow' key='view_status_2' replace='true'}</span></span>
   {elseif $finish_petition.status == GRN_WORKFLOW_STATUS_FINISHED}
   <span class="wf_petition_status_highlight"><span class="finished">{cb_msg module='grn.workflow' key='view_status_4' replace='true'}</span></span>
   {/if}
  </td>
  <td nowrap>
   {if $finish_petition.status == GRN_WORKFLOW_STATUS_REJECTION}
    {grn_user_name uid=$finish_petition.transactor_id name=$finish_petition.transactor_name  truncated=$name_width valid=$finish_petition.transactor_valid users_info=$users_info}
   {else}
    {foreach from=$finish_petition.transactor item=user}
     {grn_user_name uid=$user.col_user name=$user.col_display_name  truncated=$name_width valid=$user.col_valid users_info=$users_info}
    {foreachelse}
{cb_msg module='grn.workflow' key='pass_along_only_bracket' replace='true'}
    {/foreach}
    {if $finish_petition.transactor_num > $show_user_num}<span class="multiple_username"><span class="comma">,</span><span class="dots">{cb_msg module='grn.workflow' key='three_dots' replace='true'}</span></span>{/if}
   {/if}
  </td>
  <td nowrap>{grn_date_format date=$finish_petition.ctime}</td>
 </tr>
  {/foreach}
</table>
<div class="list_menu"><nobr>
<span class="list_menu_item">{include file='workflow/checkall.tpl' form_name="`$form_name`_delete" elem_name="pids[]"}</span>
<span class="list_menu_item">{capture name='grn_workflow_GRN_WKF_4'}{cb_msg module='grn.workflow' key='GRN_WKF_4' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_workflow_GRN_WKF_4 id="btn_delete_multi_finish2" onclick="return false;"}</span>
</nobr></div>
<div class="navi"><nobr>{include file='grn/word_multi_navi.tpl' navi=$finish_navi.navi}</nobr></div>
<input type="hidden" name="fid" value="{$folder_list.finish_folder.fid|escape}">
</form>
{/if}
</td></tr></tbody></table><!--end of maincontents_list-->

{include file="grn/footer.tpl"}

{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/form_disable.js"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/logging/search'}">

<table class="std_form">
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.logging' key='GRN_SY_LO-17' replace='true'}
  </th>
  <td>
      {grn_text necessary=true name="search_text" value=$search_text size="50"}&nbsp;{capture name='grn_system_logging_GRN_SY_LO_18'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-18' replace='true'}{/capture}{grn_button_submit caption=$smarty.capture.grn_system_logging_GRN_SY_LO_18}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.logging' key='GRN_SY_LO-19' replace='true'}
  </th>
  <td>
       {capture name='grn_system_logging_GRN_SY_LO_20'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-20' replace='true'}{/capture}{capture name='grn_system_logging_GRN_SY_LO_21'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-21' replace='true'}{/capture}{grn_select_hierarchy name='category' hierarchy=$categories padding=$smarty.capture.grn_system_logging_GRN_SY_LO_20 mark=$smarty.capture.grn_system_logging_GRN_SY_LO_21}
  </td>
 </tr>
 <tr>
   <th nowrap>
     {cb_msg module='grn.system.logging' key='GRN_SY_LO-22' replace='true'}
   </th>
   <td>
       {grn_select name='priority' options=$priorities }
   </td>
 </tr>
 <tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.system.logging' key='GRN_SY_LO-23' replace='true'}
  </th>
  <td>
  {if $all}
       {capture name='grn_system_logging_GRN_SY_LO_24'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-24' replace='true'}{/capture}{grn_radio name='all' id='all1' value='1' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_24 checked=TRUE onclick="setDisableById(d, 'start_year:start_month:start_day:end_year:end_month:end_day', 'on')"}<br>
       {capture name='grn_system_logging_GRN_SY_LO_25'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-25' replace='true'}{/capture}{grn_radio name='all' id='all2' value='0' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_25 onclick="setDisableById(d, 'start_year:start_month:start_day:end_year:end_month:end_day', 'off')"}<br>
  {else}
       {capture name='grn_system_logging_GRN_SY_LO_26'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-26' replace='true'}{/capture}{grn_radio name='all' id='all1' value='1' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_26 onclick="setDisableById(d, 'start_year:start_month:start_day:end_year:end_month:end_day', 'on')"}<br>
       {capture name='grn_system_logging_GRN_SY_LO_27'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-27' replace='true'}{/capture}{grn_radio name='all' id='all2' value='0' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_27 checked=TRUE onclick="setDisableById(d, 'start_year:start_month:start_day:end_year:end_month:end_day', 'off')"}<br>
  {/if}
       {grn_select_date prefix='start_' date=$start_date form_name=$form_name necessary=true}{cb_msg module='grn.system.logging' key='GRN_SY_LO-28' replace='true'}{grn_select_date prefix='end_' date=$end_date form_name=$form_name necessary=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.system.logging' key='GRN_SY_LO-29' replace='true'}
  </th>
  <td>
{capture name='grn_system_logging_GRN_SY_LO_30'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-30' replace='true'}{/capture}{grn_checkbox name="search_keys[]" id="msg" value="col_msg"
     checked=$search_keys.col_msg caption=$smarty.capture.grn_system_logging_GRN_SY_LO_30}
{capture name='grn_system_logging_GRN_SY_LO_31'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-31' replace='true'}{/capture}{grn_checkbox name="search_keys[]" id="user" value="col_user"
     checked=$search_keys.col_user caption=$smarty.capture.grn_system_logging_GRN_SY_LO_31}
{capture name='grn_system_logging_GRN_SY_LO_32'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-32' replace='true'}{/capture}{grn_checkbox name="search_keys[]" id="account" value="col_account"
     checked=$search_keys.col_account caption=$smarty.capture.grn_system_logging_GRN_SY_LO_32}
{capture name='grn_system_logging_GRN_SY_LO_33'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-33' replace='true'}{/capture}{grn_checkbox name="search_keys[]" id="remote_host" value="col_remote_host"
     checked=$search_keys.col_remote_host caption=$smarty.capture.grn_system_logging_GRN_SY_LO_33}
{capture name='grn_system_logging_GRN_SY_LO_34'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-34' replace='true'}{/capture}{grn_checkbox name="search_keys[]" id="remote_addr" value="col_remote_addr"
     checked=$search_keys.col_remote_addr caption=$smarty.capture.grn_system_logging_GRN_SY_LO_34}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_logging_GRN_SY_LO_35'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-35' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_logging_GRN_SY_LO_35}
  </td>
 </tr>
</table>

   <hr>
   <h2 class="sub_title">{cb_msg module='grn.system.logging' key='GRN_SY_LO-36' replace='true'} {include file="grn/smart_data_count.tpl" start_num=$navi_for_view.start_count end_num=$navi_for_view.end_count all_num=$navi_for_view.count}</h2>
   <table class="list_column" width="100%" border="1" cellspacing="0" cellpadding="2">
    <colgroup>
     <col width="15%">
     <col width="15%">
     <col width="15%">
     <col width="55%">
    </colgroup>
    <tr>
     {if $sort == 'du'}
     <th nowrap>{capture name='grn_system_logging_GRN_SY_LO_39'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-39' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_system_logging_GRN_SY_LO_39 page=$page_info.all sort='dd' sp=0 sf=1 reverse=1}</th>
     {else}
      {if $sort == 'dd'}
     <th nowrap>{capture name='grn_system_logging_GRN_SY_LO_40'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-40' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_system_logging_GRN_SY_LO_40 page=$page_info.all sort='du' sp=0 sf=1}</th>
      {else}
     <th nowrap>{capture name='grn_system_logging_GRN_SY_LO_41'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-41' replace='true'}{/capture}{grn_title_sort title=$smarty.capture.grn_system_logging_GRN_SY_LO_41 page=$page_info.all sort='dd' sp=0 sf=1 disable=1}</th>
      {/if}
     {/if}
     <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-42' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-43' replace='true'}</th>
     <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-44' replace='true'}</th>
    </tr>
{foreach from=$logs key=id item=log}
    <tr valign="top">
     <td nowrap>{$log.date|escape}</td>
     <td>{$log.category_msg|escape}</td>
     <td>
     {if $log.priority == 10}{cb_msg module='grn.system.logging' key='GRN_SY_LO-45' replace='true'}{/if}
     {if $log.priority == 9}{cb_msg module='grn.system.logging' key='GRN_SY_LO-46' replace='true'}{/if}
     {if $log.priority == 8}<b>{cb_msg module='grn.system.logging' key='GRN_SY_LO-47' replace='true'}</b>{/if}
     {if $log.priority == 6}<font color="green">{cb_msg module='grn.system.logging' key='GRN_SY_LO-48' replace='true'}</font>{/if}
     {if $log.priority == 4}<font color="red">{cb_msg module='grn.system.logging' key='GRN_SY_LO-49' replace='true'}</font>{/if}
     {if $log.priority == 2}<b><font color="red">{cb_msg module='grn.system.logging' key='GRN_SY_LO-50' replace='true'}</font></b>{/if}
     </td>
     {capture name=_msg}{$log.msg|cb_mb_truncate:100}{/capture}
     <td>{grn_link page='system/logging/view' caption=$smarty.capture._msg priority=$selected.priority category=$selected.category lid=$id}</td>
    </tr>
{/foreach}
   </table>
     <div class="contents_navi">
      {include file="grn/word_navi.tpl" navi=$navi_for_view.navi}
     </div>

<input type="hidden" name="optional_search" value="1">
</form>

<script language="JavaScript">
<!--
    var d = document.forms["{$form_name}"];
    window.onload = function(){literal}{{/literal}if(d.elements['all'][0].checked) setDisableById(d, 'start_year:start_month:start_day:end_year:end_month:end_day', 'on');{literal}}{/literal}
//-->
</script>

{include file="grn/system_footer.tpl"}

{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{grn_load_javascript file="grn/html/form_disable.js"}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/logging/command_'|cat:$page_info.last postfix='log.csv'}">
<input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<table class="std_form">
 <tr>
  <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-67' replace='true'}</th>
  <td>
   <select name='category'>
   <option value="">{cb_msg module='grn.system.logging' key='GRN_SY_LO-68' replace='true'}</option>
   {foreach from=$categories item=item}
    {foreach from=$item.child item=child}
     {if $child.selected}
   <option value="{$child.value|escape}" selected>{$child.label|escape}</option>
     {else}
   <option value="{$child.value|escape}">{$child.label|escape}</option>
     {/if}
    {/foreach}
   {/foreach}
   </select>
   {* grn_select_hierarchy name='category' hierarchy=$categories padding='　' mark='┗' *}
  </td>
 </tr>
  <tr>
   <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-69' replace='true'}</th>
   <td>
       {grn_select name='priority' options=$priorities }
   </td>
 </tr>
 <tr valign="top">
  <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-70' replace='true'}</th>
  <td>
       {capture name='grn_system_logging_GRN_SY_LO_71'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-71' replace='true'}{/capture}{grn_radio name='all' id='all1' value='1' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_71 checked=TRUE onclick="setDisableById(d, 'start_year:start_month:start_day:end_year:end_month:end_day', 'on')"}<br>
       {capture name='grn_system_logging_GRN_SY_LO_72'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-72' replace='true'}{/capture}{grn_radio name='all' id='all2' value='0' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_72 onclick="setDisableById(d, 'start_year:start_month:start_day:end_year:end_month:end_day', 'off')"}<br>
       {grn_select_date prefix='start_' date=$stime form_name=$form_name necessary=true}{cb_msg module='grn.system.logging' key='GRN_SY_LO-73' replace='true'}{grn_select_date prefix='end_' date=$etime form_name=$form_name necessary=true}
  </td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-74' replace='true'}</th>
  <td>{grn_charset name='charset' bom='TRUE'}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.system.logging' key='GRN_SY_LO-75' replace='true'}</th>
  <td>
      {capture name='grn_system_logging_GRN_SY_LO_76'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-76' replace='true'}{/capture}{grn_radio name='title' id='title0' value='1' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_76 checked=false}&nbsp;{capture name='grn_system_logging_GRN_SY_LO_77'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-77' replace='true'}{/capture}{grn_radio name='title' id='title1' value='0' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_77 checked=true}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_system_logging_GRN_SY_LO_78'}{cb_msg module='grn.system.logging' key='GRN_SY_LO-78' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_system_logging_GRN_SY_LO_78}
       {grn_button_cancel class='margin' page='system/common_list' id='logging'}
  </td>
 </tr>
</table>

</form>

<script language="JavaScript">
<!--
    var d = document.forms["{$form_name}"];
    window.onload = function(){literal}{{/literal}if(d.elements['all'][0].checked) setDisableById(d,'start_year:start_month:start_day:end_year:end_month:end_day','on');{literal}}{/literal}
//-->
</script>

<hr>
<p>
{include file='system/logging/_csv_columns.tpl'}
{include file='grn/csv_columns.tpl' column_explanation=$smarty.capture.explanation type='export'}
{include file='grn/system_footer.tpl'}

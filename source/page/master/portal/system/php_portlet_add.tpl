{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.portal.system' key='GRN_POT_SY-353' replace='true'}</div>

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_portal_system_GRN_POT_SY_354'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-354' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_system_GRN_POT_SY_354 necessary=false}
  </th>
  <td>
      {capture name='grn_portal_system_GRN_POT_SY_355'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-355' replace='true'}{/capture}
      {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_portal_system_GRN_POT_SY_355 values=$multiLanguageInfoArray.values}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-356' replace='true'}
  </th>
  <td>
       <select name="portlet_group_select">
        <option value="">------
{foreach from=$portlet_group item=group}
 {if $portlet_group_select and $portlet_group_select == $group.plgid}
  {assign var="selected" value="selected"}
 {else}
  {assign var="selected" value=""}
 {/if}
         <option value="{$group.plgid}" {$selected}>{$group.title|escape}
{/foreach}
       </select>
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-357' replace='true'}
  </th>
  <td>
{if $checkbox || $is_new_porlet_add}
 {assign var="checked" value=1}
{else}
 {assign var="checked" value=0}
{/if}
      {capture name='grn_portal_system_GRN_POT_SY_358'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-358' replace='true'}{/capture}{grn_checkbox name="checkbox" id="0" value="1" checked=$checked caption=$smarty.capture.grn_portal_system_GRN_POT_SY_358}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {capture name='grn_portal_system_GRN_POT_SY_359'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-359' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_system_GRN_POT_SY_359 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_portal_system_GRN_POT_SY_360'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-360' replace='true'}{/capture}{validate form=$form_name field="data" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_portal_system_GRN_POT_SY_360 append="validation_errors"}{grn_textarea name="data" value=$data cols=$editor.cols rows=$editor.rows}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_portal_system_GRN_POT_SY_361'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-361' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_361}
       {grn_button_cancel page='portal/system/php_portlet_list'}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}

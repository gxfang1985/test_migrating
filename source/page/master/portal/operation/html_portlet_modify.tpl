{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/operation/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.portal.operation' key='GRN_POT_OP-48' replace='true'}</div>

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_portal_operation_GRN_POT_OP_49'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-49' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_operation_GRN_POT_OP_49 necessary=false}
  </th>
  <td>
      {capture name='grn_portal_operation_GRN_POT_OP_50'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-50' replace='true'}{/capture}
      {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_portal_operation_GRN_POT_OP_50 values=$multiLanguageInfoArray.values}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.operation' key='GRN_POT_OP-51' replace='true'}
  </th>
  <td>
       <select name="portlet_group">
        {foreach from=$portlet_group item=group}
         {if $group.plgid eq $portlet.plgid}
          <option value="{$group.plgid}" selected>{$group.title|escape}
         {else}
          <option value="{$group.plgid}">{$group.title|escape}
         {/if}
        {/foreach}
       </select>
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.personal' key='GRN_POT_PE-167' replace='true'}{$app_name|escape}
  </th>
  <td>
      {capture name='grn_portal_operation_GRN_POT_OP_226'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-226' replace='true'}{/capture}{grn_checkbox name="checkbox" id="0" value="1" checked=$portlet.my_portal caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_226}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {capture name='grn_portal_operation_GRN_POT_OP_53'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-53' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_operation_GRN_POT_OP_53 necessary=TRUE}
  </th>
  <td>
{capture name='grn_portal_operation_GRN_POT_OP_54'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-54' replace='true'}{/capture}{validate form=$form_name field="data" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_portal_operation_GRN_POT_OP_54 append="validation_errors"}
{include file="grn/richeditor.tpl" name="data" text=$portlet.text html=$portlet.html cols=$richeditor.cols rows=$richeditor.rows enable=1 settings=1 class="form_textarea_grn"}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       <input class="margin" type="submit" value="{cb_msg module='grn.portal.operation' key='GRN_POT_OP-55' replace='true'}">
      {grn_button_cancel page='portal/operation/html_portlet_view' plid=$portlet.plid}
  </td>
 </tr>
</table>

<input type="hidden" name="refresh" value="">
<input type="hidden" name="plid" value="{$portlet.plid}">
</form>
{include file='grn/footer.tpl'}

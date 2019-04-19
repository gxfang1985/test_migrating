{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/personal/command_'|cat:$page_info.last}"  enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.portal.personal' key='GRN_POT_PE-22' replace='true'}</div>

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_portal_personal_GRN_POT_PE_23'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-23' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_personal_GRN_POT_PE_23 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_portal_personal_GRN_POT_PE_24'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-24' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_portal_personal_GRN_POT_PE_24 append="validation_errors"}{grn_text necessary=true name="title" value=$portlet.title size="50" disable_return_key=true}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.personal' key='GRN_POT_PE-25' replace='true'}
  </th>
  <td>
       <select name="portlet_group_select">
        <option value="">------
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
 <tr valign="top">
  <th nowrap>
      {capture name='grn_portal_personal_GRN_POT_PE_26'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-26' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_personal_GRN_POT_PE_26 necessary=TRUE}
  </th>
  <td>
{capture name='grn_portal_personal_GRN_POT_PE_27'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-27' replace='true'}{/capture}{validate form=$form_name field="data" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_portal_personal_GRN_POT_PE_27 append="validation_errors"}
{include file="grn/richeditor.tpl" name="data" text=$portlet.text html=$portlet.html cols=$richeditor.cols rows=$richeditor.rows enable=1 class="form_textarea_grn"}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       <input class="margin" type="submit" value="{cb_msg module='grn.portal.personal' key='GRN_POT_PE-28' replace='true'}">
      {grn_button_cancel page='portal/personal/html_portlet_view' plid=$portlet.plid}
  </td>
 </tr>
</table>

<input type="hidden" name="refresh" value="">
<input type="hidden" name="plid" value="{$portlet.plid}">
</form>
{include file='grn/personal_footer.tpl'}

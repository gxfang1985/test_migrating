{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/personal/command_'|cat:$page_info.last}" enctype="multipart/form-data"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<div class="explanation">{cb_msg module='grn.portal.personal' key='GRN_POT_PE-105' replace='true'}</div>

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>{capture name='grn_portal_personal_GRN_POT_PE_106'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-106' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_personal_GRN_POT_PE_106 necessary=TRUE}</th>
  <td>{capture name='grn_portal_personal_GRN_POT_PE_107'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-107' replace='true'}{/capture}{validate form=$form_name field="title" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_portal_personal_GRN_POT_PE_107 append="validation_errors"}{grn_text necessary=true name="title" value=$title size="50" disable_return_key=true}</td>
 </tr>
 <tr>
  <th nowrap>{cb_msg module='grn.portal.personal' key='GRN_POT_PE-108' replace='true'}</th>
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
 <tr valign="top">
  <th nowrap>{capture name='grn_portal_personal_GRN_POT_PE_109'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-109' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_personal_GRN_POT_PE_109 necessary=TRUE}</th>
  <td>
{capture name='grn_portal_personal_GRN_POT_PE_110'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-110' replace='true'}{/capture}{validate form=$form_name field="data" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_portal_personal_GRN_POT_PE_110 append="validation_errors"}
{include file="grn/richeditor.tpl" name="data" html=$html text=$text cols=$richeditor.cols rows=$richeditor.rows enable=1 class="form_textarea_grn"}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       <input class="margin" type="submit" value="{cb_msg module='grn.portal.personal' key='GRN_POT_PE-111' replace='true'}">
       {grn_button_cancel page='portal/personal/html_portlet_list'}
  </td>
 </tr>
</table>

</form>

{include file='grn/personal_footer.tpl'}

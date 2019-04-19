{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="plid" value="{$portlet.plid}">

<div class="explanation">{cb_msg module='grn.portal.system' key='GRN_POT_SY-325' replace='true'}</div>

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_portal_system_GRN_POT_SY_326'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-326' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_system_GRN_POT_SY_326 necessary=false}
  </th>
  <td>
      {capture name='grn_portal_system_GRN_POT_SY_327'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-327' replace='true'}{/capture}
      {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_portal_system_GRN_POT_SY_327 values=$multiLanguageInfoArray.values}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-328' replace='true'}
  </th>
  <td>
       <select name="portlet_group">
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
 <tr>
  <th nowrap>
      {cb_msg module='grn.portal.system' key='GRN_POT_SY-329' replace='true'}
  </th>
  <td>
      {capture name='grn_portal_system_GRN_POT_SY_330'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-330' replace='true'}{/capture}{grn_checkbox name="checkbox" id="0" value="1" checked=$portlet.my_portal caption=$smarty.capture.grn_portal_system_GRN_POT_SY_330}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {capture name='grn_portal_system_GRN_POT_SY_331'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-331' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_portal_system_GRN_POT_SY_331 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_portal_system_GRN_POT_SY_332'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-332' replace='true'}{/capture}{validate form=$form_name field="data" criteria="notEmpty" transform="cb_trim" message=$smarty.capture.grn_portal_system_GRN_POT_SY_332 append="validation_errors"}{grn_textarea name="data" value=$portlet.data cols=$editor.cols rows=$editor.rows}
  </td>
 </tr>
 <tr>
  <td></td>
  <td>
       {capture name='grn_portal_system_GRN_POT_SY_333'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-333' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_333}
       {grn_button_cancel page='portal/system/php_portlet_view' plid=$portlet.plid}
  </td>
 </tr>
</table>

</form>

{include file='grn/system_footer.tpl'}

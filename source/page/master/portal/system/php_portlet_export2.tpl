{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title|cat:' - Step 2/2' class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last postfix='php_portlet.xml'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p>{cb_msg module='grn.portal.system' key='GRN_POT_SY-411' replace='true'}<span class="bold">{$export_item.export_numbers}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-412' replace='true'}</p>

<table class="list_column">
 <colgroup>
  <col width="40%">
  <col width="40%">
  <col width="20%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.portal.system' key='GRN_POT_SY-414' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.portal.system' key='GRN_POT_SY-415' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.portal.system' key='GRN_POT_SY-416' replace='true'}</th>
 </tr>
{foreach from=$portlet_list item=portlet}
 <tr>
  <td>{$portlet.name|escape}</td>
  <td>{$portlet.group|escape}</td>
  {if $portlet.available_myportal == 1}
  <td>{cb_msg module='grn.portal.system' key='GRN_POT_SY-417' replace='true'}</td>
  {else}
  <td>{cb_msg module='grn.portal.system' key='GRN_POT_SY-418' replace='true'}</td>
  {/if}
 </tr>
{/foreach}
</table>

{capture name='grn_portal_system_GRN_POT_SY_419'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-419' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_419 page='portal/system/php_portlet_export1' sf=1}
{capture name='grn_portal_system_GRN_POT_SY_420'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-420' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_420}
{capture name='grn_portal_system_GRN_POT_SY_421'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-421' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_system_GRN_POT_SY_421 page='portal/system/portlet_export_index'}

{foreach from=$export_item.portlet item=eid}
<input type="hidden" name="eid[]" value="{$eid}">
{/foreach}
</form>
{include file='grn/system_footer.tpl'}

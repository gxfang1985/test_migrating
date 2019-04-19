{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title|cat:' - Step 2/2' class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last postfix='html_portlet.xml'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p>{cb_msg module='grn.portal.system' key='GRN_POT_SY-400' replace='true'}<span class="bold">{$export_item.export_numbers}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-401' replace='true'}</p>

<table class="list_column">
 <colgroup>
  <col width="40%">
  <col width="40%">
  <col width="20%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.portal.system' key='GRN_POT_SY-403' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.portal.system' key='GRN_POT_SY-404' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.portal.system' key='GRN_POT_SY-405' replace='true'}</th>
 </tr>
{foreach from=$portlet_list item=portlet}
 <tr>
  <td>{$portlet.name|escape}</td>
  <td>{$portlet.group|escape}</td>
  {if $portlet.available_myportal == 1}
  <td>{cb_msg module='grn.portal.system' key='GRN_POT_SY-406' replace='true'}</td>
  {else}
  <td>{cb_msg module='grn.portal.system' key='GRN_POT_SY-407' replace='true'}</td>
  {/if}
 </tr>
{/foreach}
</table>

{capture name='grn_portal_system_GRN_POT_SY_408'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-408' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_408 page='portal/system/html_portlet_export1' sf=1}
{capture name='grn_portal_system_GRN_POT_SY_409'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-409' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_409}
{capture name='grn_portal_system_GRN_POT_SY_410'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-410' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_system_GRN_POT_SY_410 page='portal/system/portlet_export_index'}

{foreach from=$export_item.portlet item=eid}
<input type="hidden" name="eid[]" value="{$eid}">
{/foreach}
</form>
{include file='grn/system_footer.tpl'}

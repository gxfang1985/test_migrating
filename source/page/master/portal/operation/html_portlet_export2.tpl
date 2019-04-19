{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title|cat:' - Step 2/2' class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/operation/command_'|cat:$page_info.last postfix='html_portlet.xml'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-162' replace='true'}<span class="bold">{$export_item.export_numbers}</span>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-163' replace='true'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-164' replace='true'}</p>

<table class="list_column">
 <colgroup>
  <col width="40%">
  <col width="60%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-165' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-166' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-167' replace='true'}</th>
 </tr>
{foreach from=$portlet_list item=portlet}
 <tr>
  <td>{$portlet.name|escape}</td>
  <td>{$portlet.group|escape}</td>
  {if $portlet.available_myportal == 1}
  <td>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-168' replace='true'}</td>
  {else}
  <td>{cb_msg module='grn.portal.operation' key='GRN_POT_OP-169' replace='true'}</td>
  {/if}
 </tr>
{/foreach}
</table>

{capture name='grn_portal_operation_GRN_POT_OP_170'}<< {cb_msg module='grn.portal.operation' key='GRN_POT_OP-170' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_170 page='portal/operation/html_portlet_export1' sf=1}
{capture name='grn_portal_operation_GRN_POT_OP_171'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-171' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_171}
{capture name='grn_portal_operation_GRN_POT_OP_172'}{cb_msg module='grn.portal.operation' key='GRN_POT_OP-172' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_operation_GRN_POT_OP_172 page='portal/operation/html_portlet_list' sf=1}

{foreach from=$export_item.portlet item=eid}
<input type="hidden" name="eid[]" value="{$eid}">
{/foreach}
</form>
{include file='grn/footer.tpl'}
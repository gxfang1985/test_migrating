{include file="grn/personal_head.tpl"}
{include file="grn/personal_header.tpl"}
{grn_title title=$page_title|cat:' - Step 2/2' class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/personal/command_'|cat:$page_info.last postfix='html_portlet.xml'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p>{cb_msg module='grn.portal.personal' key='GRN_POT_PE-123' replace='true'}<span class="bold">{$export_item.export_numbers}</span>{cb_msg module='grn.portal.personal' key='GRN_POT_PE-124' replace='true'}</p>

<table class="list_column">
 <colgroup>
  <col width="40%">
  <col width="40%">
  <col width="20%">
 </colgroup>
 <tr>
  <th nowrap>{cb_msg module='grn.portal.personal' key='GRN_POT_PE-126' replace='true'}</th>
  <th nowrap>{cb_msg module='grn.portal.personal' key='GRN_POT_PE-127' replace='true'}</th>
 </tr>
{foreach from=$portlet_list item=portlet}
 <tr>
  <td>{$portlet.name|escape}</td>
  <td>{$portlet.group|escape}</td>
 </tr>
{/foreach}
</table>

{capture name='grn_portal_personal_GRN_POT_PE_128'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-128' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_128 page='portal/personal/html_portlet_export1' sf=1}
{capture name='grn_portal_personal_GRN_POT_PE_129'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-129' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_129}
{capture name='grn_portal_personal_GRN_POT_PE_130'}{cb_msg module='grn.portal.personal' key='GRN_POT_PE-130' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_personal_GRN_POT_PE_130 page='personal/application_list' app_id='portal'}

{foreach from=$export_item.portlet item=eid}
<input type="hidden" name="eid[]" value="{$eid}">
{/foreach}
</form>
{include file="grn/personal_footer.tpl"}

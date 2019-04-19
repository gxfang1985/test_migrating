{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.portal.system' key='GRN_POT_SY-101' replace='true'}<span class="bold">{$delete_item.delete_numbers}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-102' replace='true'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-103' replace='true'}</p>
 <p>
  {capture name='grn_portal_system_GRN_POT_SY_104'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-104' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_104}
  {capture name='grn_portal_system_GRN_POT_SY_105'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-105' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_system_GRN_POT_SY_105}
 </p>
{foreach from=$delete_item.portlet item=eid}
<input type="hidden" name="eid[]" value="{$eid}">
{/foreach}
</form>
{include file='grn/system_footer.tpl'}

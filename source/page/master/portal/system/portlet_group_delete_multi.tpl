{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.portal.system' key='GRN_POT_SY-475' replace='true'}<span class="bold">{$delete_item.delete_numbers}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-476' replace='true'}</p>
 <p>
  {capture name='grn_portal_system_GRN_POT_SY_477'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-477' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_477}
  {capture name='grn_portal_system_GRN_POT_SY_478'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-478' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_system_GRN_POT_SY_478}
 </p>
{foreach from=$delete_item.portlet_group item=eid}
 <input type="hidden" name="eid[]" value="{$eid}">
{/foreach}
</form>
{include file='grn/system_footer.tpl'}

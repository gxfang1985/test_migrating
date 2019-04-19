{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.portal.system' key='GRN_POT_SY-205' replace='true'}<span class="bold">{$portals.delete_numbers}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-206' replace='true'}</p>
 <p>
  {capture name='grn_portal_system_GRN_POT_SY_207'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-207' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_207}
  {capture name='grn_portal_system_GRN_POT_SY_208'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-208' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_portal_system_GRN_POT_SY_208}
 </p>
{foreach from=$portals.portal item=eid}
<input type="hidden" name="eid[]" value="{$eid}">
{/foreach}
</form>
{include file="grn/system_footer.tpl"}

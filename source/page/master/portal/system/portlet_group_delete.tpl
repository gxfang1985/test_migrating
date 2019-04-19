{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="plgid" value="{$portlet_group.plgid}">
 <p>{cb_msg module='grn.portal.system' key='GRN_POT_SY-263' replace='true'}<span class="bold">{$portlet_group.title|escape}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-264' replace='true'}</p>
 <p>
  {capture name='grn_portal_system_GRN_POT_SY_265'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-265' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_265}
  {capture name='grn_portal_system_GRN_POT_SY_266'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-266' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_266}
 </p>
</form>
{include file='grn/system_footer.tpl'}

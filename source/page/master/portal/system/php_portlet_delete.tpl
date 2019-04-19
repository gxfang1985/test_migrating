{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="plid" value="{$portlet.plid}">
 <p>{cb_msg module='grn.portal.system' key='GRN_POT_SY-91' replace='true'}<span class="bold">{grn_image image='portlet20.gif'}{$portlet.title|escape}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-92' replace='true'}</p>
 <p>
  {capture name='grn_portal_system_GRN_POT_SY_93'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-93' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_93}
  {capture name='grn_portal_system_GRN_POT_SY_94'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-94' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_94}
 </p>
</form>
{include file='grn/system_footer.tpl'}

{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/user/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.system.user' key='GRN_SY_US-505' replace='true'}<span class="bold">{grn_image image='role20.gif'}{$role_name|escape}</span>{cb_msg module='grn.system.user' key='GRN_SY_US-506' replace='true'}
<div class="attention">{cb_msg module='grn.system.user' key='GRN_SY_US-507' replace='true'}<br>{cb_msg module='grn.system.user' key='GRN_SY_US-508' replace='true'}</div>
</p>
 <p>
  {capture name='grn_system_user_GRN_SY_US_509'}{cb_msg module='grn.system.user' key='GRN_SY_US-509' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_509 id="system-role-delete-submit"}
  {capture name='grn_system_user_GRN_SY_US_510'}{cb_msg module='grn.system.user' key='GRN_SY_US-510' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_system_user_GRN_SY_US_510 id="sytem-role-delete-cancel"}
 </p>
 <input type="hidden" name="role_id" value="{$role_id}">
</form>
{include file="grn/system_footer.tpl"}

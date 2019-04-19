{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="lmid" value="{$login_method.lmid}">
 <p>{cb_msg module='grn.system.authentication' key='GRN_SY_AU-52' replace='true'}<span class="bold">{$login_method.display_name|escape}</span>{cb_msg module='grn.system.authentication' key='GRN_SY_AU-53' replace='true'}</p>
 <p>
  {capture name='grn_system_authentication_GRN_SY_AU_54'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-54' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_54}{capture name='grn_system_authentication_GRN_SY_AU_55'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-55' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_55}
 </p>
</form>
{include file='grn/system_footer.tpl'}

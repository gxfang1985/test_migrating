{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/authentication/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="rmid" value="{$repository_method.rmid}">
 <p>{cb_msg module='grn.system.authentication' key='GRN_SY_AU-61' replace='true'}<span class="bold">{$repository_method.display_name|escape}</span>{cb_msg module='grn.system.authentication' key='GRN_SY_AU-62' replace='true'}</p>
 <p>
  {capture name='grn_system_authentication_GRN_SY_AU_63'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-63' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_63}{capture name='grn_system_authentication_GRN_SY_AU_64'}{cb_msg module='grn.system.authentication' key='GRN_SY_AU-64' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_system_authentication_GRN_SY_AU_64}
 </p>
</form>
{include file='grn/system_footer.tpl'}

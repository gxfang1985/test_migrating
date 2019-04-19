{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/sso/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="smid" value="{$sso_method.smid}">
 <p>{cb_msg module='grn.system.sso' key='GRN_SY_SS-14' replace='true'}<span class="bold">{$sso_method.display_name|escape}</span>{cb_msg module='grn.system.sso' key='GRN_SY_SS-15' replace='true'}</p>
 <p>
  {capture name='grn_system_sso_GRN_SY_SS_16'}{cb_msg module='grn.system.sso' key='GRN_SY_SS-16' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_sso_GRN_SY_SS_16}{capture name='grn_system_sso_GRN_SY_SS_17'}{cb_msg module='grn.system.sso' key='GRN_SY_SS-17' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_system_sso_GRN_SY_SS_17}
 </p>
</form>
{include file='grn/system_footer.tpl'}

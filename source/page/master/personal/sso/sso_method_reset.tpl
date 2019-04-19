{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='personal/sso/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="smid" value="{$sso_method.smid}">
 <p>{cb_msg module='grn.personal.sso' key='GRN_PRS_SO-5' replace='true'}<span class="bold">{$sso_method.display_name|escape}</span>{cb_msg module='grn.personal.sso' key='GRN_PRS_SO-6' replace='true'}</p>
 <p>
  {capture name='grn_personal_sso_GRN_PRS_SO_7'}{cb_msg module='grn.personal.sso' key='GRN_PRS_SO-7' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_personal_sso_GRN_PRS_SO_7}{capture name='grn_personal_sso_GRN_PRS_SO_8'}{cb_msg module='grn.personal.sso' key='GRN_PRS_SO-8' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_personal_sso_GRN_PRS_SO_8}
 </p>
</form>
{include file='grn/personal_footer.tpl'}

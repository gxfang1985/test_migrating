{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
  {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-442' replace='true'}
 </p>
 <p>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-443' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-444' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-445' replace='true'}</p>

 <p>{capture name='grn_mail_system_GRN_MAIL_SY_447'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-447' replace='true'}{/capture}{capture name='grn_mail_system_GRN_MAIL_SY_448'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-448' replace='true'}{/capture}{grn_checkbox name='mail_delete' id='checkbox_1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_447|cat:$app_name|cat:$smarty.capture.grn_mail_system_GRN_MAIL_SY_448}</p>
 <p>
  {capture name='grn_mail_system_GRN_MAIL_SY_449'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-449' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_449}
  {capture name='grn_mail_system_GRN_MAIL_SY_450'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-450' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_450 page='mail/system/user_account' oid=$org_id}
 </p>
 <input type="hidden" name="oid" value="{$org_id}">
</form>
{include file='grn/system_footer.tpl'}

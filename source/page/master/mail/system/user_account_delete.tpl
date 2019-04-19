{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
  {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-120' replace='true'}<span class="bold">{grn_sentence class='mailaccount20' caption=$set.title}</span>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-121' replace='true'}
 </p>
 <p>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-122' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-123' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-124' replace='true'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-125' replace='true'}</p>
 <p><span class="attention">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-126' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-127' replace='true'}</span></p>
 <p>{capture name='grn_mail_system_GRN_MAIL_SY_128'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-128' replace='true'}{/capture}{capture name='grn_mail_system_GRN_MAIL_SY_129'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-129' replace='true'}{/capture}{grn_checkbox name='mail_delete' id='checkbox_1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_128|cat:$app_name|cat:$smarty.capture.grn_mail_system_GRN_MAIL_SY_129}</p>
 <p>
  {capture name='grn_mail_system_GRN_MAIL_SY_130'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-130' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_130}
  {capture name='grn_mail_system_GRN_MAIL_SY_131'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-131' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_131 page='mail/system/user_account_view' oid=$org_id uid=$user.uid aid=$set.aid}
 </p>
 <input type="hidden" name="oid" value="{$org_id}">
 <input type="hidden" name="uid" value="{$user.uid}">
 <input type="hidden" name="aid" value="{$set.aid}">
</form>
{include file='grn/system_footer.tpl'}

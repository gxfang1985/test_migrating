{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
  {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-374' replace='true'}<span class="bold">{$delete_numbers|escape}</span>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-375' replace='true'}
 </p>
 <p>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-376' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-377' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-378' replace='true'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-379' replace='true'}</p>
 <p><span class="attention">{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-380' replace='true'}{$app_name}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-381' replace='true'}</span></p>
 <p>{capture name='grn_mail_system_GRN_MAIL_SY_382'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-382' replace='true'}{/capture}{capture name='grn_mail_system_GRN_MAIL_SY_383'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-383' replace='true'}{/capture}{grn_checkbox name='mail_delete' id='checkbox_1' value='1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_382|cat:$app_name|cat:$smarty.capture.grn_mail_system_GRN_MAIL_SY_383}</p>
 <p>
  {capture name='grn_mail_system_GRN_MAIL_SY_384'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-384' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_384}
  {capture name='grn_mail_system_GRN_MAIL_SY_385'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-385' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_385}
 </p>
{foreach from=$account_list item=account}
 <input type="hidden" name="aid[]" value="{$account.aid}">
{/foreach}
 <input type="hidden" name="oid" value="{$org_id}">
 <input type="hidden" name="uid" value="{$user.uid}">
</form>
{include file='grn/system_footer.tpl'}

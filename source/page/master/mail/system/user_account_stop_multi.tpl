{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
  {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-169' replace='true'}<span class="bold">{grn_user_name name=$user.name uid=$user.uid nolink=TRUE}</span>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-170' replace='true'}<span class="bold">{$disable_numbers|escape}</span>{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-171' replace='true'}
 </p>
 <p>
  {capture name='grn_mail_system_GRN_MAIL_SY_172'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-172' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_172}
  {capture name='grn_mail_system_GRN_MAIL_SY_173'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-173' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_173}
 </p>
{foreach from=$account_list item=account}
 <input type="hidden" name="aid[]" value="{$account.aid}">
{/foreach}
 <input type="hidden" name="oid" value="{$org_id}">
 <input type="hidden" name="uid" value="{$user.uid}">
</form>
{include file='grn/system_footer.tpl'}

{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>
  {cb_msg module='grn.mail.system' key='GRN_MAIL_SY-324' replace='true'}
 </p>
  {capture name='grn_mail_system_GRN_MAIL_SY_325'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-325' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_325}
  {capture name='grn_mail_system_GRN_MAIL_SY_326'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-326' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_326 page='mail/system/mailserver'}
 </p>
 <input type="hidden" name="oid" value="{$org_id}">
</form>
{include file='grn/system_footer.tpl'}

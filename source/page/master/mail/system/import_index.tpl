{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul>
<li>{capture name='grn_mail_system_GRN_MAIL_SY_438'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-438' replace='true'}{/capture}{grn_link image='import20.gif' page='mail/system/mailserver_import1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_438}
<li>{capture name='grn_mail_system_GRN_MAIL_SY_439'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-439' replace='true'}{/capture}{grn_link image='import20.gif' page='mail/system/user_account_import1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_439}
<li>{capture name='grn_mail_system_GRN_MAIL_SY_440'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-440' replace='true'}{/capture}{grn_link image='import20.gif' page='mail/system/mail_limit_import1' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_440}
</ul>

{include file="grn/system_footer.tpl"}

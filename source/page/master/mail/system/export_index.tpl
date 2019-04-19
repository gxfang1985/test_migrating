{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}

<ul>
<li>{capture name='grn_mail_system_GRN_MAIL_SY_114'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-114' replace='true'}{/capture}{grn_link image='export20.gif' page='mail/system/mailserver_export' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_114}
<li>{capture name='grn_mail_system_GRN_MAIL_SY_115'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-115' replace='true'}{/capture}{grn_link image='export20.gif' page='mail/system/user_account_export' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_115}
<li>{capture name='grn_mail_system_GRN_MAIL_SY_116'}{cb_msg module='grn.mail.system' key='GRN_MAIL_SY-116' replace='true'}{/capture}{grn_link image='export20.gif' page='mail/system/mail_limit_export' caption=$smarty.capture.grn_mail_system_GRN_MAIL_SY_116}
</ul>

{include file="grn/system_footer.tpl"}

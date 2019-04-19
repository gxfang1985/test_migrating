{include file='grn/personal_head.tpl'}
{include file='grn/personal_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='mail/personal/command_'|cat:$page_info.last}">
    <input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
    <p>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-278' replace='true'}<span class="bold">{grn_sentence class='mailaccount20' caption=$set.title}</span>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-279' replace='true'}</p>
    <p>{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-280' replace='true'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-281' replace='true'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-282' replace='true'}</p>
    <p><span class="attention">{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-283' replace='true'}</span></p>
    <p>{capture name='grn_mail_personal_GRN_MAIL_PE_281'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-281' replace='true'}{/capture}{grn_checkbox name='mail_delete' id='checkbox_1' value='1' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_281}</p>
    <p>
        {capture name='grn_mail_personal_GRN_MAIL_PE_142'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-142' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_142}
        {capture name='grn_mail_personal_GRN_MAIL_PE_143'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-143' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_143 page='mail/personal/account_view' aid=$set.aid}
    </p>
    <input type="hidden" name="aid" value="{$set.aid}">
</form>
{include file='grn/personal_footer.tpl'}

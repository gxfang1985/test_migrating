{capture name='grn_mail_personal_GRN_MAIL_PE_128'}{cb_msg module='grn.mail.personal' key='GRN_MAIL_PE-128' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_mail_personal_GRN_MAIL_PE_128}
{grn_button_cancel page="mail/personal/filter_view" aid=$set.aid mfid=$filter.mfid}

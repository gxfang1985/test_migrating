{capture name='grn_mail_cellular_GRN_MAIL_CE_11'}{cb_msg module='grn.mail.cellular' key='GRN_MAIL_CE-11' replace='true'}{/capture}{grn_cellular_link page='mail/cellular/command_receive' receive=true icon="new_mail" caption=$params.count|string_format:$smarty.capture.grn_mail_cellular_GRN_MAIL_CE_11}<br>

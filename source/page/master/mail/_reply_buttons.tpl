{strip}
    {capture name="grn_mail_GRN_MAIL_279"}{cb_msg module='grn.mail' key='GRN_MAIL-279' replace='true'}{/capture}
    {capture name="grn_mail_GRN_MAIL_281"}{cb_msg module='grn.mail' key='GRN_MAIL-281' replace='true'}{/capture}
    {capture name="onmailsend"}document.forms['{$form_name}'].cmd.value='{if $preview}preview{else}send{/if}'{/capture}
    {capture name="onmailsave"}document.forms['{$form_name}'].cmd.value='draft'{/capture}
    {grn_button id="mail_button_send$suffix" html_name="submit_button" ui="main" spacing="loose" caption=$smarty.capture.grn_mail_GRN_MAIL_279 onclick=$smarty.capture.onmailsend}
    {grn_button id="mail_button_save$suffix" html_name="submit_button" spacing="tight" caption=$smarty.capture.grn_mail_GRN_MAIL_281 onclick=$smarty.capture.onmailsave}
    {grn_button id="mail_button_cancel$suffix" action="cancel" page="mail/view" page_param_aid=$mail.aid page_param_cid=$mail.cid page_param_mid=$mail.mid}
{/strip}

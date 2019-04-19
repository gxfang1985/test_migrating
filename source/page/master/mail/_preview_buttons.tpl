{strip}
    {capture name="onmailsend"}grn.page.mail._preview.ajax_submit('send', '{$form_name|escape}', '{grn_pageurl page=$submit_page}', this);{/capture}
    {capture name="onmailmodify"}grn.page.mail._preview.ajax_submit('modify', '{$form_name|escape}', '{grn_pageurl page=$submit_page}', this);{/capture}
    {capture name="grn_mail_GRN_MAIL_255"}{cb_msg module='grn.mail' key='GRN_MAIL-255' replace='true'}{/capture}
    {capture name="grn_mail_GRN_MAIL_256"}{cb_msg module='grn.mail' key='GRN_MAIL-256' replace='true'}{/capture}
    {grn_button id="mail_button_send$suffix" ui="main" spacing="normal" caption=$smarty.capture.grn_mail_GRN_MAIL_255 onclick=$smarty.capture.onmailsend}
    {grn_button id="mail_button_modify$suffix" caption=$smarty.capture.grn_mail_GRN_MAIL_256 onclick=$smarty.capture.onmailmodify}
{/strip}

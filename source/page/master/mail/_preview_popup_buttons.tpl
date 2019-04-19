{strip}
    {capture name="grn_mail_GRN_MAIL_255"}{cb_msg module='grn.mail' key='GRN_MAIL-255' replace='true'}{/capture}
    {capture name="grn_mail_GRN_MAIL_256"}{cb_msg module='grn.mail' key='GRN_MAIL-256' replace='true'}{/capture}
    {capture name="onmailsend"}grn.page.mail._preview.ajax_submit('send', '{$form_name|escape}', '{grn_pageurl page=mail/command_`$page_info.last`}', this);{/capture}
    {capture name="onmodifyclick"}grn.page.mail._preview.ajax_submit('modify', '{$form_name|escape}', '{grn_pageurl page=mail/command_`$page_info.last`}', this);{/capture}
    {grn_button id="mail_button_send$suffix" ui="main" caption=$smarty.capture.grn_mail_GRN_MAIL_255 spacing="normal" onclick=$smarty.capture.onmailsend}
    {grn_button id="mail_button_modify$suffix" caption=$smarty.capture.grn_mail_GRN_MAIL_256 onclick=$smarty.capture.onmodifyclick}
{/strip}
{strip}
    {capture name="grn_mail_GRN_MAIL_87"}{cb_msg module='grn.mail' key='GRN_MAIL-87' replace='true'}{/capture}
    {capture name="grn_mail_GRN_MAIL_89"}{cb_msg module='grn.mail' key='GRN_MAIL-89' replace='true'}{/capture}
    {capture name="onmailsend"}document.forms['{$form_name|escape}'].cmd.value='{if $preview}preview{else}send{/if}';{/capture}
    {capture name="onmailsave"}document.forms['{$form_name|escape}'].cmd.value='draft';{/capture}
    {grn_button id="mail_button_send$suffix" html_name="submit_button" ui="main" spacing="loose" caption=$smarty.capture.grn_mail_GRN_MAIL_87 onclick=$smarty.capture.onmailsend}
    {grn_button id="mail_button_save$suffix" html_name="submit_button" spacing="tight" class="button_submit_grn" caption=$smarty.capture.grn_mail_GRN_MAIL_89 onclick=$smarty.capture.onmailsave}
    {if $mai.aid}
        {grn_button id="mail_button_cancel$suffix" action="cancel" page="mail/index" page_param_aid=$mail.aid cid=$mail.cid}
    {else}
        {grn_button id="mail_button_cancel$suffix" action="cancel" page="mail/index" page_param_aid=$category.aid cid=$category.cid}
    {/if}
{/strip}
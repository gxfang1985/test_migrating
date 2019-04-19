{strip}
    <div class="button_base_grn tAlignLeft-grn">
        {capture name="grn_mail_GRN_MAIL_87"}{cb_msg module='grn.mail' key='GRN_MAIL-87' replace='true'}{/capture}
        {capture name="grn_mail_GRN_MAIL_89"}{cb_msg module='grn.mail' key='GRN_MAIL-89' replace='true'}{/capture}
        {capture name="onmailsend"}document.forms['{$form_name|escape}'].cmd.value='{if $preview}preview{else}send{/if}';{/capture}
        {capture name="onmailsave"}document.forms['{$form_name|escape}'].cmd.value='draft';{/capture}
        {grn_button id="mail_button_send$suffix" ui="main" html_name="submit_button" spacing="loose" caption=$smarty.capture.grn_mail_GRN_MAIL_87 onclick=$smarty.capture.onmailsend }
        {grn_button id="mail_button_save$suffix" html_name="submit_button" spacing="tight" class="button_submit_grn" caption=$smarty.capture.grn_mail_GRN_MAIL_89 onclick=$smarty.capture.onmailsave}
        {grn_button id="mail_button_cancel$suffix" action="cancel" onclick=$smarty.capture.onclick name="submit_button" onclick="window.close();"}
    </div>
{/strip}
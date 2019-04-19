{strip}
    <div class="button_base_grn tAlignLeft-grn">
        {capture name="grn_mail_GRN_MAIL_296"}{cb_msg module='grn.mail' key='GRN_MAIL-296' replace='true'}{/capture}
        {capture name="grn_mail_GRN_MAIL_298"}{cb_msg module='grn.mail' key='GRN_MAIL-298' replace='true'}{/capture}
        {capture name="onmailsend"}document.forms['{$form_name|escape}'].cmd.value='{if $preview}preview{else}send{/if}';{/capture}
        {capture name="onmodifyclick"}document.forms['{$form_name|escape}'].cmd.value='draft';{/capture}
        {grn_button id="mail_button_send$suffix" html_name="submit_button" ui="main" spacing="loose" caption=$smarty.capture.grn_mail_GRN_MAIL_296 onclick=$smarty.capture.onmailsend}
        {grn_button id="mail_button_save$suffix" html_name="submit_button" spacing="tight" caption=$smarty.capture.grn_mail_GRN_MAIL_298 onclick=$smarty.capture.onmodifyclick}
        {grn_button id="mail_button_cancel$suffix" action="cancel" onclick="window.close();"}
    </div>
{/strip}
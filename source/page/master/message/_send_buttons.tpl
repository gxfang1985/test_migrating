<div class="mTop10">
    {strip}
        {capture name='grn_message_GRN_MSG_3'}{cb_msg module='grn.message' key='GRN_MSG-3' replace='true'}{/capture}
        {capture name='message_button_send_onclick'}
            {literal} if (grn.component.button(this).isDisabled()) return false; if (!confirmIfExistFailedFile()) { return false; } else { {/literal} grn_onsubmit_common(); document.forms['{$form_name}'].cmd.value = 'send'; grn.component.button.util.submit(this); grn.component.button(this).showSpinner(); {literal}}{/literal}
        {/capture}
        {grn_button ui="main" spacing="loose" action="submit" caption=$smarty.capture.grn_message_GRN_MSG_3 onclick=$smarty.capture.message_button_send_onclick id="message_button_send" auto_disable=false}

        {capture name='grn_message_GRN_MSG_4'}{cb_msg module='grn.message' key='GRN_MSG-4' replace='true'}{/capture}
        {capture name='message_button_draft_onclick'}
            {literal} if (grn.component.button(this).isDisabled()) return false; if (!confirmIfExistFailedFile()) { return false; } else { {/literal} grn_onsubmit_common(); document.forms['{$form_name}'].cmd.value = 'draft'; grn.component.button.util.submit(this); grn.component.button(this).showSpinner(); {literal}}{/literal}
        {/capture}
        {grn_button spacing="tight" action="submit" caption=$smarty.capture.grn_message_GRN_MSG_4 onclick=$smarty.capture.message_button_draft_onclick id="message_button_draft" class="button_submit_grn" auto_disable=false}

        {grn_button action="cancel" page="message/index" page_param_cid="$category_id" id="message_button_cancel"}
    {/strip}
</div>
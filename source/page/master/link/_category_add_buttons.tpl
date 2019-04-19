<div class="mTop10">
    {strip}
        {capture name='grn_link_GRN_LNK_183'}{cb_msg module='grn.link' key='GRN_LNK-183' replace='true'}{/capture}
        {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_link_GRN_LNK_183 id="link_button_save"}

        {grn_button action="cancel" id="link_button_cancel" page="link/index" page_param_cid=$category.cid page_param_type='personal'}
    {/strip}
</div>
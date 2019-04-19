<div class="mTop10">
    {strip}
        {capture name='grn_link_GRN_LNK_135'}{cb_msg module='grn.link' key='GRN_LNK-135' replace='true'}{/capture}
        {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_link_GRN_LNK_135 id='link-modify-submit'}

        {grn_button action="cancel" page='link/view' page_param_cid=$category.cid page_param_lid=$link.lid page_param_type='personal' id='link-modify-cancel'}
    {/strip}
</div>
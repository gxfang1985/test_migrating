<div id="one_parts">
    <div id="action">
        <!----->
        <div class="sub_title">{cb_msg module='grn.link' key='GRN_LNK-2' replace='true'}{cb_msg module='grn.link' key='GRN_LNK-187' replace='true'}&nbsp;{grn_sentence image='category20.gif' caption=$category.title}</div>
        {grn_change_order form_name=$form_name select_name='order[]' options=$category.child_categories}
        <!----->
    </div><!--action_end--->
</div>
{strip}
    <div class="mTop15 mBottom15">
        {capture name='grn_link_GRN_LNK_3'}{cb_msg module='grn.link' key='GRN_LNK-3' replace='true'}{/capture}
        {capture name='link_button_save_onclick'}
            grn_onsubmit_common(document.forms['{$form_name}']); grn.component.button.util.submit(this);
        {/capture}
        {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_link_GRN_LNK_3 id="link_button_save" onclick=$smarty.capture.link_button_save_onclick}

        {grn_button action="cancel" id="link_button_cancel"}
    </div>
{/strip}
<input type="hidden" name="pcid" value="{$category.cid}">

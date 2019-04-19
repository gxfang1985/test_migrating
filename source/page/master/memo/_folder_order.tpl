<div id="one_parts">
    <div id="action">
        <!----->
        {if $folder.name}
            <div class="sub_title">{cb_msg module='grn.memo' key='GRN_MEM-42' replace='true'}{cb_msg module='grn.memo' key='GRN_MEM-57' replace='true'}&nbsp;{grn_sentence caption=$folder.name image='folder20.gif'}</div>
        {/if}
        {grn_change_order form_name=$form_name select_name='order[]' options=$folder.folders}
        <!----->
    </div>
</div>
{strip}
    <div class="mTop15 mBottom15">
    {capture name='grn_memo_GRN_NEM_43'}{cb_msg module='grn.memo' key='GRN_MEM-43' replace='true'}{/capture}
    {capture name='memo_button_save_onclick'}
        grn_onsubmit_common(document.forms['{$form_name}']); grn.component.button.util.submit(this);
    {/capture}
    {grn_button ui="main" spacing="normal" action="submit" caption=$smarty.capture.grn_memo_GRN_NEM_43 onclick=$smarty.capture.memo_button_save_onclick id="memo_button_save"}

    {grn_button action="cancel" id="memo_button_cancel"}
    </div>
{/strip}
<input type="hidden" name="did" value="{$folder_id}">

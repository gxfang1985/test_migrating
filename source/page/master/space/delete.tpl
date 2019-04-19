{strip}
<div class="content" style="width: 500px; display: block;">
    <div class="attention_area_grn mTop5">
        <div>
        <span class="icon_attention_grn block_grn break_word_grn" style="width:460px;">
            {cb_msg module='grn.space' key='delete-1' replace='true'}
            <span class="bold_grn">
                {/strip}{cb_msg module='grn.space' key='delete-2' replace='true'}{$space_name|escape}{cb_msg module='grn.space' key='delete-3' replace='true'}{strip}
            </span>
            {cb_msg module='grn.space' key='delete-4' replace='true'}
        </span>
        </div>
    </div>
    <div class="mTop10">
        {cb_msg module='grn.space' key='delete-5' replace='true'}
    </div>
</div>
<div class="buttonArea-grn">
    <div>
        {capture name='grn_space_delete_6'}{cb_msg module='grn.space' key='delete-6' replace='true'}{/capture}
        {capture name='grn_space_delete_7'}{cb_msg module='grn.space' key='delete-7' replace='true'}{/capture}
        {grn_button id='space_delete_submit' ui='attention' spacing='normal' auto_disable='true' caption=$smarty.capture.grn_space_delete_6}
        {grn_button id='space_delete_cancel' ui='normal' caption=$smarty.capture.grn_space_delete_7}
    </div>
</div>
{/strip}
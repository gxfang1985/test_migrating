
{if $delete_continue}
<p>
<div class="attention">
{cb_msg module='grn.bulletin' key='GRN_BLLT-116' replace='true'}<br>
{cb_msg module='grn.bulletin' key='GRN_BLLT-117' replace='true'}</div>
</p> 
{/if}
<p>
{cb_msg module='grn.bulletin' key='GRN_BLLT-118' replace='true'}<br>
{cb_msg module='grn.bulletin' key='GRN_BLLT-119' replace='true'}{grn_sentence caption=$category.name image='category20.gif' class='bold'}
</p>
<p>
{capture name='grn_bulletin_GRN_BLLT_120'}{cb_msg module='grn.bulletin' key='GRN_BLLT-120' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_120}{capture name='grn_bulletin_GRN_BLLT_121'}{cb_msg module='grn.bulletin' key='GRN_BLLT-121' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_121}
</p>
<input type="hidden" name="cid" value="{$category.cid}">


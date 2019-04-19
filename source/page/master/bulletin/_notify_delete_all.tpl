<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.bulletin' key='GRN_BLLT-254' replace='true'}<br>
{cb_msg module='grn.bulletin' key='GRN_BLLT-255' replace='true'}{grn_sentence caption=$node.name image='category20.gif' class='bold'}
</div>

{capture name='grn_bulletin_GRN_BLLT_256'}{cb_msg module='grn.bulletin' key='GRN_BLLT-256' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_256}
{capture name='grn_bulletin_GRN_BLLT_257'}{cb_msg module='grn.bulletin' key='GRN_BLLT-257' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_bulletin_GRN_BLLT_257}

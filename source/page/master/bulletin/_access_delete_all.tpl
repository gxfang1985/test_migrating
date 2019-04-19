<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.bulletin' key='GRN_BLLT-390' replace='true'}<br>
{grn_sentence caption=$node.name image='category20.gif' class='bold'}<br>
</div>

{capture name='grn_bulletin_GRN_BLLT_391'}{cb_msg module='grn.bulletin' key='GRN_BLLT-391' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_391}
{capture name='grn_bulletin_GRN_BLLT_392'}{cb_msg module='grn.bulletin' key='GRN_BLLT-392' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_bulletin_GRN_BLLT_392}

<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
{foreach from=$eid item=item}
<input type="hidden" name="eid[]" value="{$item|escape}">
{/foreach}

<div class="explanation">
{cb_msg module='grn.bulletin' key='GRN_BLLT-202' replace='true'}<br>
{cb_msg module='grn.bulletin' key='GRN_BLLT-203' replace='true'}{grn_sentence caption=$node.name image='category20.gif' class='bold'}<br>
{cb_msg module='grn.bulletin' key='GRN_BLLT-204' replace='true'}{grn_sentence caption=$count class='bold'}<br>
</div>

{capture name='grn_bulletin_GRN_BLLT_205'}{cb_msg module='grn.bulletin' key='GRN_BLLT-205' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_205}
{capture name='grn_bulletin_GRN_BLLT_206'}{cb_msg module='grn.bulletin' key='GRN_BLLT-206' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_bulletin_GRN_BLLT_206}

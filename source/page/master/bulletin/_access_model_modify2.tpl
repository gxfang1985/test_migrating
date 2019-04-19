
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="security_model" value="{$security_model}">

<div class="explanation">
{cb_msg module='grn.bulletin' key='GRN_BLLT-75' replace='true'}
{if $security_model == 'grant'}
{cb_msg module='grn.bulletin' key='GRN_BLLT-76' replace='true'}{cb_msg module="grn.common" key="grant"})
{else}
{cb_msg module='grn.bulletin' key='GRN_BLLT-77' replace='true'}{cb_msg module="grn.common" key="revoke"})
{/if}
{cb_msg module='grn.bulletin' key='GRN_BLLT-78' replace='true'}<br>
{cb_msg module='grn.bulletin' key='GRN_BLLT-79' replace='true'}<br>
{cb_msg module='grn.bulletin' key='GRN_BLLT-80' replace='true'}{grn_sentence caption=$node.name image='category20.gif' class='bold'}<br>

</div>
<div class="attention">{cb_msg module='grn.bulletin' key='GRN_BLLT-81' replace='true'}</div>

{capture name='grn_bulletin_GRN_BLLT_82'}{cb_msg module='grn.bulletin' key='GRN_BLLT-82' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_82}
{capture name='grn_bulletin_GRN_BLLT_83'}{cb_msg module='grn.bulletin' key='GRN_BLLT-83' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_bulletin_GRN_BLLT_83}


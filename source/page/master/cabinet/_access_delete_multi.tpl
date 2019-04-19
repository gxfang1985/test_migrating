<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
{foreach from=$eid item=item}
<input type="hidden" name="eid[]" value="{$item|escape}">
{/foreach}

<div class="explanation">
{cb_msg module='grn.cabinet' key='GRN_CAB-269' replace='true'}<br>
{cb_msg module='grn.cabinet' key='GRN_CAB-270' replace='true'}{grn_sentence caption=$node.name image='folder20.gif' class='bold'}<br>
{cb_msg module='grn.cabinet' key='GRN_CAB-271' replace='true'}{grn_sentence caption=$count class='bold'}
</div>

{capture name='grn_cabinet_GRN_CAB_272'}{cb_msg module='grn.cabinet' key='GRN_CAB-272' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_cabinet_GRN_CAB_272}
{capture name='grn_cabinet_GRN_CAB_273'}{cb_msg module='grn.cabinet' key='GRN_CAB-273' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_cabinet_GRN_CAB_273}


<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
{foreach from=$eid item=item}
<input type="hidden" name="eid[]" value="{$item|escape}">
{/foreach}

<div class="explanation">
{cb_msg module='grn.cabinet' key='GRN_CAB-250' replace='true'}<br>
{cb_msg module='grn.cabinet' key='GRN_CAB-251' replace='true'}{grn_sentence caption=$node.name image='folder20.gif' class='bold'}<br>
{cb_msg module='grn.cabinet' key='GRN_CAB-252' replace='true'}{grn_sentence caption=$count class='bold'}<br>
</div>

{capture name='grn_cabinet_GRN_CAB_253'}{cb_msg module='grn.cabinet' key='GRN_CAB-253' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_cabinet_GRN_CAB_253}
{capture name='grn_cabinet_GRN_CAB_254'}{cb_msg module='grn.cabinet' key='GRN_CAB-254' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_cabinet_GRN_CAB_254}

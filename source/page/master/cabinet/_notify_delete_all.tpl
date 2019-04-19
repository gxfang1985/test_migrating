<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.cabinet' key='GRN_CAB-266' replace='true'}<br>
{grn_sentence caption=$node.name image='folder20.gif' class='bold'}
</div>

{capture name='grn_cabinet_GRN_CAB_267'}{cb_msg module='grn.cabinet' key='GRN_CAB-267' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_cabinet_GRN_CAB_267}
{capture name='grn_cabinet_GRN_CAB_268'}{cb_msg module='grn.cabinet' key='GRN_CAB-268' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_cabinet_GRN_CAB_268}

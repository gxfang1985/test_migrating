<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="security_model" value="{$security_model}">

<div class="explanation">
{capture name="grant_caption"}{cb_msg module='grn.cabinet' key='GRN_CAB-53' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.cabinet' key='GRN_CAB-54' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.cabinet' key='GRN_CAB-55' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.cabinet' key='GRN_CAB-56' replace='true'}{/capture}

{cb_msg module='grn.cabinet' key='GRN_CAB-57' replace='true'}<span class="bold">{if $security_model eq 'grant'}{$smarty.capture.grant_caption|grn_noescape}{elseif  $security_model eq 'revoke'}{$smarty.capture.revoke_caption|grn_noescape}{/if}</span>{cb_msg module='grn.cabinet' key='GRN_CAB-58' replace='true'}<br>
<span class="bold">{grn_image image='folder20.gif'}{$node.name|escape}</span>

<div class="attention">{cb_msg module='grn.cabinet' key='GRN_CAB-59' replace='true'}</div>

</div>

{capture name='grn_cabinet_GRN_CAB_60'}{cb_msg module='grn.cabinet' key='GRN_CAB-60' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_cabinet_GRN_CAB_60}
{capture name='grn_cabinet_GRN_CAB_61'}{cb_msg module='grn.cabinet' key='GRN_CAB-61' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_cabinet_GRN_CAB_61}

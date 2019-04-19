<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.cabinet' key='GRN_CAB-258' replace='true'}<br>
<span class="bold">{grn_image image='folder20.gif'}{$node.name|escape}</span>
</div>

<p>
<table class="std_form">
<tr>
<th>{cb_msg module='grn.cabinet' key='GRN_CAB-259' replace='true'}</th>
<td>
{capture name="grant_caption"}{cb_msg module='grn.cabinet' key='GRN_CAB-260' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.cabinet' key='GRN_CAB-261' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.cabinet' key='GRN_CAB-262' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.cabinet' key='GRN_CAB-263' replace='true'}{/capture}
{grn_radio name='security_model' id='grant' value='grant' caption=$smarty.capture.grant_caption checked=$is_grant}<br>
{grn_radio name='security_model' id='revoke' value='revoke' caption=$smarty.capture.revoke_caption checked=$is_revoke}<br>
</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_cabinet_GRN_CAB_264'}{cb_msg module='grn.cabinet' key='GRN_CAB-264' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_cabinet_GRN_CAB_264}
{grn_button_cancel}
</td>
</tr>
</table>


<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.bulletin' key='GRN_BLLT-44' replace='true'}<br>
{cb_msg module='grn.bulletin' key='GRN_BLLT-45' replace='true'}{grn_sentence caption=$node.name image='category20.gif' class='bold'}<br>
</div>

<p>
<table class="std_form">
<tr>
<th>{cb_msg module='grn.bulletin' key='GRN_BLLT-46' replace='true'}</th>
<td>
{capture name="grant_caption"}{cb_msg module='grn.bulletin' key='GRN_BLLT-47' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.bulletin' key='GRN_BLLT-48' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.bulletin' key='GRN_BLLT-49' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.bulletin' key='GRN_BLLT-50' replace='true'}{/capture}
{grn_radio name='security_model' id='grant' value='grant' caption=$smarty.capture.grant_caption checked=$is_grant}<br>
{grn_radio name='security_model' id='revoke' value='revoke' caption=$smarty.capture.revoke_caption checked=$is_revoke}<br>
</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_bulletin_GRN_BLLT_51'}{cb_msg module='grn.bulletin' key='GRN_BLLT-51' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_bulletin_GRN_BLLT_51}
{grn_button_cancel}
</td>
</tr>
</table>

<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">

<div class="explanation">
{cb_msg module='grn.bulletin' key='GRN_BLLT-175' replace='true'}<br>
{cb_msg module='grn.bulletin' key='GRN_BLLT-176' replace='true'}{grn_sentence caption=$node.name image='category20.gif' class='bold'}
</div>

<p>
<table class="std_form">
<tr>
<th>{cb_msg module='grn.bulletin' key='GRN_BLLT-177' replace='true'}</th>
<td>
{if $notify.force}
{assign var='is_force' value='1'}
{assign var='is_not_force' value='0'}
{else}
{assign var='is_force' value='0'}
{assign var='is_not_force' value='1'}
{/if}
{capture name='grn_bulletin_GRN_BLLT_178'}{cb_msg module='grn.bulletin' key='GRN_BLLT-178' replace='true'}{/capture}{grn_radio name='force' id='0' value='0' caption=$smarty.capture.grn_bulletin_GRN_BLLT_178   checked=$is_not_force}<br>
{capture name='grn_bulletin_GRN_BLLT_179'}{cb_msg module='grn.bulletin' key='GRN_BLLT-179' replace='true'}{/capture}{grn_radio name='force' id='1' value='1' caption=$smarty.capture.grn_bulletin_GRN_BLLT_179 checked=$is_force}<br>
</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_bulletin_GRN_BLLT_180'}{cb_msg module='grn.bulletin' key='GRN_BLLT-180' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_bulletin_GRN_BLLT_180}
{grn_button_cancel}
</td>
</tr>
</table>

{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="poid" value="{$poid|escape}">
{foreach from=$ours_params key=key item=item}
<input type="hidden" name="{$key}" value="{$item|escape}">
{/foreach}

<div class="explanation">
{cb_msg module='grn.portal.system' key='GRN_POT_SY-441' replace='true'}
</div>

<p>
<table class="std_form">
<tr>
<th>{cb_msg module='grn.portal.system' key='GRN_POT_SY-442' replace='true'}</th>
<td>
{capture name="grant_caption"}{cb_msg module='grn.portal.system' key='GRN_POT_SY-443' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.portal.system' key='GRN_POT_SY-444' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.portal.system' key='GRN_POT_SY-445' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.portal.system' key='GRN_POT_SY-446' replace='true'}{/capture}
{grn_radio name='security_model' id='grant' value='grant' caption=$smarty.capture.grant_caption checked=$is_grant}<br>
{grn_radio name='security_model' id='revoke' value='revoke' caption=$smarty.capture.revoke_caption checked=$is_revoke}<br>
</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_portal_system_GRN_POT_SY_447'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-447' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_447}
{grn_button_cancel}
</td>
</tr>
</table>

</form>

{include file='grn/system_footer.tpl'}

{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="nid" value="{$node_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
{foreach from=$ours_params key=key item=item}
<input type="hidden" name="{$key}" value="{$item|escape}">
{/foreach}

<div class="explanation">
{if 'portal' == $node.type}
{cb_msg module='grn.portal.system' key='GRN_POT_SY-422' replace='true'}<span class="bold">{grn_image image='portal20.gif'}{$node.name|escape}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-423' replace='true'}
{else}
{cb_msg module='grn.portal.system' key='GRN_POT_SY-424' replace='true'}<span class="bold">{grn_image image='portlet20.gif'}{$node.name|escape}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-425' replace='true'}
{/if}
{cb_msg module='grn.portal.system' key='GRN_POT_SY-426' replace='true'}
</div>

<p>
<table class="std_form">
<tr>
<th>{cb_msg module='grn.portal.system' key='GRN_POT_SY-427' replace='true'}</th>
<td>
{capture name="grant_caption"}{cb_msg module='grn.portal.system' key='GRN_POT_SY-428' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.portal.system' key='GRN_POT_SY-429' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.portal.system' key='GRN_POT_SY-430' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.portal.system' key='GRN_POT_SY-431' replace='true'}{/capture}
{grn_radio name='security_model' id='grant' value='grant' caption=$smarty.capture.grant_caption checked=$is_grant}<br>
{grn_radio name='security_model' id='revoke' value='revoke' caption=$smarty.capture.revoke_caption checked=$is_revoke}<br>
</td>
</tr>
<tr>
<td></td>
<td>
{capture name='grn_portal_system_GRN_POT_SY_432'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-432' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_portal_system_GRN_POT_SY_432}
{grn_button_cancel}
</td>
</tr>
</table>

</form>

{include file='grn/system_footer.tpl'}

{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='portal/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="security_model" value="{$security_model}">

{capture name="grant_caption"}{cb_msg module='grn.portal.system' key='GRN_POT_SY-390' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.portal.system' key='GRN_POT_SY-391' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.portal.system' key='GRN_POT_SY-392' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.portal.system' key='GRN_POT_SY-393' replace='true'}{/capture}

<div class="explanation">{cb_msg module='grn.portal.system' key='GRN_POT_SY-394' replace='true'}<span class="bold">{if $security_model eq 'grant'}{$smarty.capture.grant_caption|grn_noescape}{elseif  $security_model eq 'revoke'}{$smarty.capture.revoke_caption|grn_noescape}{/if}</span>{cb_msg module='grn.portal.system' key='GRN_POT_SY-395' replace='true'}</div>
<div class="attention">{cb_msg module='grn.portal.system' key='GRN_POT_SY-396' replace='true'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-397' replace='true'}</div>

{capture name='grn_portal_system_GRN_POT_SY_398'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-398' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_398}
{capture name='grn_portal_system_GRN_POT_SY_399'}{cb_msg module='grn.portal.system' key='GRN_POT_SY-399' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_portal_system_GRN_POT_SY_399}

</form>

{include file='grn/system_footer.tpl'}

{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='phonemessage/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="tid" value="{$target|escape}">
<input type="hidden" name="oid" value="{$org_id|escape}">
<input type="hidden" name="uid" value="{$user_id|escape}">
<input type="hidden" name="rid" value="{$role_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="security_model" value="{$security_model}">

<div class="explanation">
{if 'grant' == $security_model}
    {capture name="security_model"}{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-1' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-2' replace='true'}{/capture}
{elseif 'revoke' == $security_model}
    {capture name="security_model"}{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-3' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-4' replace='true'}{/capture}
{/if}

{include file='phonemessage/system/_access_object_name.tpl'}
{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-5' replace='true'}<span class="bold">{$smarty.capture.security_model|grn_noescape}</span>{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-6' replace='true'}

<div class="attention">
{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-7' replace='true'}
{include file='phonemessage/system/_access_object_name.tpl'}
{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-8' replace='true'}
</div>

</div>

{capture name='grn_phonemessage_system_GRN_PHM_SY_9'}{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-9' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_phonemessage_system_GRN_PHM_SY_9}
{capture name='grn_phonemessage_system_GRN_PHM_SY_10'}{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-10' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_phonemessage_system_GRN_PHM_SY_10}

</form>

{include file='grn/system_footer.tpl'}

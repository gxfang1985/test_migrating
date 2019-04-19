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
{foreach from=$eid item=item}
<input type="hidden" name="eid[]" value="{$item|escape}">
{/foreach}

<div class="explanation">
{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-68' replace='true'}
{include file='phonemessage/system/_access_object_name.tpl'}
{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-17' replace='true'}<span class="bold">{$count}</span>{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-18' replace='true'}
</div>

{capture name='grn_phonemessage_system_GRN_PHM_SY_19'}{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-19' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_phonemessage_system_GRN_PHM_SY_19}
{capture name='grn_phonemessage_system_GRN_PHM_SY_20'}{cb_msg module='grn.phonemessage.system' key='GRN_PHM_SY-20' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_phonemessage_system_GRN_PHM_SY_20}

</form>

{include file='grn/system_footer.tpl'}

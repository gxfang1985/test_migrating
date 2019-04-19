{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="tid" value="{$target|escape}">
<input type="hidden" name="oid" value="{$org_id|escape}">
<input type="hidden" name="fagid" value="{$fgroup_id|escape}">
<input type="hidden" name="uid" value="{$user_id|escape}">
<input type="hidden" name="rid" value="{$role_id|escape}">
<input type="hidden" name="faid" value="{$facility_id|escape}">
<input type="hidden" name="poid" value="{$poid|escape}">
<input type="hidden" name="security_model" value="{$security_model}">

<div class="explanation">
{capture name="grant_caption"}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-11' replace='true'}{cb_msg module="grn.common" key="grant"}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-12' replace='true'}{/capture}
{capture name="revoke_caption"}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-13' replace='true'}{cb_msg module="grn.common" key="revoke"}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-14' replace='true'}{/capture}

{include file='schedule/system/_schedule_user_name.tpl'}
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-15' replace='true'}<span class="bold">{if $is_grant}{$smarty.capture.grant_caption|grn_noescape}{elseif $is_revoke}{$smarty.capture.revoke_caption|grn_noescape}{/if}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-16' replace='true'}

<div class="attention">
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-17' replace='true'}
{include file='schedule/system/_schedule_user_name.tpl'}
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-18' replace='true'}
</div>

</div>

{capture name='grn_schedule_system_GRN_SCH_SY_19'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-19' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_19 id="`$page_info.all`_submit"}
{capture name='grn_schedule_system_GRN_SCH_SY_20'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-20' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_20}

</form>

{include file='grn/system_footer.tpl'}

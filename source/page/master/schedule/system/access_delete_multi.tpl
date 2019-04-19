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
{foreach from=$eid item=item}
<input type="hidden" name="eid[]" value="{$item|escape}">
{/foreach}

<div class="explanation">
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-570' replace='true'}
{include file='schedule/system/_schedule_user_name.tpl'}
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-100' replace='true'}<span class="bold">{$count}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-101' replace='true'}
</div>

{capture name='grn_schedule_system_GRN_SCH_SY_102'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-102' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_102}
{capture name='grn_schedule_system_GRN_SCH_SY_103'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-103' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_103}

</form>

{include file='grn/system_footer.tpl'}

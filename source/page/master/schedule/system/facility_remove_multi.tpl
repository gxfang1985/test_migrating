{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="oid" value="{$org_id|escape}">

{foreach from=$fid_list item=fid}
<input type="hidden" name="fid[]" value="{$fid|escape}">
{/foreach}

<div class="explanation">
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-252' replace='true'}{grn_image image="facilitygroup20.gif"}<span class="bold">{$fgroup_name}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-253' replace='true'}<span class="bold">{$facility_count|escape}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-254' replace='true'}
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-255' replace='true'}
</div>

<p>
{capture name='grn_schedule_system_GRN_SCH_SY_256'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-256' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_256}
{capture name='grn_schedule_system_GRN_SCH_SY_257'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-257' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_257}
</p>
</form>

{include file="grn/system_footer.tpl"}

{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{if ! $privilege_info.count}
 <p>
{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-379' replace='true'}
</p>
 <p>
  {capture name='grn_schedule_system_GRN_SCH_SY_380'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-380' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_380}
 </p>
{else}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-381' replace='true'}<span class="bold">{grn_image image='facilitygroup20.gif'}{$node.name|escape:"html"}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-382' replace='true'}<span class="bold">{$privilege_info.count}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-383' replace='true'}</p>
 <p>
  {capture name='grn_schedule_system_GRN_SCH_SY_384'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-384' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_384}
  {capture name='grn_schedule_system_GRN_SCH_SY_385'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-385' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_385}
 </p>
 {foreach from=$privilege_info.list item=eid}
<input type="hidden" name="eid[]" value="{$eid}">
 {/foreach}
<input type="hidden" name="nid" value="{$node.id}">
</form>
{/if}
{include file="grn/system_footer.tpl"}

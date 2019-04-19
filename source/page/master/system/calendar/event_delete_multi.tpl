{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/calendar/command_event_delete_multi'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="scid" value="{$scid}">
<input type="hidden" name="bdate" value="{$bdate}">
 <p>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-39' replace='true'}<b>{grn_image image='calendar20.gif'}{grn_system_calendar_name scid=$scid}</b>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-40' replace='true'}<span class="bold">{$events.delete_numbers}</span>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-41' replace='true'}</p>
 <p>
  {capture name='grn_system_calendar_GRN_SY_CA_42'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-42' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_42}
  {capture name='grn_system_calendar_GRN_SY_CA_43'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-43' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_43}
 </p>
{foreach from=$events.event item=eid}
<input type="hidden" name="eid[]" value="{$eid}">
{/foreach}
</form>
{include file='grn/system_footer.tpl'}

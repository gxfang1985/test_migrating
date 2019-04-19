{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='system/calendar/command_delete'}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-23' replace='true'}<span class="bold">{grn_sentence  image='calendar20.gif' caption=$calendar.title}</span>{cb_msg module='grn.system.calendar' key='GRN_SY_CA-24' replace='true'}
 <div class="attention">{cb_msg module='grn.system.calendar' key='GRN_SY_CA-25' replace='true'}</div>
 </p>
 <p>
  {capture name='grn_system_calendar_GRN_SY_CA_26'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-26' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_26}
  {capture name='grn_system_calendar_GRN_SY_CA_27'}{cb_msg module='grn.system.calendar' key='GRN_SY_CA-27' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_system_calendar_GRN_SY_CA_27}
 </p>
<input type="hidden" name="scid" value="{$calendar.id}">
</form>
{include file='grn/system_footer.tpl'}

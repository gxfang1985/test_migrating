{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="fagid" value="{$facility_group.fagid}">
 <p>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-386' replace='true'}<span class="bold">{grn_sentence caption=$facility_group.title image='facilitygroup20.gif'}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-387' replace='true'}</p>
 <p>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-388' replace='true'}<br />{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-389' replace='true'}</p>
 <p>
  {capture name='grn_schedule_system_GRN_SCH_SY_390'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-390' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_390}
  {capture name='grn_schedule_system_GRN_SCH_SY_391'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-391' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_391}
 </p>
</form>
{include file='grn/system_footer.tpl'}

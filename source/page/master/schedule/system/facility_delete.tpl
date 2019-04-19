{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="faid" value="{$facility.faid}">
 <p>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-176' replace='true'}<span class="bold">{grn_sentence caption=$facility.title image='facility20.gif'}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-177' replace='true'}</p>
 <p>
  {capture name='grn_schedule_system_GRN_SCH_SY_178'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-178' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_178}
  {capture name='grn_schedule_system_GRN_SCH_SY_179'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-179' replace='true'}{/capture}{grn_button_cancel class="margin" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_179}
 </p>
</form>
{include file='grn/system_footer.tpl'}

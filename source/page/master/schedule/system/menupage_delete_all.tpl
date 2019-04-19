{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
{include file='grn/show_validation_errors.tpl'}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-25' replace='true'}</p>
 <p>
  {capture name='grn_schedule_system_GRN_SCH_SY_26'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-26' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_26}
  {capture name='grn_schedule_system_GRN_SCH_SY_27'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-27' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_27}
 </p>
{foreach from=$menu.menupage item=eid}
<input type="hidden" name="eid[]" value="{$eid}">
{/foreach}
</form>
{include file='grn/system_footer.tpl'}

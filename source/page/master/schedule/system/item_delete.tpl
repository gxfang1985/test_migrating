{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}

{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-146' replace='true'}<span class="bold">{$item.display_name|escape}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-147' replace='true'}</p>
 <p>
   {capture name='grn_schedule_system_GRN_SCH_SY_148'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-148' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_148}
   {capture name='grn_schedule_system_GRN_SCH_SY_149'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-149' replace='true'}{/capture}{grn_button_cancel class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_149}
 </p>
<input type="hidden" name="eiid" value="{$extended_item_id}">
</form>

{include file='grn/system_footer.tpl'}

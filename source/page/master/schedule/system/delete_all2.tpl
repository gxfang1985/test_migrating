{include file='grn/system_head.tpl'}
{include file='grn/system_header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$page_info.all}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
 <p class="explanation">
  {cb_msg module='grn.schedule.system' key='GRN_SCH_SY-569' replace='true'}<span class="bold">{$str_date}</span>&nbsp;{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-464' replace='true'}
  <div class="attention">{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-465' replace='true'}</div>
 </p>
 <p>
  {capture name='grn_schedule_system_GRN_SCH_SY_466'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-466' replace='true'}{/capture}{grn_button_submit class='margin' caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_466}
  {capture name='grn_schedule_system_GRN_SCH_SY_467'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-467' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_467 page='system/application_list' app_id='schedule'}
 </p>
 </div>
 <!--action_end--->
</div>
<input type="hidden" name="date" value="{$date}">
</form>
{include file='grn/system_footer.tpl'}

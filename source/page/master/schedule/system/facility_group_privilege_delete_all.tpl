{include file="grn/system_head.tpl"}
{include file="grn/system_header.tpl"}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var="form_name" value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/system/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
 <p>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-331' replace='true'}<span class="bold">{grn_image image='facilitygroup20.gif'}{$node.name|escape:"html"}</span>{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-332' replace='true'}</p>
 <p>
  {capture name='grn_schedule_system_GRN_SCH_SY_333'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-333' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_333}
  {capture name='grn_schedule_system_GRN_SCH_SY_334'}{cb_msg module='grn.schedule.system' key='GRN_SCH_SY-334' replace='true'}{/capture}{grn_button_cancel caption=$smarty.capture.grn_schedule_system_GRN_SCH_SY_334}
 </p>
<input type="hidden" name="nid" value="{$node.id}">
</form>
{include file="grn/system_footer.tpl"}

{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<div id="one_parts">
 <div id="action">
  <!----->
   {grn_change_order form_name=$form_name select_name='fagids[]' options=$facility_group.facilitygroup}
  <!----->
 </div>
</div>
<p>
 {capture name='grn_schedule_operation_GRN_SCH_OP_21'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-21' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_21 onclick="grn_onsubmit_common(this.form);"}
 {grn_button_cancel}
</p>
<input type="hidden" name="fagid" value="{$facility_group.fagid}">
</form>
{include file='grn/footer.tpl'}


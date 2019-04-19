{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="fagid" value="{$facility_group.fagid}">

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr valign="top">
  <th nowrap>
      {capture name='grn_schedule_operation_GRN_SCH_OP_1'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-1' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_1}
  </th>
  <td>
      {capture name='grn_schedule_operation_GRN_SCH_OP_2'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-2' replace='true'}{/capture}
      {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_2 values=$multiLanguageInfoArray.values}
  </td>
 </tr>

 <tr valign="top">
  <th nowrap>
      {capture name='grn_schedule_operation_GRN_SCH_OP_3'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-3' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_3 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_schedule_operation_GRN_SCH_OP_4'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-4' replace='true'}{/capture}{validate form=$form_name field='facility_group_code' criteria="notEmpty" message=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_4 transform="cb_trim" append='validation_errors'}{grn_text necessary=true name="facility_group_code" value=$facility_group.code size="50" disable_return_key=true}<br> 
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-5' replace='true'}</div>
  </td>
 </tr>

 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-6' replace='true'}
  </th>
  <td>
      {grn_textarea name="memo" value=$facility_group.memo rows="5"}
  </td>
 </tr>

 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-7' replace='true'}
  </th>
  <td>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-8' replace='true'}{foreach from=$facility_group.ancestors item=facility} > {grn_sentence caption=$facility.title class='facility20'}{/foreach}<br>
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-9' replace='true'}</div>
  </td>
 </tr>

 <tr>
  <td></td>
  <td>
       {capture name='grn_schedule_operation_GRN_SCH_OP_10'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-10' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_10}
       {grn_button_cancel page='schedule/operation/facility_group_view' fagid=$facility_group.fagid}
  </td>
 </tr>

</table>

</form>

{include file='grn/footer.tpl'}

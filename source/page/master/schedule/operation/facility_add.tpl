{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">

<p><div class="explanation">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-94' replace='true'}</div></p>

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_schedule_operation_GRN_SCH_OP_95'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-95' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_95}
  </th>
  <td>
      {capture name='grn_schedule_operation_GRN_SCH_OP_96'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-96' replace='true'}{/capture}
      {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_96 values=$multiLanguageInfoArray.values}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_schedule_operation_GRN_SCH_OP_97'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-97' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_97 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_schedule_operation_GRN_SCH_OP_98'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-98' replace='true'}{/capture}{validate form=$form_name field="facility_code" criteria="notEmpty" message=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_98 transform="cb_trim" append="validation_errors"}{grn_text necessary=true name="facility_code" value=$facility.code size="50" disable_return_key=true}
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-99' replace='true'}
  </th>
  <td>
      {grn_textarea name="memo" value=$facility.memo rows="5"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-100' replace='true'}
  </th>
  <td>
  <input type="hidden" name="fagid" value="{$fagid}" />
  {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-101' replace='true'}{foreach from=$facility_group item='group'} &gt; {$group.col_name} {/foreach}

  </td>
 </tr>
{*--- add VCBSCH0010 ---s*}
{include file='schedule/system/_netmeeting_facility.tpl'}
{*--- add VCBSCH0010 ---e*}
 <tr>
  <td></td>
  <td>
       {capture name='grn_schedule_operation_GRN_SCH_OP_102'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-102' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_102}
       {grn_button_cancel page='schedule/operation/facility_list' oid=$facility_group_select sf=1}
  </td>
 </tr>
</table>

</form>

{include file='grn/footer.tpl'}

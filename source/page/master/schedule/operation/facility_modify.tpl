{include file='grn/head.tpl'}
{include file='grn/header.tpl'}
{grn_title title=$page_title class=$page_info.parts[0]}
{assign var='form_name' value=$smarty.template|basename}
<form name="{$form_name}" method="post" action="{grn_pageurl page='schedule/operation/command_'|cat:$page_info.last}"><input type="hidden" name="csrf_ticket" value="{$csrf_ticket}">
<input type="hidden" name="faid" value="{$facility.faid}">
<input type="hidden" name="fagid" value="{$facility.fagid}">

<p><div class="explanation">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-133' replace='true'}</div></p>

<p>
{include file='grn/show_validation_errors.tpl'}
{include file='grn/indispensable.tpl'}
<table class="std_form">
 <tr>
  <th nowrap>
      {capture name='grn_schedule_operation_GRN_SCH_OP_134'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-134' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_134}
  </th>
  <td>
      {capture name='grn_schedule_operation_GRN_SCH_OP_135'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-135' replace='true'}{/capture}
      {grn_text_multilanguage element_name=$multiLanguageInfoArray.element_name form_name=$form_name error_message=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_135 values=$multiLanguageInfoArray.values}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {capture name='grn_schedule_operation_GRN_SCH_OP_136'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-136' replace='true'}{/capture}{grn_show_input_title title=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_136 necessary=TRUE}
  </th>
  <td>
      {capture name='grn_schedule_operation_GRN_SCH_OP_137'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-137' replace='true'}{/capture}{validate form=$form_name field="facility_code" criteria="notEmpty" message=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_137 transform="cb_trim" append="validation_errors"}{grn_text necessary=true name="facility_code" value=$facility.code size="50" disable_return_key=true}
   <div class="br">&nbsp;</div>
   <div class="sub_explanation">{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-138' replace='true'}</div>
  </td>
 </tr>
 <tr valign="top">
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-139' replace='true'}
  </th>
  <td>
      {grn_textarea name="memo" value=$facility.memo rows="5"}
  </td>
 </tr>
 <tr>
  <th nowrap>
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-140' replace='true'}
  </th>
  <td>
      {if $facility.ancestors}
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-141' replace='true'}
      {foreach from=$facility.ancestors item=group} &gt; {$group.title} {/foreach}
      {else}
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-142' replace='true'}
      {/if} <br />
      {cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-143' replace='true'}
  </td>
 </tr>
{*--- add VCBSCH0010 ---s*}
{include file='schedule/system/_netmeeting_facility.tpl'}
{*--- add VCBSCH0010 ---e*}
 <tr>
  <td></td>
  <td>
       {capture name='grn_schedule_operation_GRN_SCH_OP_144'}{cb_msg module='grn.schedule.operation' key='GRN_SCH_OP-144' replace='true'}{/capture}{grn_button_submit class="margin" caption=$smarty.capture.grn_schedule_operation_GRN_SCH_OP_144}
       {grn_button_cancel page='schedule/operation/facility_view' faid=$facility.faid fagid=$facility.fagid}
  </td>
 </tr>
</table>

</form>

{include file='grn/footer.tpl'}
